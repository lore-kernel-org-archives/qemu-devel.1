Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FCC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43B220EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbJoh3yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43B220EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvKa-0003pC-HZ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVvDR-00066K-5g
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:26:37 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVvDP-0000kH-FH
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:26:36 -0400
Received: by mail-ej1-x644.google.com with SMTP id w27so1890814ejb.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=InjaiNuxT1LsQUPEpAfoMmuzyN3Vigg0o1K34ESlLrI=;
 b=AbJoh3yXkblVolhQIMQnKJRymSTCZ6CUPBKOb6zAaeELaEdGsR4TJpF05BUN/KJMRJ
 qPedwcnJbFmhd50yflO7T2i665a+qgfEyAeJolW9129r5pnTTrh/hm6xZnWiHsDiv7fR
 M7ztUY/KGkTJoAxAy0EV4CzvIeCUoBgVqJxzTVts1jCYLA5eh8setC8CPbm8SdDb3FkM
 M3ORFE8iu9Ey75rU0wlotbRJIOCgq+6eJksrmJbb8rS7LHSkBPniF9/GU6QctAaonQMC
 e9oKteUOGRzMiYhRGWIz/Sxs+Q7IY/yLpQICIsr43CcFIc00zHKuCyZjn8nVdmomo8Rc
 BqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=InjaiNuxT1LsQUPEpAfoMmuzyN3Vigg0o1K34ESlLrI=;
 b=hEzqwqU0E8VheSX10QYKb98yj9lV4BpV0as/T73LHzAXzgm2egrd357GniMShdIVSy
 tfkOWp6p9G7yA4gYPvevKEv35k0mP/VID34Ocfc9b0ntPdLP9ua8UaVtkku0em+I+pCg
 eCQTbj5DMp4R6vqmYrSXiBi8yyFcKpKJtBKk9Ia96RtwZk0CdgJVLoyZJf0tHNK5MeWH
 e57475ilLyAMkv+bAZVA9h/2niMny8ZRa0Hi1ueAqU0KJgqrkYV5Y/OcH22LrMqL3ECV
 qymlNlIHXMoS3fnuGqBdAimbgJmfbolCZGYCBJlbyAapOKh/qbdkk7mKhYCEbEzMUZPb
 hESA==
X-Gm-Message-State: AOAM531wa9/Xe8t8MlAFWOKYXvO8BNvmLF1EAhlzIW4r4dc3p8yb+w37
 esf3NeyrLDPUme5fohADxwdOHR0WElO+S0u1fmU=
X-Google-Smtp-Source: ABdhPJyDESB4d+f6RieWW9aDPLKkAKswR1sU4bVGEMGe2gu8pPor/uJvW0p7UDsUU9EwR6nd3j4Tps8XuAVJ0VbAMqQ=
X-Received: by 2002:a17:906:9588:: with SMTP id
 r8mr1502758ejx.389.1603452393070; 
 Fri, 23 Oct 2020 04:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201023064618.21409-1-kraxel@redhat.com>
 <20201023064618.21409-2-kraxel@redhat.com>
 <CAJ+F1CK0A1+vOMZq55guJi9OPg1zyVyRQ_azYA7NNVg5Kx5hDA@mail.gmail.com>
 <20201023110135.lrjq5mqvma4fzavi@sirius.home.kraxel.org>
In-Reply-To: <20201023110135.lrjq5mqvma4fzavi@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Oct 2020 15:26:21 +0400
Message-ID: <CAJ+F1C+8vorbx8smMzc3=iCPHCinVg__Ck57EjxBHqu_NfjCBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-gpu: add virtio-gpu-pci module
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004da60105b254da19"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004da60105b254da19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI

On Fri, Oct 23, 2020 at 3:01 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > Hmm, I realize we have a different behaviour when building devices as
> > modules shared by different qemu system binaries.
> >
> > It will attempt to load any kind of modules:
> >
> > ./qemu-system-m68k  -kernel ~/Downloads/vmlinux-5.8.0-3-m68k  -device
> > virtio-gpu-pci
> > Failed to open module:
> > /home/elmarco/src/qemu/buildnodoc/hw-display-virtio-gpu-pci.so: undefin=
ed
> > symbol: virtio_instance_init_common
> > qemu-system-m68k: -device virtio-gpu-pci: 'virtio-gpu-pci' is not a val=
id
> > device model name
>
> Yes.  The last line is printed for non-modular builds too.
> The module load error can obviously only happen on modular builds.
>
> > $ qemu-system-m68k -device help
> > Failed to open module: /usr/lib64/qemu/hw-usb-smartcard.so: undefined
> > symbol: ccid_card_send_apdu_to_guest
> > Failed to open module: /usr/lib64/qemu/hw-display-qxl.so: undefined
> symbol:
> > vga_ioport_read
>
> That one is fixed meanwhile:
>
> commit 501093207eb1ed4845e0a65ee1ce7db7b9676e0b
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Wed Sep 23 11:12:17 2020 +0200
>
>     module: silence errors for module_load_qom_all().
>
>
Ok, but that could hide real errors, couldn't it? What about the proposal
to have a subdir per arch with symlinks?

--=20
Marc-Andr=C3=A9 Lureau

--0000000000004da60105b254da19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">HI<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 3:01 PM Ger=
d Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0=
 Hi,<br>
<br>
&gt; Hmm, I realize we have a different behaviour when building devices as<=
br>
&gt; modules shared by different qemu system binaries.<br>
&gt; <br>
&gt; It will attempt to load any kind of modules:<br>
&gt; <br>
&gt; ./qemu-system-m68k=C2=A0 -kernel ~/Downloads/vmlinux-5.8.0-3-m68k=C2=
=A0 -device<br>
&gt; virtio-gpu-pci<br>
&gt; Failed to open module:<br>
&gt; /home/elmarco/src/qemu/buildnodoc/hw-display-virtio-gpu-pci.so: undefi=
ned<br>
&gt; symbol: virtio_instance_init_common<br>
&gt; qemu-system-m68k: -device virtio-gpu-pci: &#39;virtio-gpu-pci&#39; is =
not a valid<br>
&gt; device model name<br>
<br>
Yes.=C2=A0 The last line is printed for non-modular builds too.<br>
The module load error can obviously only happen on modular builds.<br>
<br>
&gt; $ qemu-system-m68k -device help<br>
&gt; Failed to open module: /usr/lib64/qemu/hw-usb-smartcard.so: undefined<=
br>
&gt; symbol: ccid_card_send_apdu_to_guest<br>
&gt; Failed to open module: /usr/lib64/qemu/hw-display-qxl.so: undefined sy=
mbol:<br>
&gt; vga_ioport_read<br>
<br>
That one is fixed meanwhile:<br>
<br>
commit 501093207eb1ed4845e0a65ee1ce7db7b9676e0b<br>
Author: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_b=
lank">kraxel@redhat.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Sep 23 11:12:17 2020 +0200<br>
<br>
=C2=A0 =C2=A0 module: silence errors for module_load_qom_all().<br><br></bl=
ockquote><div><br></div><div>Ok, but that could hide real errors, couldn&#3=
9;t it? What about the proposal to have a subdir per arch with symlinks?<br=
></div><div>=C2=A0</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signat=
ure">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000004da60105b254da19--

