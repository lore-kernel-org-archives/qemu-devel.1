Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8231C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E47C222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i7/g4jdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E47C222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irtke-00017C-Qs
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 20:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irtk0-0000bB-3F
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irtjy-0007E8-Kc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:14:31 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60011 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irtjx-0007BC-Of; Wed, 15 Jan 2020 20:14:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ymSK1NKHz9sR0; Thu, 16 Jan 2020 12:14:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579137265;
 bh=clS9+EvTnJAgbcn8Qk58XBFuVl4DOoKbCYc+GfSkwkc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i7/g4jdy1IEwx9cK6kGs3MzQW0Gi/F7/QwhMeSRWeedGnm9X9qc59/Dzb3c6ZLSPK
 4nf8LsfpXK1fjBq6T8JmLnWjUKDpZjk13StTVrRO3OmOkuSm4yRfE08a7BOcwAVM4f
 5McdKJDP9PifElo8YFcLJ8MaByBm7ze2rN4oKBmo=
Date: Thu, 16 Jan 2020 11:08:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 59/86] ppc:e500: drop RAM size fixup
Message-ID: <20200116010810.GC54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-60-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-60-git-send-email-imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:14PM +0100, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported.
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>=20
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
>=20
> While at it, replace usage of global ram_size with
> machine->ram_size
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> ---
> v2:
>  * fix format string cousing build failure on 32-bit host
>    (Philippe Mathieu-Daud=E9 <philmd@redhat.com>)
>=20
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
>  hw/ppc/e500.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 12b6a5b..6d119fe 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -906,12 +906,14 @@ void ppce500_init(MachineState *machine)
> =20
>      env =3D firstenv;
> =20
> -    /* Fixup Memory size on a alignment boundary */
> -    ram_size &=3D ~(RAM_SIZES_ALIGN - 1);
> -    machine->ram_size =3D ram_size;
> +    if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
> +        error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES_=
ALIGN);
> +        exit(EXIT_FAILURE);
> +    }
> =20
>      /* Register Memory */
> -    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram", ram=
_size);
> +    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram",
> +                                         machine->ram_size);
>      memory_region_add_subregion(address_space_mem, 0, ram);
> =20
>      dev =3D qdev_create(NULL, "e500-ccsr");
> @@ -1083,7 +1085,7 @@ void ppce500_init(MachineState *machine)
>          kernel_base =3D cur_base;
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
>                                            cur_base,
> -                                          ram_size - cur_base);
> +                                          machine->ram_size - cur_base);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'",
>                           machine->kernel_filename);
> @@ -1097,7 +1099,7 @@ void ppce500_init(MachineState *machine)
>      if (machine->initrd_filename) {
>          initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
>          initrd_size =3D load_image_targphys(machine->initrd_filename, in=
itrd_base,
> -                                          ram_size - initrd_base);
> +                                          machine->ram_size - initrd_bas=
e);
> =20
>          if (initrd_size < 0) {
>              error_report("could not load initial ram disk '%s'",
> @@ -1115,7 +1117,7 @@ void ppce500_init(MachineState *machine)
>       * ensures enough space between kernel and initrd.
>       */
>      dt_base =3D (loadaddr + payload_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
> -    if (dt_base + DTB_MAX_SIZE > ram_size) {
> +    if (dt_base + DTB_MAX_SIZE > machine->ram_size) {
>              error_report("not enough memory for device tree");
>              exit(1);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4ft3gACgkQbDjKyiDZ
s5IrYg//SrrO46Wf7Z0+3YxdCa/nJYPM55RRcorJnM4tu6AYerusdHLvk+AHZn8V
+pdfIYaFOM5DHnxjKZsR5vcGNFaPS1C/LMZTVfebX/IC88Dv8bG4azwZo0JjtFqY
TVLiJNlouXLgS8gbK6Wy1JBBiU96siEeb6epBTNWUgPaIT7F2OD4rR+xx1p/jVDC
r9CsTYj4BSL5BRi9oPWqKUzuq6rYZ8fv484tELvF3pqFmp5NFj/zhP6sOfxIBr2F
M5AOTHQ6kBAL9KB4syogg8x5EI3g32CrD2vJPVwMXmSfn2cbKV6PQoLPgw9IOb0i
2GihFECLShWLgjKzsHVNIZuNYgDczIFDTYC+w5JZPn2oyJxbX6g+kP3Af1l7swyS
I4VkBL/zJ9r+Kyg0tXnG7DkwBHydCizHAqVQeqUveq+n3ArxhL56pRUMLmEZKsT3
QhkV/gFII7DhHKFcJqd+nqpkPMYAaqaE4vovqNXkjllLLZxUYYTnPWIcSp+rRhru
1TZOi+6s/IP7eqiYYge+Imy//jm+NdXo8QDcJnvAlpJWuOs799BTjja3PW6EKXWz
hWDMKfHwRFFwTdHVHw4k70o6zdqK0WuB5g3l8HwlDNf7Svhw16+K46n88PDPIEz4
VkGgaI0GQxfq+axUgsHtBwSQuzhse3o4W+yHaqOSVwXzAIlaaQI=
=dTyj
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--

