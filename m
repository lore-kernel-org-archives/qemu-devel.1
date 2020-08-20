Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D826C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032B520658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU6TH0dH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032B520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kbR-0007PW-5D
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k8kaa-0006a5-DF
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:26:44 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k8kaW-0001Wa-VM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:26:43 -0400
Received: by mail-ej1-x643.google.com with SMTP id t10so2483789ejs.8
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+S962aJNNgWPtU+ItmkjzD4kkWowo/62j2098jo/dfw=;
 b=jU6TH0dH1mg74r2OEeZt5YePJq5i9Dz3LdTt/GUJW+inINJDpwo3YOvL2XkpBz7emZ
 LBNCIRod/arXlXNCW454TMrLxnV4mGhy4wX/00+TEKfDdBmcFUC3OnXXeuF4m60E/7c9
 MNneZQUWmVTHwVlPbwU2qd/h716oyeT2L1BuHb671KIqlqTARPVK/ws/NbrxMjEVlXyo
 EKbGO7ceKs/NsL5wtBgJhsF+yV8mGht7NLSBTJs0fTQQraOT1b2r6dyJ4PMCq6Rvcvyu
 ZszdnqvbN3IOLWeRwXqzEH8+tBFUpDnAihC6ZewvsQiu9jAsqCM4w0Q2ljo90dq8ApI0
 A94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+S962aJNNgWPtU+ItmkjzD4kkWowo/62j2098jo/dfw=;
 b=JdIYO0kTLyAkNW1BJIs9lBI1WeG3xCAUBXK40iTONQZKptoFEGR75MKmAxtJoY3vit
 ATUTfnldhd2Cwtx2TjB+RDY7tJuS0JjSKtDlvzhiP1YSXvj2eB29gJ53ZTEypWgrciRK
 j8r8dFQE6JPr6FjrYISElC4OWT2JZ4wExvXGhG2LOIpY9cPLc1qEZ2YVVf5yZEE/nE71
 g4JQ40oCLp64YuRNkON+9YISLxEfntnGoC7bJg96EaoqqWky0zusfBC9FPKV/gCjrVi5
 zfI0sw91q6ln7vELR2byKn5V/PHnl2l03Zjnjy6A9OIBoR3F5zJcoC30jIhOhxtx06k+
 S/sQ==
X-Gm-Message-State: AOAM530EkmobtuqsgWjeGqdGSbMLnBFmu1ud5MmA6rHdYQy34VObgxEm
 Up5rPAMqFXqBvrZhMWTEpkpwouf0LXM1yeNdaJQ=
X-Google-Smtp-Source: ABdhPJxONsYsq/DvlX5wDjEIcM8OwJ+Tjo3sp6fWocs9dNFlhonUSluc5C10fZBDjjdSQhQvvH2Dss4YelbghrKdhQw=
X-Received: by 2002:a17:906:2796:: with SMTP id
 j22mr3449793ejc.532.1597929998499; 
 Thu, 20 Aug 2020 06:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200820130008.43754-1-fziglio@redhat.com>
In-Reply-To: <20200820130008.43754-1-fziglio@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Aug 2020 17:26:26 +0400
Message-ID: <CAJ+F1CKTrMPHqe88Y9pZxjgK1ik-13h4ZNXo_fMt84XJ1B=dNw@mail.gmail.com>
Subject: Re: [PATCH] ui: Add more mouse buttons to SPICE
To: Frediano Ziglio <fziglio@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000efc5e505ad4f1183"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Frediano Ziglio <freddy77@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000efc5e505ad4f1183
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Aug 20, 2020 at 5:01 PM Frediano Ziglio <fziglio@redhat.com> wrote:

> From: Frediano Ziglio <freddy77@gmail.com>
>
> Add support for SIDE and EXTRA buttons.
>
> Signed-off-by: Frediano Ziglio <freddy77@gmail.com>
> ---
>  ui/spice-input.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ui/spice-input.c b/ui/spice-input.c
> index cd4bb0043f..d5bba231c9 100644
> --- a/ui/spice-input.c
> +++ b/ui/spice-input.c
> @@ -123,6 +123,8 @@ static void spice_update_buttons(QemuSpicePointer
> *pointer,
>          [INPUT_BUTTON_RIGHT]       =3D 0x02,
>          [INPUT_BUTTON_WHEEL_UP]    =3D 0x10,
>          [INPUT_BUTTON_WHEEL_DOWN]  =3D 0x20,
> +        [INPUT_BUTTON_SIDE]        =3D 0x40,
> +        [INPUT_BUTTON_EXTRA]       =3D 0x80,
>      };
>
>      if (wheel < 0) {
> --
> 2.25.4
>
>
I don't see where those values are defined, can you describe it a bit?

thanks


--=20
Marc-Andr=C3=A9 Lureau

--000000000000efc5e505ad4f1183
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 20, 2020 at 5:01 PM Fre=
diano Ziglio &lt;<a href=3D"mailto:fziglio@redhat.com">fziglio@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fr=
om: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" target=3D"_bl=
ank">freddy77@gmail.com</a>&gt;<br>
<br>
Add support for SIDE and EXTRA buttons.<br>
<br>
Signed-off-by: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" ta=
rget=3D"_blank">freddy77@gmail.com</a>&gt;<br>
---<br>
=C2=A0ui/spice-input.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/ui/spice-input.c b/ui/spice-input.c<br>
index cd4bb0043f..d5bba231c9 100644<br>
--- a/ui/spice-input.c<br>
+++ b/ui/spice-input.c<br>
@@ -123,6 +123,8 @@ static void spice_update_buttons(QemuSpicePointer *poin=
ter,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[INPUT_BUTTON_RIGHT]=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x02,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[INPUT_BUTTON_WHEEL_UP]=C2=A0 =C2=A0 =3D =
0x10,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[INPUT_BUTTON_WHEEL_DOWN]=C2=A0 =3D 0x20,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_SIDE]=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D 0x40,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_EXTRA]=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 0x80,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (wheel &lt; 0) {<br>
-- <br>
2.25.4<br>
<br></blockquote><div><br></div><div>I don&#39;t see where those values are=
 defined, can you describe it a bit?</div><div><br></div><div>thanks<br></d=
iv></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signa=
ture">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000efc5e505ad4f1183--

