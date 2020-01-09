Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E70C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60832067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAYGapvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60832067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWbz-0001r3-S7
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWas-00012J-UJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWar-0000Bw-Po
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:07:18 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipWar-00009S-HO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:07:17 -0500
Received: by mail-oi1-x241.google.com with SMTP id i1so5611529oie.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=pxNPlYmQh/ruu8LSu6F4bstrduLnhfbNaHKSBxbive8=;
 b=UAYGapvka9qzLKMZxTuW+Q0+nvzyPoCLatQ6KIZrp8hpb2Ffa3snYv+onQc3g0UzCK
 hwPw9jM9bMptK5Y9p7Cv8c8QSTaQSZkS08IJEmQuel3GKh27y06dPkECAuNCTzjiaY7z
 6yksMigQV2jh1HLEaoKC6WZUCSn8STm0Qw7Ss04jGdXOeSHrIGkQWWuC094677fJ0hcR
 6t1lTCAJFLHOfmnh9dkMmH3ueXUsbi5eGuYmFV7/jUO6qCluQgGYYEHaVqLVT8wTRICh
 kMBvhAnyVosOqWmyxg0G5X7OPNG4zY/4tlis5sJ5aeB6/54tEW1Y9/MzW6VMZbBrYRKX
 +uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=pxNPlYmQh/ruu8LSu6F4bstrduLnhfbNaHKSBxbive8=;
 b=ACHKLf+oqS+1c3yHlcnm2c+FQyfWkV5mqmGHmhNw2xFSS9H3esDtguoZARpDddn7nr
 pWRIpzkz1AJ2vsSiUCUD5bVowhD+bIezlkOeN5FTkCWcAS4be/YOFItm52nZSCBgUP4k
 lA+FNQBbFaE1rTzvBHorbCakvbJN2ZmecF9frUQIm5GJue1UsgHHGjGzJqBVFEenxW/F
 6YKhB5wD2QNOzz/cJ+8Rn6Hc7xF8hVii037Z7nlux+6IEAXlI7bO31cQ6wzEaQQUR0h0
 5an9MFkdix2t73p+9hqjl2MmI+kIYExaVVdPFk/Mz1UVGNpm2rRmxLXtRcF9XigjD9cM
 gYrw==
X-Gm-Message-State: APjAAAUzyDYjYa1ByxMK/4JpXjBSbAKEXy83Qhb7abZx34n/QX9tAbP/
 Uf+vMmCb8w1Y/3DV12A0HZg0rV/HUvlxThTNYJI=
X-Google-Smtp-Source: APXvYqy5STR5EkZhVQcQV4tKwrrne3Kyc2hto4Brp+xC0pZFDYLTKaZZbrFHgT9k2aGWk3JtGk1Jao1HcoGQ6s3Jn+4=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr2667055oih.79.1578571636816; 
 Thu, 09 Jan 2020 04:07:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 04:07:16 -0800 (PST)
In-Reply-To: <20200109021710.1219-4-richard.henderson@linaro.org>
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-4-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 13:07:16 +0100
Message-ID: <CAL1e-=iMxSC4EyPycwd1wpuW2qR7KQ7SbnWvvv3p7JZxVuJPHQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] vl: Remove useless test in configure_accelerators
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000aa3fe6059bb3d98f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aa3fe6059bb3d98f
Content-Type: text/plain; charset="UTF-8"

On Thursday, January 9, 2020, Richard Henderson <
richard.henderson@linaro.org> wrote:

> The result of g_strsplit is never NULL.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/vl.c b/vl.c
> index c9329fe699..887dbfbb5d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2776,7 +2776,7 @@ static void configure_accelerators(const char
> *progname)
>
>          accel_list = g_strsplit(accel, ":", 0);
>
> -        for (tmp = accel_list; tmp && *tmp; tmp++) {
> +        for (tmp = accel_list; *tmp; tmp++) {
>              /*
>               * Filter invalid accelerators here, to prevent obscenities
>               * such as "-machine accel=tcg,,thread=single".
> --
> 2.20.1
>
>
>

--000000000000aa3fe6059bb3d98f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 9, 2020, Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">The result of g_strsplit is never NULL.=
<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0vl.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
diff --git a/vl.c b/vl.c<br>
index c9329fe699..887dbfbb5d 100644<br>
--- a/vl.c<br>
+++ b/vl.c<br>
@@ -2776,7 +2776,7 @@ static void configure_accelerators(const char *progna=
me)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0accel_list =3D g_strsplit(accel, &quot;:&=
quot;, 0);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (tmp =3D accel_list; tmp &amp;&amp; *tmp; =
tmp++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (tmp =3D accel_list; *tmp; tmp++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Filter invalid accelerat=
ors here, to prevent obscenities<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * such as &quot;-machine a=
ccel=3Dtcg,,thread=3Dsingle&quot;.<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--000000000000aa3fe6059bb3d98f--

