Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6483AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C01C218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="onlHrub/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C01C218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8To-0004AS-6h
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RS-00027M-I3; Mon, 12 Oct 2020 20:45:28 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43927 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RP-0006tz-WF; Mon, 12 Oct 2020 20:45:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C9GzQ4GrGz9sVK; Tue, 13 Oct 2020 11:45:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602549906;
 bh=+lALO7HgNrojm6+JDT1ennot8m6liZUo5GH8lT9O9Tg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=onlHrub/sstF9DahVxIp6mc0qSOP4MEbM6deGOjZB9YlBmj2WNzKmC0iPNNmnvsv9
 3+A/PXljQDpjzjzwlgkz9u0xN3HKj1rcZ4tGm8+tZtJG2/Azwk2ffuCZKXG0rDP9jo
 d1bf9D8mnrWnV5p4Cc2SRmbWrpeS5JlZ80Q3jcRc=
Date: Tue, 13 Oct 2020 11:45:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 5/5] hw: Use the PCI_DEVFN() macro from 'hw/pci/pci.h'
Message-ID: <20201013004500.GJ71119@yekko.fritz.box>
References: <20201012124506.3406909-1-philmd@redhat.com>
 <20201012124506.3406909-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dwWFXG4JqVa0wfCP"
Content-Disposition: inline
In-Reply-To: <20201012124506.3406909-6-philmd@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 02:45:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> We already have a generic PCI_DEVFN() macro in "hw/pci/pci.h"
> to pack the PCI slot/function identifiers, use it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc part

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/arm/virt.c          | 3 ++-
>  hw/pci-host/uninorth.c | 6 ++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e465a988d68..f601ef0798c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1144,7 +1144,8 @@ static void create_pcie_irq_map(const VirtMachineSt=
ate *vms,
>                       full_irq_map, sizeof(full_irq_map));
> =20
>      qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupt-map-mask",
> -                           0x1800, 0, 0, /* devfn (PCI_SLOT(3)) */
> +                           cpu_to_be16(PCI_DEVFN(3, 0)), /* Slot 3 */
> +                           0, 0,
>                             0x7           /* PCI irq */);
>  }
> =20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index c21de0ab805..f73d452bdce 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -70,10 +70,8 @@ static uint32_t unin_get_config_reg(uint32_t reg, uint=
32_t addr)
>          /* ... and then convert them to x86 format */
>          /* config pointer */
>          retval =3D (reg & (0xff - 7)) | (addr & 7);
> -        /* slot */
> -        retval |=3D slot << 11;
> -        /* fn */
> -        retval |=3D func << 8;
> +        /* slot, fn */
> +        retval |=3D PCI_DEVFN(slot, func) << 8;
>      }
> =20
>      trace_unin_get_config_reg(reg, addr, retval);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dwWFXG4JqVa0wfCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+E+IwACgkQbDjKyiDZ
s5J+QQ//T4fQpDPR/JHRFc6LbsMxAjBTFaF0roQjm+CI8Md8/NY7ptdCqg1+GKy6
eoEUInbZ/945BywYqGDOqWxu3/zJcpG+4spb5usgG+IKMT3N5xuUzKd+PBIaJilP
JhB2UkcG5VhUOvf8FhbPGmAO/M6WYElXbtKGPy9/CLFLNXzWXiJ0MZy4TAAscpra
M3Xz8Fs/lwFTNOQKFXD7BpuESdLdWy5jPMhODBx0H0OCrsr6ZnZcIXYlVUUi4K3f
rLpdkhDyN1ZF2VeLYTslVEfMVCPHxSDFJRRONioEjpP6ELFnXAEvNqRmyYzF/a19
FJ/5nB7L4wNXQ9rV5C6E72joI3nkjujeKZT8lfRSKcz17owRlIJrrwa9hbbxomy+
G9dmE57lTw42mRCEd3nZgeq7CwBK0a5IfJOkt5WEriUMfHjRFyhCB5t7sqbaL5Aa
NDCD7XZowgia7WmsZvAb/dMrjQpUCzya4OtR16TQ63W6wKC/pCr6lb/J+BS9RCu0
mSdB2d1L/eItGWyJvGIHVbf7JSIY0pLYnkaM83E0QsXTKRABRzhQ6CBsK8URM6kh
5HziPQxsVW1ZkJ27hfLKjbZwHshw7IgicYRCDCLa+WfcZQv750KiJq/ku/Gnjq59
uy1uR5C2STlSxRSSNraOCu0u7ad0arUjhx/SNUtxXQBpQWAXBhI=
=E6th
-----END PGP SIGNATURE-----

--dwWFXG4JqVa0wfCP--

