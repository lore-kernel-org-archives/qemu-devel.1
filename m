Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E538C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FE2206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FE2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Ree-00043d-FZ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1k0Re3-0003ZA-PB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:35:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1k0Re1-0003vk-Nu
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:35:59 -0400
Received: from mail-vk1-f200.google.com ([209.85.221.200])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1k0Rdy-0006dB-Tj
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:35:55 +0000
Received: by mail-vk1-f200.google.com with SMTP id b128so6606975vka.17
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 08:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mFDQCktakhwVAEppX4yHYmu7f/9fuhVpPW+ZcqQ6Fy8=;
 b=P/SLq9YfcJN1WiVQpcm5iKYwLD6NTOxC3FR4a6h84XQWrkqLMNWfk2WfKTX9TPjxhX
 0mkx7Q6AcNuLQSwJa9zIB5kcgDcLChmXmPx7oV5HIq8S0GwD5o3fW7Qa9SlFak3PsFY/
 Pb/bWxUW4Ctn9lbqFoxO/8Q/6USjnpvHNJoIzE98USRghMLv91EQuPJDSTMAUstzUZ1B
 iq6Jdjl116YcHyuaFYQ8QAugviQ/N9mjvIYKIvmsUfyHxYkTxVTMFOczgfd1/D6WY9d4
 g1nTdFrM+46OINMygsq9llBDvH8nAfUtvHA+diPvU2/p/Q/S9Hqox62DgbxYhTF5sFNH
 OoBw==
X-Gm-Message-State: AOAM530aPHxbWIsbJpMA7rJO4hlT9txVEs+BcHxw6L3YmmQB5dte2JWa
 gUdPz4kbOBTrbyjRTbQnq3NyjJlNlHDAGsElvD4TmhaoyKCSu7MMCfheEBKQsP72OdPxMkhZB1B
 pd+3GPuZl8T3Al/ZPbkKpCyg2CZZy88R9BZuC0A3IwHtDeLWe
X-Received: by 2002:a67:7c11:: with SMTP id x17mr9279186vsc.155.1595950552987; 
 Tue, 28 Jul 2020 08:35:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE4hXpi8ZhRKdev1JBjeH+pRijExT2OH39RSepmAtVrJyzxl1lmb4TLg3Z0GKc4Fnlhw5epC7fwhgP8irY1WY=
X-Received: by 2002:a67:7c11:: with SMTP id x17mr9279153vsc.155.1595950552621; 
 Tue, 28 Jul 2020 08:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200727122357.31263-1-alex.bennee@linaro.org>
 <20200727122357.31263-7-alex.bennee@linaro.org>
In-Reply-To: <20200727122357.31263-7-alex.bennee@linaro.org>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Tue, 28 Jul 2020 17:35:26 +0200
Message-ID: <CAATJJ0+umgefGS-sfAxbt1QhWwO4j5hcL0_Mq918wKc=_u7ZJg@mail.gmail.com>
Subject: Re: [PULL 06/16] accel/tcg: better handle memory constrained systems
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c4bd7605ab8231b7"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:35:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c4bd7605ab8231b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 2:24 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> It turns out there are some 64 bit systems that have relatively low
> amounts of physical memory available to them (typically CI system).
> Even with swapping available a 1GB translation buffer that fills up
> can put the machine under increased memory pressure. Detect these low
> memory situations and reduce tb_size appropriately.
>
> Fixes: 600e17b2615 ("accel/tcg: increase default code gen buffer size for
> 64 bit")
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Robert Foley <robert.foley@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Message-Id: <20200724064509.331-7-alex.bennee@linaro.org>
>

I beg your pardon for the late reply, but I was out a week.
I see this is already the pull request and my former feedback was included
- thanks.

Never the less I took the chance to test it in the context that I found and
reported the initial bug.
If only to show that I didn't fire&forget this case :-)

We know there is quite some noise/deviation, but I only ran single tests as
the problem was easily visible despite the noise. Amount of memory qemu
settles on:

Host 32G, Guest 512M
4.2        633M
5.0       1672M
5.0+ Fix  1670M

Host 1.5G, Guest 512M
4.2        692M
5.0       16xxM (OOM)
5.0+ Fix   766M

So we seem to have achieved that small environments no more break (a very
small amount of very densely sized systems might still) but at the same
time get the bigger cache for any normal/large system.
Tested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Reviewed-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>


> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 2afa46bd2b1..2d83013633b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t
> tb_size)
>  {
>      /* Size the buffer.  */
>      if (tb_size =3D=3D 0) {
> -        tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        size_t phys_mem =3D qemu_get_host_physmem();
> +        if (phys_mem =3D=3D 0) {
> +            tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        } else {
> +            tb_size =3D MIN(DEFAULT_CODE_GEN_BUFFER_SIZE, phys_mem / 8);
> +        }
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>          tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;
> --
> 2.20.1
>
>

--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000c4bd7605ab8231b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 27, 2020 at 2:24 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">It turns out there are some 64 bit systems that have relatively low<br=
>
amounts of physical memory available to them (typically CI system).<br>
Even with swapping available a 1GB translation buffer that fills up<br>
can put the machine under increased memory pressure. Detect these low<br>
memory situations and reduce tb_size appropriately.<br>
<br>
Fixes: 600e17b2615 (&quot;accel/tcg: increase default code gen buffer size =
for 64 bit&quot;)<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Reviewed-by: Robert Foley &lt;<a href=3D"mailto:robert.foley@linaro.org" ta=
rget=3D"_blank">robert.foley@linaro.org</a>&gt;<br>
Cc: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_bla=
nk">balaton@eik.bme.hu</a>&gt;<br>
Cc: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canonical.c=
om" target=3D"_blank">christian.ehrhardt@canonical.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20200724064509.331-7-alex.bennee@linaro.o=
rg" target=3D"_blank">20200724064509.331-7-alex.bennee@linaro.org</a>&gt;<b=
r></blockquote><div><br></div><div>I beg your pardon for the late reply, bu=
t I was out a week.</div><div>I see this is already the pull request and my=
 former feedback was included - thanks.</div><div><br></div><div>Never the =
less I took the chance to test it in the context that I found and reported =
the initial bug.</div><div>If only to show that I didn&#39;t fire&amp;forge=
t this case=C2=A0:-)</div><div><br></div><div>We know there is quite some n=
oise/deviation, but I only ran single tests as the problem was easily visib=
le despite the noise. Amount of memory qemu settles on:<br><br>Host 32G, Gu=
est 512M<br>4.2 =C2=A0 =C2=A0 =C2=A0 =C2=A0633M<br>5.0 =C2=A0 =C2=A0 =C2=A0=
 1672M<br>5.0+ Fix =C2=A01670M<br><br>Host 1.5G, Guest 512M<br>4.2 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0692M<br>5.0 =C2=A0 =C2=A0 =C2=A0 16xxM (OOM)<br>5.0+ Fi=
x =C2=A0 766M<br></div><div><br></div><div>So we seem to have achieved that=
 small environments no more break (a very small amount of very densely size=
d systems might still) but at the same time get the bigger cache for any no=
rmal/large system.</div><div>Tested-by: Christian Ehrhardt &lt;<a href=3D"m=
ailto:christian.ehrhardt@canonical.com">christian.ehrhardt@canonical.com</a=
>&gt;</div><div>Reviewed-by:=C2=A0Christian Ehrhardt &lt;<a href=3D"mailto:=
christian.ehrhardt@canonical.com">christian.ehrhardt@canonical.com</a>&gt;<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index 2afa46bd2b1..2d83013633b 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_si=
ze)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Size the buffer.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t phys_mem =3D qemu_get_host_physmem();<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (phys_mem =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D DEFAULT_CODE_GEN_BUF=
FER_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D MIN(DEFAULT_CODE_GEN=
_BUFFER_SIZE, phys_mem / 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size &lt; MIN_CODE_GEN_BUFFER_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Christian Ehrhardt<br>Staff Engineer, Ubuntu Ser=
ver<br>Canonical Ltd</div></div>

--000000000000c4bd7605ab8231b7--

