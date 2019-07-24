Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F281DC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 03:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00DE2182B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 03:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pUhKA9Zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00DE2182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq7yQ-0002wr-EA
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 23:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42111)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hq7y1-0001bC-Iw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 23:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hq7y0-0008CH-IW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 23:29:25 -0400
Received: from ozlabs.org ([203.11.71.1]:53901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hq7xz-00084r-BK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 23:29:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45tgn972pdz9sBF; Wed, 24 Jul 2019 13:29:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563938958;
 bh=zTm2G24Ij5v8/2uJOOJIU7e09DM0So7joxNkd5w0tuI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pUhKA9Zr1snu1gV1Tyc19AJJNOQ7+kTwMgqhMQJxOvjWFuKK3xL6lZnnO8HhHsC5x
 bmKXMEOHEwyqmptti4Q0FA321waK5uXIaEcKnf4AQC9KHh0hzIrySKhu27GWNPNCRC
 BG7XmQCxhUFQkOyMc8KInUJvNVuCUC4VTcvc4v24=
Date: Wed, 24 Jul 2019 13:18:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190724031845.GU25073@umbus.fritz.box>
References: <20190723160859.27250-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oP9at/Ymg5VWhwKB"
Content-Disposition: inline
In-Reply-To: <20190723160859.27250-1-imammedo@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] pc-dimm: fix crash when invalid slot
 number is used
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oP9at/Ymg5VWhwKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 12:08:59PM -0400, Igor Mammedov wrote:
> QEMU will crash with:
>   Segmentation fault (core dumped)
> when negative slot number is used, ex:
>   qemu-system-x86_64 -m 1G,maxmem=3D20G,slots=3D256 \
>       -object memory-backend-ram,id=3Dmem1,size=3D1G \
>       -device pc-dimm,id=3Ddimm1,memdev=3Dmem1,slot=3D-2
>=20
> fix it by checking that slot number is within valid range.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index b1239fd0d3..29c785799c 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -38,6 +38,13 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState=
 *machine,
> =20
>      slot =3D object_property_get_int(OBJECT(dimm), PC_DIMM_SLOT_PROP,
>                                     &error_abort);
> +    if ((slot < 0 || slot >=3D machine->ram_slots) &&
> +         slot !=3D PC_DIMM_UNASSIGNED_SLOT) {
> +        error_setg(&local_err, "invalid slot number, valid range is [0-%"
> +                   PRIu64 "]", machine->ram_slots - 1);
> +        goto out;
> +    }
> +
>      slot =3D pc_dimm_get_free_slot(slot =3D=3D PC_DIMM_UNASSIGNED_SLOT ?=
 NULL : &slot,
>                                   machine->ram_slots, &local_err);
>      if (local_err) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oP9at/Ymg5VWhwKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl03zhIACgkQbDjKyiDZ
s5KIVw/9Eqc1hsavUnCU9MySGUnW5JsU/hHe8fXJkJZYeyPdbQCAcgb5st9a5XcJ
xXn4xIDU6LBffo/wciNfggAy/T0M8O81LBEBaeEQua/oQuufHRXCmvw+bze09acn
FdrCnzZ7tuf9gdvygW3h+EMl4+x9r2ZpDe5rLb3wLhXCbJuiY08j2xb3NSmR08bZ
8zAVEoKkNkxah9DYpPUcXfNDFJdzj1/ITotl26am28ItoFk+Zi1bV39scmhCNJh8
dPkGyEK2Tft0B1M91SCN7q4lOoKyXWPX8R+0TkwVXoRXW4O+IS+v09bcV9fsAnUU
we9FpV8tPcUxea7lBYYdwItpfQNA2P+/L8+rlPpy8bpOffdBqq5BGRbmwCw++KhI
Bb33cLWOjRaP9MZTqlHSBH+a+tZTD1tvgmdtBcjcWaG5bVoRpov4qypTLvTNEXbp
EDRbU2johIf9XUukKxTotaftHVudBCsIGVCzdkTA2t9B0p1pKbi7mnibVNUvS9y9
pl1dbAuRCik+TnFbOl691YPqDrCtAjI84TBUi4r7QeqTeYzDGI25fFMKocpOWNta
EvMh0g8gPRtbFeVypse15+IMdFgd73EDGddBxnIocs0oSBkp/p2SbHy5QWuMkJLM
ZjWSP8m2YZ8knpnNMIm8wdMKyjB8MjeGW/UMgg/Jqep7cNVyrtE=
=P6jx
-----END PGP SIGNATURE-----

--oP9at/Ymg5VWhwKB--

