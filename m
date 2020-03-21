Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A6EC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A22820754
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMExGJGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A22820754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFclW-00029W-7W
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFcjx-0001H1-4P
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFcjv-0002Zo-Vj
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:56:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFcjv-0002Yp-OJ; Sat, 21 Mar 2020 07:56:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id h4so10670043wru.2;
 Sat, 21 Mar 2020 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B5edknIRGTKD8fS/EnDqQ5YjXChVWPbyTu5GtaXjua4=;
 b=CMExGJGmX4wFvVCh1lyksF8s0UpHVsrZ8LSez4ZHwov9NnMzF6SptmZ4r8qC9YmR43
 7c+Fz2mNL5JA3b3KWkSa2hfJDriTVkk0R7i6eAV7Q+qtmjpZqkMXhbfyQMFdzerWGdU4
 jXYJH4D5eBGwbC1LBhnq5it9fdfIcP1QpZCIsY8LPgNVJMIlkevJAinmvOHTR01lPR+6
 J28Vg9xS1u1aL1WvnMUiFu4XZgRlBZb6y/SLyklEbmTKpasR9JwtIeqTELrLyvY8ssxS
 F4TsVF7z5SSc8FVo2IgOFtyN9NwQ+bxAv2nkkYOjgDn+DRBqBsRyHf3xIO8YJrSzS+lv
 eLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B5edknIRGTKD8fS/EnDqQ5YjXChVWPbyTu5GtaXjua4=;
 b=bWQouokqYqCQ8QoxrxMv14meiuA0P91eNgUVgelUg07IKKR69nrsQ7HA1IafWCXJV/
 BQ53vM1ER/og3IHY4ZitNaMgbgpDSxVnVuH8XeleLhzZtbT6y6JYqWGhSMKbqdfBjfdK
 dd3zR4A3W//lJqG4d/LVxJ6W0PRndnxq5kIM3dsrYiWP7JQC9uUwTybcdxfA5PPOp4Lo
 bYq/dR1sQ/2Qe/45j5kMoq0fnvFlG0Lld0blzPhpXgqn1ChbWqM7To5a3rfw3EDdHKgL
 8ZTLiOkuXNIUFMVd5usk7bSBMouwzookawW1HVLOoaf+doYpURgnnRXgqM6GIRs20LuV
 S9kQ==
X-Gm-Message-State: ANhLgQ0peh1mLQguQFTDx8yfaXE4MBtaVphHbCmX3iEF66XyK9hbdWd5
 07eNPQkUZPOPhN8cXar9cozETzF8ijA95ob6Csk=
X-Google-Smtp-Source: ADFU+vsWxSbQlk3QWjpNKo06YGyuhMUz00W9s1s/UfYQTGKDk0Zina5jWqhcn07gpJlU4AA7ePQK3HgUH80rp7Wg47Y=
X-Received: by 2002:adf:efc2:: with SMTP id i2mr15422825wrp.420.1584791790814; 
 Sat, 21 Mar 2020 04:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200321114615.5360-1-philmd@redhat.com>
 <20200321114615.5360-2-philmd@redhat.com>
In-Reply-To: <20200321114615.5360-2-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 21 Mar 2020 12:56:11 +0100
Message-ID: <CAHiYmc5gpHCUfc5bPMs8Qa7NETYkkj8rfV5dTyqZF4ZQTeNa8Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 01/11] block: Remove dead assignment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bc0aed05a15c17c2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bc0aed05a15c17c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12:49 PM Sub, 21.03.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Fix warning reported by Clang static code analyzer:
>
>   block.c:3167:5: warning: Value stored to 'ret' is never read
>       ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
>       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer

Peter, and others,

Is this allowed use of "Reported-by:" mark?

I did not notice it being used this way before. And was under impression
that all similar tags/marks must be followed by a person, not a tool.

Regards,
Aleksandar

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block.c b/block.c
> index a2542c977b..908c109a8c 100644
> --- a/block.c
> +++ b/block.c
> @@ -3164,7 +3164,7 @@ static BlockDriverState *bdrv_open_inherit(const
char *filename,
>                                      parent->open_flags, parent->options)=
;
>      }
>
> -    ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
> +    bdrv_fill_options(&options, filename, &flags, &local_err);
>      if (local_err) {
>          goto fail;
>      }
> --
> 2.21.1
>
>

--000000000000bc0aed05a15c17c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">12:49 PM Sub, 21.03.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a=
 href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Fix warning reported by Clang static code analyzer:<br>
&gt;<br>
&gt; =C2=A0 block.c:3167:5: warning: Value stored to &#39;ret&#39; is never=
 read<br>
&gt; =C2=A0 =C2=A0 =C2=A0 ret =3D bdrv_fill_options(&amp;options, filename,=
 &amp;flags, &amp;local_err);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 ^=C2=A0 =C2=A0 =C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt;<br>
&gt; Reported-by: Clang Static Analyzer</p>
<p dir=3D"ltr">Peter, and others,</p>
<p dir=3D"ltr">Is this allowed use of &quot;Reported-by:&quot; mark?</p>
<p dir=3D"ltr">I did not notice it being used this way before. And was unde=
r impression that all similar tags/marks must be followed by a person, not =
a tool.</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0block.c | 2 +-<br>
&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/block.c b/block.c<br>
&gt; index a2542c977b..908c109a8c 100644<br>
&gt; --- a/block.c<br>
&gt; +++ b/block.c<br>
&gt; @@ -3164,7 +3164,7 @@ static BlockDriverState *bdrv_open_inherit(const=
 char *filename,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parent-&gt;op=
en_flags, parent-&gt;options);<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 ret =3D bdrv_fill_options(&amp;options, filename, &amp;=
flags, &amp;local_err);<br>
&gt; +=C2=A0 =C2=A0 bdrv_fill_options(&amp;options, filename, &amp;flags, &=
amp;local_err);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br>
&gt;<br>
</p>

--000000000000bc0aed05a15c17c2--

