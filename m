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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED98C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097782075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOh+erQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097782075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWay-0000s3-4I
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWZx-0007a7-G4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWZw-0004RQ-6x
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:06:21 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipWZv-0004NP-Rq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:06:20 -0500
Received: by mail-ot1-x344.google.com with SMTP id 66so6973093otd.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=CWJIODVnrXvstJruN4vLTNorc0HpIa9vnRmbcZWVP/s=;
 b=eOh+erQXnQQxwMG4YrOXBpKvEJyP/VH3tG7EbIBamB7+9w6W2hzwEuGQpZzxQeUqir
 QbyJMdWD7Q3FevjI6ZhjNr8QnHmOcYA2cSNitCTovHWyKuOegjl6CdA7MxxOm5RYWxG1
 7F/cVdet03Q4BtIBkoy3AN0hkXO6n/FYsHgjlpp4/hpfrOxWBV+9m0dA/n4Wz3T8ae5f
 Y1qD0eqQGSMDsNSveX9yG+HqboFGb6FW2jRNcKIrns4nXBDgAseht9qsb2qW+eksPAWz
 41NuhsK4k5VgHu0r+bnJY+rk+SOF0lRS6DzWo4K0EKRqZQ068VVYNrqW9GKW78pre5rp
 Zhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=CWJIODVnrXvstJruN4vLTNorc0HpIa9vnRmbcZWVP/s=;
 b=m0iDe1/i8i4HyqGvyNCKGrU5++DfXwlLJmLNurSN7O6LKyMzkXBe8NPY/O37WAZ7p4
 pC8XQrDYB7JbsZ3CS3roXd5bHDT14htfskTlVGEB3dvPzo3OSQ90jPG2rGIx50kElSdr
 EG2JgmDCDob8CTPbDL5RxB43VIZCXdwvNR5YakG9LeCm6dUuNLTJIhfuTozzNT6Am2kz
 lXLmqWs69/A++l0nHxtlv/sB7gKb025zmOA7L9UCFpK9kcwXoI/oX2KpdLQq8bljto8p
 Wbr09NgdQjGoVa+gSgddbXomCoY2tCfYeH0N/RUSlKCmZh3SaOcyyBQgm3gPnRbhhMx5
 uAhA==
X-Gm-Message-State: APjAAAWq77qmbXAlMVJJ9GUZzjq8Pq2vPBOaR79yuGXW7TrY0wbkdd3l
 azt9Gdtcd69dImlccsCFB3kka4IRgVhrmofte28=
X-Google-Smtp-Source: APXvYqxeaOBUjoAosYx/OoE41BipZYqcRmFpd0rmV0irgFR5TPyMwP9Rv5bMAaInTGWOTeRMig0U51UPQ9dRNs/1RSk=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr7921645otk.64.1578571578890;
 Thu, 09 Jan 2020 04:06:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 04:06:18 -0800 (PST)
In-Reply-To: <20200109021710.1219-2-richard.henderson@linaro.org>
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-2-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 13:06:18 +0100
Message-ID: <CAL1e-=hrS87PtxaLMqOZokGtd+Hbv9M596ENiEgQkyzcJ_T2KQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] vl: Remove unused variable in configure_accelerators
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000365e9b059bb3d62d"
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 2607:f8b0:4864:20::344
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

--000000000000365e9b059bb3d62d
Content-Type: text/plain; charset="UTF-8"

On Thursday, January 9, 2020, Richard Henderson <
richard.henderson@linaro.org> wrote:

> The accel_initialised variable no longer has any setters.
>
> Fixes: 6f6e1698a68c
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  vl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/vl.c b/vl.c
> index 86474a55c9..be79b03c1a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2749,7 +2749,6 @@ static void configure_accelerators(const char
> *progname)
>  {
>      const char *accel;
>      char **accel_list, **tmp;
> -    bool accel_initialised = false;
>      bool init_failed = false;
>
>      qemu_opts_foreach(qemu_find_opts("icount"),
> @@ -2776,7 +2775,7 @@ static void configure_accelerators(const char
> *progname)
>
>          accel_list = g_strsplit(accel, ":", 0);
>
> -        for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
> +        for (tmp = accel_list; tmp && *tmp; tmp++) {
>              /*
>               * Filter invalid accelerators here, to prevent obscenities
>               * such as "-machine accel=tcg,,thread=single".
> --
> 2.20.1
>
>
>

--000000000000365e9b059bb3d62d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 9, 2020, Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">The accel_initialised variable no longe=
r has any setters.<br>
<br>
Fixes: 6f6e1698a68c<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0vl.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
diff --git a/vl.c b/vl.c<br>
index 86474a55c9..be79b03c1a 100644<br>
--- a/vl.c<br>
+++ b/vl.c<br>
@@ -2749,7 +2749,6 @@ static void configure_accelerators(const char *progna=
me)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *accel;<br>
=C2=A0 =C2=A0 =C2=A0char **accel_list, **tmp;<br>
-=C2=A0 =C2=A0 bool accel_initialised =3D false;<br>
=C2=A0 =C2=A0 =C2=A0bool init_failed =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_opts_foreach(qemu_find_<wbr>opts(&quot;icount&quot=
;),<br>
@@ -2776,7 +2775,7 @@ static void configure_accelerators(const char *progna=
me)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0accel_list =3D g_strsplit(accel, &quot;:&=
quot;, 0);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (tmp =3D accel_list; !accel_initialised &a=
mp;&amp; tmp &amp;&amp; *tmp; tmp++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (tmp =3D accel_list; tmp &amp;&amp; *tmp; =
tmp++) {<br>
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

--000000000000365e9b059bb3d62d--

