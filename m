Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74219C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49D0218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Q5VlRYK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49D0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8X8-0008Lw-15
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RO-00024R-FF; Mon, 12 Oct 2020 20:45:22 -0400
Received: from ozlabs.org ([203.11.71.1]:41699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RJ-0006nG-42; Mon, 12 Oct 2020 20:45:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C9GzQ3G7kz9sVD; Tue, 13 Oct 2020 11:45:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602549906;
 bh=FxmL8PgRV16Qjfh784pRUyyS19OMN6XPdKaH+2s3XQY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q5VlRYK42GLi323qOU1U2uPXwSgfixA5nhvnab92FcUhIbuIY8qjKt+l9+W5lbOn1
 AHgXCUgkxM3LVkqXj64KOeWyIdTlj92EJnGgC7eQw5WtognVDjiZ3OPD6XO7UVi554
 hT6k9cyVoyI/u8szxx+DNJXmKPtBUd6/JwkI7Nw0=
Date: Tue, 13 Oct 2020 11:43:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 4/5] hw: Use the PCI_SLOT() macro from 'hw/pci/pci.h'
Message-ID: <20201013004330.GI71119@yekko.fritz.box>
References: <20201012124506.3406909-1-philmd@redhat.com>
 <20201012124506.3406909-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <20201012124506.3406909-5-philmd@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 20:45:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 02:45:05PM +0200, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> We already have a generic PCI_SLOT() macro in "hw/pci/pci.h"
> to extract the PCI slot identifier, use it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/hppa/dino.c        | 2 +-
>  hw/i386/xen/xen-hvm.c | 2 +-
>  hw/isa/piix3.c        | 2 +-
>  hw/mips/gt64xxx_pci.c | 2 +-
>  hw/pci-host/bonito.c  | 2 +-
>  hw/pci-host/ppce500.c | 2 +-
>  hw/ppc/ppc4xx_pci.c   | 2 +-
>  hw/sh4/sh_pci.c       | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index 81053b5fb64..5b82c9440d1 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -496,7 +496,7 @@ static void dino_set_irq(void *opaque, int irq, int l=
evel)
> =20
>  static int dino_pci_map_irq(PCIDevice *d, int irq_num)
>  {
> -    int slot =3D d->devfn >> 3;
> +    int slot =3D PCI_SLOT(d->devfn);
> =20
>      assert(irq_num >=3D 0 && irq_num <=3D 3);
> =20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index f3ababf33b6..276254e6ca9 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -140,7 +140,7 @@ typedef struct XenIOState {
> =20
>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
>  {
> -    return irq_num + ((pci_dev->devfn >> 3) << 2);
> +    return irq_num + (PCI_SLOT(pci_dev->devfn) << 2);
>  }
> =20
>  void xen_piix3_set_irq(void *opaque, int irq_num, int level)
> diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
> index 587850b8881..f46ccae25cf 100644
> --- a/hw/isa/piix3.c
> +++ b/hw/isa/piix3.c
> @@ -361,7 +361,7 @@ type_init(piix3_register_types)
>  static int pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
>  {
>      int slot_addend;
> -    slot_addend =3D (pci_dev->devfn >> 3) - 1;
> +    slot_addend =3D PCI_SLOT(pci_dev->devfn) - 1;
>      return (pci_intx + slot_addend) & 3;
>  }
> =20
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index e091bc4ed55..588e6f99301 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -982,7 +982,7 @@ static int gt64120_pci_map_irq(PCIDevice *pci_dev, in=
t irq_num)
>  {
>      int slot;
> =20
> -    slot =3D (pci_dev->devfn >> 3);
> +    slot =3D PCI_SLOT(pci_dev->devfn);
> =20
>      switch (slot) {
>      /* PIIX4 USB */
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index b05295639a6..ee8b193e15b 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -570,7 +570,7 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int=
 irq_num)
>  {
>      int slot;
> =20
> -    slot =3D (pci_dev->devfn >> 3);
> +    slot =3D PCI_SLOT(pci_dev->devfn);
> =20
>      switch (slot) {
>      case 5:   /* FULOONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, =
MC97 */
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index 9517aab913e..5ad1424b31a 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -342,7 +342,7 @@ static const MemoryRegionOps e500_pci_reg_ops =3D {
> =20
>  static int mpc85xx_pci_map_irq(PCIDevice *pci_dev, int pin)
>  {
> -    int devno =3D pci_dev->devfn >> 3;
> +    int devno =3D PCI_SLOT(pci_dev->devfn);
>      int ret;
> =20
>      ret =3D ppce500_pci_map_irq_slot(devno, pin);
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 28724c06f88..e8789f64e80 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -243,7 +243,7 @@ static void ppc4xx_pci_reset(void *opaque)
>   * may need further refactoring for other boards. */
>  static int ppc4xx_pci_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
> -    int slot =3D pci_dev->devfn >> 3;
> +    int slot =3D PCI_SLOT(pci_dev->devfn);
> =20
>      trace_ppc4xx_pci_map_irq(pci_dev->devfn, irq_num, slot);
> =20
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 73d2d0bccb0..734892f47c7 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -109,7 +109,7 @@ static const MemoryRegionOps sh_pci_reg_ops =3D {
> =20
>  static int sh_pci_map_irq(PCIDevice *d, int irq_num)
>  {
> -    return (d->devfn >> 3);
> +    return PCI_SLOT(d->devfn);
>  }
> =20
>  static void sh_pci_set_irq(void *opaque, int irq_num, int level)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+E+DIACgkQbDjKyiDZ
s5JM4g//S3eKSoztBYSfXaiJO/9rehJ7mK4hYgR5S2pvQTSFkf6LP+HJaCkVa0lE
a4bUGSpR3bqHhGGYWF6ppIeGNowkD++B5YnsbeFaFVTxaRdDLY0WqcB6YnNVTU2Z
LskxdcLYtuDddT+S+DU/4ZkC+nXSJyfqU9CTjFq2QuY+4TI4Zf4zeK9m375Oo6qN
yUSBxj7pOiPy149ZF4tuIVBJy/WOijP5DUmz+I3xS/BqQecGuD2kQzRLGfC/oULr
TaulgUcr35isuBXOoV9SfQpiLjhzK7Thp1twsSV60rbHKN8mK5uL1M4h8NdJqVmm
ncct21mR6XQg5Zs/EB4ClFpa2IFKfCgDIA19wUUW627e1OAV8Xdb7OlLV7AkrB0i
mdt6kGLrs0dOSXUqqDZP04NdDFx49Jp1tK9ZBspjw9nxiluNhpOYC1SuND2+lenf
OiaZxMPNyIYKbCS1pfMGXyKsh8/qcf8M2RNtqdjRzKn2Odn9J+TFy6M7I6Y1VdTa
nJbPVDkHKoqRkkehT4fzSSW72NYznbJVTPi/NuTsoWLy6hqFxTemkZWf8PcjLhLj
X236DGBmExrBcFtPyuSV0iS2Nc8vxxzd+XiMUoAkPGmD9EWwU/++5S7HXm9PNrZ2
QetxthxhIXdnOkIu/hzAFMaj+8ABa4LWmrVBtq1SZmi1hdka2do=
=gg8r
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--

