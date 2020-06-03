Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23059C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E263820738
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPEft3Fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E263820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWA4-0007OV-7S
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jgW7j-0005Pw-UZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:20:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jgW7i-0005Iz-ED
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:20:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id r7so3045615wro.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=TYmMypin88PIgsNnuhnXSrwDk/qjEP7rFAeGHOmIs8Q=;
 b=nPEft3Fe8mDalSlOB167Wrd3voYsItlxlNMsQCNslyS0iWGtnMSzuCwAjX7MuZnbNw
 QOWq60mNplhziB9fwEPc9rJmIKy6zwrTCkwcA97B1jjJa6z5yYEC7h12eJ+t2R+AW3eB
 dmJmk5XtMQi1kTidorZvlmLH/urPKOjNC4+WxwPwYq/PXmgxe18e86mUshiXp0HWJS6v
 Wz3owSTA2Bqk5DKzZzToAq7jiqS6U7zZxeMxVXBtRNH/LBA2LTSmsYfm2iX89fZKTtAp
 IXevYq5K90MeilEobxKjY5xpP6k9NoTeMAAZr8DT4OBHekCxx90E6gi10EGfZW/pm+mA
 Q+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=TYmMypin88PIgsNnuhnXSrwDk/qjEP7rFAeGHOmIs8Q=;
 b=XilHmTZsrLRkkjWBQP5GwNkRSy2WbTrEnrEH2vk7XwkL/CmygbYwLxS2X/OkPvZDg5
 3Tl4qrtvnnL/+sn6Iv/ANSHQG65dj7rxzcBYc7EGSCuvw6qfHWUa7fKa4P0+WBEaCNbw
 uUhvHkpoLjsXUnwzPZqpr1JBdknKGnzMsf5r4Ii+aRPShsQUORNBfJbdTndKUArJe22Z
 exXtmElFNjPc6O6toFXsW/r0Wy1BU1ve23XK0Xn/D0Nnie/mHj0xkyWExfhLpwg9CSmZ
 waV2sEAhL9T2mLQDUsiObpExATUPp9UAgjRY6Od1l9DtSaSBwmIaVrNH22xVeQTixhcL
 WyaQ==
X-Gm-Message-State: AOAM533P6BU6fND9bSTMFbAyd1ByUNjhaLG4vUdRBTnX7vN/G6GhV57D
 DoZysmEiBsbmgA7zhSdoHGo=
X-Google-Smtp-Source: ABdhPJyW4/QzKyTUNOkL1Hgt3Um3mDrRl8mE0vNYIq+Nq1VgoKMEv7pquWeyiyDtboKE0jWn5oN9Zg==
X-Received: by 2002:adf:e381:: with SMTP id e1mr233632wrm.320.1591201212565;
 Wed, 03 Jun 2020 09:20:12 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.185])
 by smtp.gmail.com with ESMTPSA id j5sm3992708wrq.39.2020.06.03.09.20.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2020 09:20:11 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>,
	<qemu-devel@nongnu.org>
References: <20200603160442.3151170-1-anthony.perard@citrix.com>
In-Reply-To: <20200603160442.3151170-1-anthony.perard@citrix.com>
Subject: RE: [PATCH v3] xen: fix build without pci passthrough
Date: Wed, 3 Jun 2020 17:20:10 +0100
Message-ID: <005d01d639c2$db48d370$91da7a50$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQGyQ6RA4n1W3DCtViLPILQo6PvvUKkO/R6w
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: paul@xen.org
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Eduardo Habkost' <ehabkost@redhat.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Roger Pau Monne' <roger.pau@citrix.com>,
 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 03 June 2020 17:05
> To: qemu-devel@nongnu.org
> Cc: Anthony PERARD <anthony.perard@citrix.com>; Roger Pau Monne =
<roger.pau@citrix.com>; Michael S.
> Tsirkin <mst@redhat.com>; Marcel Apfelbaum =
<marcel.apfelbaum@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>; Eduardo =
Habkost <ehabkost@redhat.com>;
> Stefano Stabellini <sstabellini@kernel.org>; Paul Durrant =
<paul@xen.org>; xen-
> devel@lists.xenproject.org
> Subject: [PATCH v3] xen: fix build without pci passthrough
>=20
> From: Roger Pau Monne <roger.pau@citrix.com>
>=20
> Xen PCI passthrough support may not be available and thus the global
> variable "has_igd_gfx_passthru" might be compiled out. Common code
> should not access it in that case.
>=20
> Unfortunately, we can't use CONFIG_XEN_PCI_PASSTHROUGH directly in
> xen-common.c so this patch instead move access to the
> has_igd_gfx_passthru variable via function and those functions are
> also implemented as stubs. The stubs will be used when QEMU is built
> without passthrough support.
>=20
> Now, when one will want to enable igd-passthru via the -machine
> property, they will get an error message if QEMU is built without
> passthrough support.
>=20
> Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an =
accelerator property')
> Reported-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Acked-by: Paul Durrant <paul@xen.org>

> ---
>=20
> Notes:
>     Changes in v3:
>     - reworked to use stubs instead of #ifdef =
CONFIG_XEN_PCI_PASSTHROUGH
>       CONFIG_XEN_PCI_PASSTHROUGH isn't available in xen-common.c
>=20
>       moving CONFIG_XEN_PCI_PASSTHROUGH to be in config_host_mak isn't
>       really possible, or at least I didn't managed to make that work.
>=20
>  hw/i386/pc_piix.c   |  2 +-
>  hw/xen/xen-common.c |  4 ++--
>  hw/xen/xen_pt.c     | 12 +++++++++++-
>  hw/xen/xen_pt.h     |  6 ++++--
>  stubs/Makefile.objs |  1 +
>  stubs/xen-pt.c      | 22 ++++++++++++++++++++++
>  6 files changed, 41 insertions(+), 6 deletions(-)
>  create mode 100644 stubs/xen-pt.c
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index f66e1d73ce0b..347fb8c6c807 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -375,7 +375,7 @@ static void pc_init_isa(MachineState *machine)
>  #ifdef CONFIG_XEN
>  static void pc_xen_hvm_init_pci(MachineState *machine)
>  {
> -    const char *pci_type =3D has_igd_gfx_passthru ?
> +    const char *pci_type =3D xen_igd_gfx_pt_enabled() ?
>                  TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : =
TYPE_I440FX_PCI_DEVICE;
>=20
>      pc_init1(machine,
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 70564cc952d5..dd2c22cc4c0b 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -129,12 +129,12 @@ static void xen_change_state_handler(void =
*opaque, int running,
>=20
>  static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
>  {
> -    return has_igd_gfx_passthru;
> +    return xen_igd_gfx_pt_enabled();
>  }
>=20
>  static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error =
**errp)
>  {
> -    has_igd_gfx_passthru =3D value;
> +    xen_igd_gfx_pt_set(value, errp);
>  }
>=20
>  static void xen_setup_post(MachineState *ms, AccelState *accel)
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 81d5ad8da7f0..ab84443d5ec8 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -65,7 +65,17 @@
>  #include "qemu/range.h"
>  #include "exec/address-spaces.h"
>=20
> -bool has_igd_gfx_passthru;
> +static bool has_igd_gfx_passthru;
> +
> +bool xen_igd_gfx_pt_enabled(void)
> +{
> +    return has_igd_gfx_passthru;
> +}
> +
> +void xen_igd_gfx_pt_set(bool value, Error **errp)
> +{
> +    has_igd_gfx_passthru =3D value;
> +}
>=20
>  #define XEN_PT_NR_IRQS (256)
>  static uint8_t xen_pt_mapped_machine_irq[XEN_PT_NR_IRQS] =3D {0};
> diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> index 179775db7b22..6e9cec95f3b7 100644
> --- a/hw/xen/xen_pt.h
> +++ b/hw/xen/xen_pt.h
> @@ -5,6 +5,9 @@
>  #include "hw/pci/pci.h"
>  #include "xen-host-pci-device.h"
>=20
> +bool xen_igd_gfx_pt_enabled(void);
> +void xen_igd_gfx_pt_set(bool value, Error **errp);
> +
>  void xen_pt_log(const PCIDevice *d, const char *f, ...) =
GCC_FMT_ATTR(2, 3);
>=20
>  #define XEN_PT_ERR(d, _f, _a...) xen_pt_log(d, "%s: Error: "_f, =
__func__, ##_a)
> @@ -322,10 +325,9 @@ extern void =
*pci_assign_dev_load_option_rom(PCIDevice *dev,
>                                              unsigned int domain,
>                                              unsigned int bus, =
unsigned int slot,
>                                              unsigned int function);
> -extern bool has_igd_gfx_passthru;
>  static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
>  {
> -    return (has_igd_gfx_passthru
> +    return (xen_igd_gfx_pt_enabled()
>              && ((dev->class_code >> 0x8) =3D=3D =
PCI_CLASS_DISPLAY_VGA));
>  }
>  int xen_pt_register_vga_regions(XenHostPCIDevice *dev);
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 6a9e3135e8f9..564527e00997 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -40,6 +40,7 @@ stub-obj-y +=3D target-get-monitor-def.o
>  stub-obj-y +=3D vmgenid.o
>  stub-obj-y +=3D xen-common.o
>  stub-obj-y +=3D xen-hvm.o
> +stub-obj-y +=3D xen-pt.o
>  stub-obj-y +=3D pci-host-piix.o
>  stub-obj-y +=3D ram-block.o
>  stub-obj-y +=3D ramfb.o
> diff --git a/stubs/xen-pt.c b/stubs/xen-pt.c
> new file mode 100644
> index 000000000000..2d8cac8d54b9
> --- /dev/null
> +++ b/stubs/xen-pt.c
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2020       Citrix Systems UK Ltd.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/xen/xen_pt.h"
> +#include "qapi/error.h"
> +
> +bool xen_igd_gfx_pt_enabled(void)
> +{
> +    return false;
> +}
> +
> +void xen_igd_gfx_pt_set(bool value, Error **errp)
> +{
> +    if (value) {
> +        error_setg(errp, "Xen PCI passthrough support not built in");
> +    }
> +}
> --
> Anthony PERARD



