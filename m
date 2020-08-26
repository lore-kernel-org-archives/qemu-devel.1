Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F749C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0705020707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoGlrIc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0705020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvCy-0002Li-AG
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAvA3-0006ml-5E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:08:19 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAvA0-0002JL-TE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:08:18 -0400
Received: by mail-ej1-x644.google.com with SMTP id a26so2774894ejc.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TznLm/ZOgOtUKl3GrPriN9ZFYMQ3WiCW+l7rjBB/kNE=;
 b=qoGlrIc+Thbt7asq/OsgDBfHorLi9TgR9b6WASivdSr/i4UG8YFgdgyPJ9470bZ1tF
 /INbDOxNNpNEUvfSzE8K27r8OKdL5Bvc+Bg3fIAgMF0nT5xRAmE6kHVV09J+tQKm3fbU
 qouO1eJkAiulu97bmIH+mSxPbp6thOWwTZV/wvwYz97pK3iG5L/le0PEybJiIGObpysQ
 KzJinvzDymx15u3NmKP5O6J1Xwi4+JoOrTfScwjQXo0q28/SaN2cEneBgC7fzW6pLKxJ
 htBAihAAZBg3nHJtikhKWFdWHbUw+fCxjtE+m1djub4/L8uv+iJ3aDuDC5PC+5Ca67P4
 20JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TznLm/ZOgOtUKl3GrPriN9ZFYMQ3WiCW+l7rjBB/kNE=;
 b=R5dJrPvacfwGaW1kDndQqTVuxbYZiJ5q5HGNWu0OHjYSnBI4+ZK0sPQEmTgR53Y80y
 xSSxuIdnlfdYscUSXA+MHYUQu+eC4JPtgAL4gaT8hz1vigZLnUJBy9qTKOTVjFYRCwxi
 Owelr/+3pMvXmRcOzDnjlwyjBG2gb1pkLSWZeqy2ZSbGtLmHpjgBzYyF9H6gfCfO3R0L
 FeWCYWzUzklNncBaDpYcAkU56XhV7xNmxqR0SHsPsN3xjxMU+TrdoxZcbWP+81/OrQUy
 6HsudeSXYHmAhxHfj3v/+KI3Fy9TwsA8/asWsrcyL1SnlLdjLh+4fv87uvz+AC19Vshi
 peYQ==
X-Gm-Message-State: AOAM5300MIYY5Wtz36wviWLymetrHkEKxNQqkL2N6MtAds64wdmJuikl
 dnAOc5xCVLJAaignuIkXDEBDJRzpPVwk8jCMBtefNCu0I4rNQA==
X-Google-Smtp-Source: ABdhPJy5S45GVRBHjFHwv+B0C7AdCpRZzLLh36p2u9RQ1mtZfOuvMs6UvbB/vTjdUS0Ne6wJdVXGnYBnH40LI9d8P4w=
X-Received: by 2002:a17:906:3816:: with SMTP id
 v22mr15408550ejc.105.1598447294792; 
 Wed, 26 Aug 2020 06:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200826113432.534348-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200826113432.534348-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Aug 2020 17:08:01 +0400
Message-ID: <CAJ+F1CKP3-c6kfh9xzvPtXvRQRi3YM_Ou6nt55wd4iWwzVdgkg@mail.gmail.com>
Subject: Re: [PATCH] meson: install pc-bios blobs
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000032c8ec05adc7838e"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000032c8ec05adc7838e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2020 at 3:34 PM <marcandre.lureau@redhat.com> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile            | 31 ----------------------
>  pc-bios/meson.build | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 31 deletions(-)
>
>
I bit the bullet and included this patch in "[PATCH 0/6] meson: convert the
remaining of install target" series.

diff --git a/Makefile b/Makefile
> index 3ebd6929b4..be5acf10e6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -229,32 +229,6 @@ distclean: clean ninja-distclean
>         rm -f linux-headers/asm
>         rm -Rf .sdk
>
> -ifdef INSTALL_BLOBS
> -BLOBS=3Dbios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin
> vgabios-cirrus.bin \
> -vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin=
 \
> -vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
> -openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin
> QEMU,cgthree.bin \
> -pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
> -pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
> -efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
> -efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
> -efi-e1000e.rom efi-vmxnet3.rom \
> -qemu-nsis.bmp \
> -bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb =
\
> -multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
> -s390-ccw.img s390-netboot.img \
> -slof.bin skiboot.lid \
> -palcode-clipper \
> -u-boot.e500 u-boot-sam460-20100605.bin \
> -qemu_vga.ndrv \
> -edk2-licenses.txt \
> -hppa-firmware.img \
> -opensbi-riscv32-generic-fw_dynamic.bin
> opensbi-riscv64-generic-fw_dynamic.bin \
> -opensbi-riscv32-generic-fw_dynamic.elf
> opensbi-riscv64-generic-fw_dynamic.elf
> -else
> -BLOBS=3D
> -endif
> -
>  install-datadir:
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
>
> @@ -272,11 +246,6 @@ export DESTDIR
>  install: all install-datadir install-localstatedir
>  ifdef CONFIG_TRACE_SYSTEMTAP
>         $(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
> -endif
> -ifneq ($(BLOBS),)
> -       set -e; for x in $(BLOBS); do \
> -               $(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x
> "$(DESTDIR)$(qemu_datadir)"; \
> -       done
>  endif
>         for s in $(ICON_SIZES); do \
>                 mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; =
\
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index c11e52ba26..8087e5c0a7 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -24,5 +24,68 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
>    endforeach
>  endif
>
> +blobs =3D files(
> +  'bios.bin',
> +  'bios-256k.bin',
> +  'bios-microvm.bin',
> +  'sgabios.bin',
> +  'vgabios.bin',
> +  'vgabios-cirrus.bin',
> +  'vgabios-stdvga.bin',
> +  'vgabios-vmware.bin',
> +  'vgabios-qxl.bin',
> +  'vgabios-virtio.bin',
> +  'vgabios-ramfb.bin',
> +  'vgabios-bochs-display.bin',
> +  'vgabios-ati.bin',
> +  'openbios-sparc32',
> +  'openbios-sparc64',
> +  'openbios-ppc',
> +  'QEMU,tcx.bin',
> +  'QEMU,cgthree.bin',
> +  'pxe-e1000.rom',
> +  'pxe-eepro100.rom',
> +  'pxe-ne2k_pci.rom',
> +  'pxe-pcnet.rom',
> +  'pxe-rtl8139.rom',
> +  'pxe-virtio.rom',
> +  'efi-e1000.rom',
> +  'efi-eepro100.rom',
> +  'efi-ne2k_pci.rom',
> +  'efi-pcnet.rom',
> +  'efi-rtl8139.rom',
> +  'efi-virtio.rom',
> +  'efi-e1000e.rom',
> +  'efi-vmxnet3.rom',
> +  'qemu-nsis.bmp',
> +  'bamboo.dtb',
> +  'canyonlands.dtb',
> +  'petalogix-s3adsp1800.dtb',
> +  'petalogix-ml605.dtb',
> +  'multiboot.bin',
> +  'linuxboot.bin',
> +  'linuxboot_dma.bin',
> +  'kvmvapic.bin',
> +  'pvh.bin',
> +  's390-ccw.img',
> +  's390-netboot.img',
> +  'slof.bin',
> +  'skiboot.lid',
> +  'palcode-clipper',
> +  'u-boot.e500',
> +  'u-boot-sam460-20100605.bin',
> +  'qemu_vga.ndrv',
> +  'edk2-licenses.txt',
> +  'hppa-firmware.img',
> +  'opensbi-riscv32-generic-fw_dynamic.bin',
> +  'opensbi-riscv64-generic-fw_dynamic.bin',
> +  'opensbi-riscv32-generic-fw_dynamic.elf',
> +  'opensbi-riscv64-generic-fw_dynamic.elf',
> +)
> +
> +if install_blobs
> +  install_data(blobs, install_dir: config_host['qemu_datadir'])
> +endif
> +
>  subdir('descriptors')
>  subdir('keymaps')
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000032c8ec05adc7838e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 3:34 PM &lt=
;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.=
com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 31 --------------=
--------<br>
=C2=A0pc-bios/meson.build | 63 ++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 63 insertions(+), 31 deletions(-)<br>
<br></blockquote><div><br></div><div>I bit the bullet and included this pat=
ch in &quot;[PATCH 0/6] meson: convert the remaining of install target&quot=
; series.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
diff --git a/Makefile b/Makefile<br>
index 3ebd6929b4..be5acf10e6 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -229,32 +229,6 @@ distclean: clean ninja-distclean<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f linux-headers/asm<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -Rf .sdk<br>
<br>
-ifdef INSTALL_BLOBS<br>
-BLOBS=3Dbios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vg=
abios-cirrus.bin \<br>
-vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \=
<br>
-vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \<br>
-openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.b=
in \<br>
-pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \<br>
-pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \<br>
-efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \<br>
-efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \<br>
-efi-e1000e.rom efi-vmxnet3.rom \<br>
-qemu-nsis.bmp \<br>
-bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \<=
br>
-multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \<br>
-s390-ccw.img s390-netboot.img \<br>
-slof.bin skiboot.lid \<br>
-palcode-clipper \<br>
-u-boot.e500 u-boot-sam460-20100605.bin \<br>
-qemu_vga.ndrv \<br>
-edk2-licenses.txt \<br>
-hppa-firmware.img \<br>
-opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.=
bin \<br>
-opensbi-riscv32-generic-fw_dynamic.elf opensbi-riscv64-generic-fw_dynamic.=
elf<br>
-else<br>
-BLOBS=3D<br>
-endif<br>
-<br>
=C2=A0install-datadir:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(INSTALL_DIR) &quot;$(DESTDIR)$(qemu_datadir)&=
quot;<br>
<br>
@@ -272,11 +246,6 @@ export DESTDIR<br>
=C2=A0install: all install-datadir install-localstatedir<br>
=C2=A0ifdef CONFIG_TRACE_SYSTEMTAP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(INSTALL_PROG) &quot;scripts/qemu-trace-stap&q=
uot; $(DESTDIR)$(bindir)<br>
-endif<br>
-ifneq ($(BLOBS),)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0set -e; for x in $(BLOBS); do \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(S=
RC_PATH)/pc-bios/$$x &quot;$(DESTDIR)$(qemu_datadir)&quot;; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
=C2=A0endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for s in $(ICON_SIZES); do \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir -p &quot;$(DE=
STDIR)$(qemu_icondir)/hicolor/$${s}/apps&quot;; \<br>
diff --git a/pc-bios/meson.build b/pc-bios/meson.build<br>
index c11e52ba26..8087e5c0a7 100644<br>
--- a/pc-bios/meson.build<br>
+++ b/pc-bios/meson.build<br>
@@ -24,5 +24,68 @@ if &#39;DECOMPRESS_EDK2_BLOBS&#39; in config_host<br>
=C2=A0 =C2=A0endforeach<br>
=C2=A0endif<br>
<br>
+blobs =3D files(<br>
+=C2=A0 &#39;bios.bin&#39;,<br>
+=C2=A0 &#39;bios-256k.bin&#39;,<br>
+=C2=A0 &#39;bios-microvm.bin&#39;,<br>
+=C2=A0 &#39;sgabios.bin&#39;,<br>
+=C2=A0 &#39;vgabios.bin&#39;,<br>
+=C2=A0 &#39;vgabios-cirrus.bin&#39;,<br>
+=C2=A0 &#39;vgabios-stdvga.bin&#39;,<br>
+=C2=A0 &#39;vgabios-vmware.bin&#39;,<br>
+=C2=A0 &#39;vgabios-qxl.bin&#39;,<br>
+=C2=A0 &#39;vgabios-virtio.bin&#39;,<br>
+=C2=A0 &#39;vgabios-ramfb.bin&#39;,<br>
+=C2=A0 &#39;vgabios-bochs-display.bin&#39;,<br>
+=C2=A0 &#39;vgabios-ati.bin&#39;,<br>
+=C2=A0 &#39;openbios-sparc32&#39;,<br>
+=C2=A0 &#39;openbios-sparc64&#39;,<br>
+=C2=A0 &#39;openbios-ppc&#39;,<br>
+=C2=A0 &#39;QEMU,tcx.bin&#39;,<br>
+=C2=A0 &#39;QEMU,cgthree.bin&#39;,<br>
+=C2=A0 &#39;pxe-e1000.rom&#39;,<br>
+=C2=A0 &#39;pxe-eepro100.rom&#39;,<br>
+=C2=A0 &#39;pxe-ne2k_pci.rom&#39;,<br>
+=C2=A0 &#39;pxe-pcnet.rom&#39;,<br>
+=C2=A0 &#39;pxe-rtl8139.rom&#39;,<br>
+=C2=A0 &#39;pxe-virtio.rom&#39;,<br>
+=C2=A0 &#39;efi-e1000.rom&#39;,<br>
+=C2=A0 &#39;efi-eepro100.rom&#39;,<br>
+=C2=A0 &#39;efi-ne2k_pci.rom&#39;,<br>
+=C2=A0 &#39;efi-pcnet.rom&#39;,<br>
+=C2=A0 &#39;efi-rtl8139.rom&#39;,<br>
+=C2=A0 &#39;efi-virtio.rom&#39;,<br>
+=C2=A0 &#39;efi-e1000e.rom&#39;,<br>
+=C2=A0 &#39;efi-vmxnet3.rom&#39;,<br>
+=C2=A0 &#39;qemu-nsis.bmp&#39;,<br>
+=C2=A0 &#39;bamboo.dtb&#39;,<br>
+=C2=A0 &#39;canyonlands.dtb&#39;,<br>
+=C2=A0 &#39;petalogix-s3adsp1800.dtb&#39;,<br>
+=C2=A0 &#39;petalogix-ml605.dtb&#39;,<br>
+=C2=A0 &#39;multiboot.bin&#39;,<br>
+=C2=A0 &#39;linuxboot.bin&#39;,<br>
+=C2=A0 &#39;linuxboot_dma.bin&#39;,<br>
+=C2=A0 &#39;kvmvapic.bin&#39;,<br>
+=C2=A0 &#39;pvh.bin&#39;,<br>
+=C2=A0 &#39;s390-ccw.img&#39;,<br>
+=C2=A0 &#39;s390-netboot.img&#39;,<br>
+=C2=A0 &#39;slof.bin&#39;,<br>
+=C2=A0 &#39;skiboot.lid&#39;,<br>
+=C2=A0 &#39;palcode-clipper&#39;,<br>
+=C2=A0 &#39;u-boot.e500&#39;,<br>
+=C2=A0 &#39;u-boot-sam460-20100605.bin&#39;,<br>
+=C2=A0 &#39;qemu_vga.ndrv&#39;,<br>
+=C2=A0 &#39;edk2-licenses.txt&#39;,<br>
+=C2=A0 &#39;hppa-firmware.img&#39;,<br>
+=C2=A0 &#39;opensbi-riscv32-generic-fw_dynamic.bin&#39;,<br>
+=C2=A0 &#39;opensbi-riscv64-generic-fw_dynamic.bin&#39;,<br>
+=C2=A0 &#39;opensbi-riscv32-generic-fw_dynamic.elf&#39;,<br>
+=C2=A0 &#39;opensbi-riscv64-generic-fw_dynamic.elf&#39;,<br>
+)<br>
+<br>
+if install_blobs<br>
+=C2=A0 install_data(blobs, install_dir: config_host[&#39;qemu_datadir&#39;=
])<br>
+endif<br>
+<br>
=C2=A0subdir(&#39;descriptors&#39;)<br>
=C2=A0subdir(&#39;keymaps&#39;)<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000032c8ec05adc7838e--

