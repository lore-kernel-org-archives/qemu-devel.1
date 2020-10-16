Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EA0C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D7420795
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ov7SEHQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D7420795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDgQ-00075u-0F
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDde-0004mP-Fj; Thu, 15 Oct 2020 20:30:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43987 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDdZ-0000EF-Hd; Thu, 15 Oct 2020 20:30:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC6Vx1HWhz9sTm; Fri, 16 Oct 2020 11:30:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602808217;
 bh=u86C+Be5GtRvbwO6V30GuRS/Hny80edoutFQh2L6gW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ov7SEHQapwCNtvma9ak0K5KgQAXdRfsKrldZPzw+SWn/PtXdLF4dvhZR8NH90B+Av
 Q3A85Aj0/7qFqHcvf772OJs+vtixEGFMYeG7DgErfFxC5T4PoR6UGImdZRb9j5zeTk
 aR2XWf29IGosOyzN1REfc2JVgP/hNYwzCtMykiU8=
Date: Fri, 16 Oct 2020 11:16:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 1/3] macio: don't reference serial_hd() directly
 within the device
Message-ID: <20201016001614.GB7078@yekko.fritz.box>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20201013114922.2946-2-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:30:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 12:49:20PM +0100, Mark Cave-Ayland wrote:
> Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs at =
the
> Mac Old World and New World machine level.
>=20
> Also remove the now obsolete comment referring to the use of serial_hd() =
and
> the setting of user_creatable to false accordingly.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-5.2, thanks.

> ---
>  hw/misc/macio/macio.c | 4 ----
>  hw/ppc/mac_newworld.c | 6 ++++++
>  hw/ppc/mac_oldworld.c | 6 ++++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 679722628e..51368884d0 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -109,8 +109,6 @@ static void macio_common_realize(PCIDevice *d, Error =
**errp)
>      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>      qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>      if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
> @@ -458,8 +456,6 @@ static void macio_class_init(ObjectClass *klass, void=
 *data)
>      k->class_id =3D PCI_CLASS_OTHERS << 8;
>      device_class_set_props(dc, macio_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    /* Reason: Uses serial_hds in macio_instance_init */
> -    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo macio_bus_info =3D {
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 4dfbeec0ca..6f5ef2e782 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -123,6 +123,7 @@ static void ppc_core99_init(MachineState *machine)
>      UNINHostState *uninorth_pci;
>      PCIBus *pci_bus;
>      PCIDevice *macio;
> +    ESCCState *escc;
>      bool has_pmu, has_adb;
>      MACIOIDEState *macio_ide;
>      BusState *adb_bus;
> @@ -380,6 +381,11 @@ static void ppc_core99_init(MachineState *machine)
>      qdev_prop_set_bit(dev, "has-adb", has_adb);
>      object_property_set_link(OBJECT(macio), "pic", OBJECT(pic_dev),
>                               &error_abort);
> +
> +    escc =3D ESCC(object_resolve_path_component(OBJECT(macio), "escc"));
> +    qdev_prop_set_chr(DEVICE(escc), "chrA", serial_hd(0));
> +    qdev_prop_set_chr(DEVICE(escc), "chrB", serial_hd(1));
> +
>      pci_realize_and_unref(macio, pci_bus, &error_fatal);
> =20
>      /* We only emulate 2 out of 3 IDE controllers for now */
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index f8173934a2..d6a76d06dc 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -96,6 +96,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      PCIBus *pci_bus;
>      PCIDevice *macio;
>      MACIOIDEState *macio_ide;
> +    ESCCState *escc;
>      SysBusDevice *s;
>      DeviceState *dev, *pic_dev;
>      BusState *adb_bus;
> @@ -281,6 +282,11 @@ static void ppc_heathrow_init(MachineState *machine)
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
>      object_property_set_link(OBJECT(macio), "pic", OBJECT(pic_dev),
>                               &error_abort);
> +
> +    escc =3D ESCC(object_resolve_path_component(OBJECT(macio), "escc"));
> +    qdev_prop_set_chr(DEVICE(escc), "chrA", serial_hd(0));
> +    qdev_prop_set_chr(DEVICE(escc), "chrB", serial_hd(1));
> +
>      pci_realize_and_unref(macio, pci_bus, &error_fatal);
> =20
>      macio_ide =3D MACIO_IDE(object_resolve_path_component(OBJECT(macio),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I5kwACgkQbDjKyiDZ
s5JxZw//cPa9yueoqpUnbozD25U4c9YspzwF8P/LLc5sHuKChfjbPl1KAsEnJmJO
pLlh1UMa/QCC60jw+V4moJ1X3C1EiER8Qnl1VEYvFMOct+DdThr0XEViGLqgu2Sp
hU45268yLZ3lxleC/1DLymFKwazCAUzUwHRWNM/bYdRKCw26tnbUSmm8eQiq2ZZy
c7RcJG8nBNq82EP4X5PkTZkLh2JQ3nMgK+qE0ySUpNt6zXZs33Q79RpQ/0iEsILi
djbSwPZYkx5FoWIpTgJWgqGEJUBDHnfIx1sQKbepkVXH7LVZ3ngX5bqKfya0FZ7b
oGZAcAFp+tsQayIFXKRmG6PaBrPU4uPEMp3vHVOkxpcGtYBJJ1m0ZBb9Iwv4qgHe
zL2Tc60SCOkqCUGfBnY7BbmgeG5fAjRQZYFlkaHI4awHyEYvFYSUMaf3TQzXoDnb
4yjaAD6ukQX+KD6qHxldYmG8aeQbp7jp6NoZQh/UbDwycLRwPWCo+t2KwJvUMtnY
YMnLWKCetb73PmyT+Dmff/XBIz2+5HmDWJsi0AI1/3IW9dY0MC2N960Tut+dVlKO
wg91UH/WanvUJ9ElMdMnu/wlm2CECpFCoNP5JP8Vuqo5+rA4ZL4luZRMFKL3HHTw
iJ+kI6Tfq2aYR0m0lt/E7/zS8VT9Sygr2WThr/ZRNCn5MBpwow0=
=2T8+
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--

