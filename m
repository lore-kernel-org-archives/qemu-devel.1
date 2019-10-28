Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91457CA9EC2
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 08:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C10220663
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 08:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iqNUEkea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C10220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPMRX-0008KJ-QI
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 04:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iPMQA-0006sW-Cb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 04:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iPMQ8-000577-OR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 04:00:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48599 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iPMQ7-00051T-J0; Tue, 29 Oct 2019 04:00:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 472PBg3gfXz9sPT; Tue, 29 Oct 2019 18:59:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572335995;
 bh=btAg6p4pQkDdXsFErKiKKtgj/vko0VFRZolTTuK7R3M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iqNUEkeaEFWLyuhqNgTRFOpA5DfLV8OcIVZ2/OQefQLdicng9fVt0VKL5u233xBEQ
 iXbXT1DTC+V+DoGmyYEnUTjhtxURc6viQmzWesBMorBfZJmvC3UFdnu8J+CpxGGkTu
 vpZIR1UvquDBJyMWGRlsH0RqkR+1/chx9BwAbS4w=
Date: Mon, 28 Oct 2019 23:22:26 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr: Add /choses to FDT only at reset time to
 preserve kernel and initramdisk
Message-ID: <20191028222226.GQ3552@umbus.metropole.lan>
References: <20191024041308.5673-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hIO1AjEoFJ7b3ahE"
Content-Disposition: inline
In-Reply-To: <20191024041308.5673-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--hIO1AjEoFJ7b3ahE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 03:13:08PM +1100, Alexey Kardashevskiy wrote:
65;5603;1c> Since "spapr: Render full FDT on ibm,client-architecture-suppor=
t" we build
> the entire flatten device tree (FDT) twice - at the reset time and
> when "ibm,client-architecture-support" (CAS) is called. The full FDT from
> CAS is then applied on top of the SLOF internal device tree.
>=20
> This is mostly ok, however there is a case when the QEMU is started with
> -initrd and for some reason the guest decided to move/unpack the init RAM
> disk image - the guest correctly notifies SLOF about the change but
> at CAS it is overridden with the QEMU initial location addresses and
> the guest may fail to boot if the original initrd memory was changed.
>=20
> This fixes the problem by only adding the /chosen node at the reset time
> to prevent the original QEMU's linux,initrd-start/linux,initrd-end to
> override the updated addresses.
>=20
> This only treats /chosen differently as we know there is a special case
> already and it is unlikely anything else will need to change /chosen at C=
AS
> we are better off not touching /chosen after we handed it over to SLOF.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-4.2 (with the typo in the subject line corrected
/choses -> /chosen).

> ---
>  hw/ppc/spapr.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d4c07a9b1bab..0580789a1509 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -925,7 +925,7 @@ static bool spapr_hotplugged_dev_before_cas(void)
>      return false;
>  }
> =20
> -static void *spapr_build_fdt(SpaprMachineState *spapr);
> +static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset);
> =20
>  int spapr_h_cas_compose_response(SpaprMachineState *spapr,
>                                   target_ulong addr, target_ulong size,
> @@ -947,7 +947,7 @@ int spapr_h_cas_compose_response(SpaprMachineState *s=
papr,
> =20
>      size -=3D sizeof(hdr);
> =20
> -    fdt =3D spapr_build_fdt(spapr);
> +    fdt =3D spapr_build_fdt(spapr, false);
>      _FDT((fdt_pack(fdt)));
> =20
>      if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
> @@ -1205,7 +1205,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *=
spapr, void *fdt)
>      }
>  }
> =20
> -static void *spapr_build_fdt(SpaprMachineState *spapr)
> +static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset)
>  {
>      MachineState *machine =3D MACHINE(spapr);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> @@ -1305,7 +1305,9 @@ static void *spapr_build_fdt(SpaprMachineState *spa=
pr)
>      spapr_dt_rtas(spapr, fdt);
> =20
>      /* /chosen */
> -    spapr_dt_chosen(spapr, fdt);
> +    if (reset) {
> +        spapr_dt_chosen(spapr, fdt);
> +    }
> =20
>      /* /hypervisor */
>      if (kvm_enabled()) {
> @@ -1313,11 +1315,14 @@ static void *spapr_build_fdt(SpaprMachineState *s=
papr)
>      }
> =20
>      /* Build memory reserve map */
> -    if (spapr->kernel_size) {
> -        _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)=
));
> -    }
> -    if (spapr->initrd_size) {
> -        _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base, spapr->initrd_siz=
e)));
> +    if (reset) {
> +        if (spapr->kernel_size) {
> +            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_s=
ize)));
> +        }
> +        if (spapr->initrd_size) {
> +            _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
> +                                  spapr->initrd_size)));
> +        }
>      }
> =20
>      /* ibm,client-architecture-support updates */
> @@ -1726,7 +1731,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
>       */
>      fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
> =20
> -    fdt =3D spapr_build_fdt(spapr);
> +    fdt =3D spapr_build_fdt(spapr, true);
> =20
>      rc =3D fdt_pack(fdt);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hIO1AjEoFJ7b3ahE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl23aiIACgkQbDjKyiDZ
s5LdahAA0r0L8TA0wx0UMm+Dj/MLrVZ5GDRBPdXvjc4XWZRnDnK51tYj6WSj2GrQ
o/EmdAhXNL5xwj2Tc1I34csUXRhBqNaUnS3CMo1TnbhHkYgJq4XEEAuUotd4KlF6
yX87pXTotXErZde+eFF1wfqjQAUGC/ZaHxlS1uCiIhGxLkejT3IalxjvnA6rchcz
hxJ74G8q4vQdOFV8T3SdSExcO2AIBiB7T9L4dBNR0Ro5DawIbTpwf7jER9kbb36e
Xd/i1U+h9zFq2ga0YrHsvJpYuqKKYE/wxPARHFFDe8ZwuefkdPZjagfWYZIm9YRK
VoSuzvBAJ+YRE57PzzPD8pvzkbiSdtjOTzrAJEiMjWfYOWNNPi2wRiOx3D+1iawO
xoiSEBlho/paxax/VLjWABANVWZZoNxlo4LRq67+cb18rjD6EfSKuJ2ofYZpADEf
bLfqZ3S7fX98acOzkphz3/3uQKp0tLqT5TpISuYPHkIhMtkJcrEFRTuDGM6JL5O5
iMGBKwqFhiBTcomXNsH2y+N0dzPHVVphEzRlOJk3DPjbwN/R2fqHAwFA0DqcBmXw
wQ88/qXrhXeKmwuZcHgkSb9mrQc+5JLwq0XciZgJK4TVr1KgMGTm/NMltYtPzuGS
sI8bqbyx3qr0Kv4h45jmWneLNi8ehTdKzTx3ultoNywT8xnVeSE=
=9o3z
-----END PGP SIGNATURE-----

--hIO1AjEoFJ7b3ahE--

