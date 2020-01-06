Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE19C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFE72072E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iKXNnS3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFE72072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iocQM-0007c3-FA
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 19:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJk-0007rC-No
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJj-0005XU-9q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:52 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:34553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iocJi-0005PO-S8; Mon, 06 Jan 2020 19:01:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sCGd5qd2z9sQp; Tue,  7 Jan 2020 11:01:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578355305;
 bh=JW2A0tTFBaP1VMkBWGg8bauxWYDN+FvFtnNVgZpjfAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iKXNnS3WipsppcULLme5EmE1NyiY+zGjnUwQEGEkvtc8luWjTfigfmob1iKruKquO
 FGdCFC6MQjyx21lX7Frea2zIimjfij1oWsb48uEvWGZmO07Rb/9sRHKf+HP8uXbi/t
 u6Sv6kWt6kDXmlo5x31vcY4PU8/Egc/jh+5OS2Qg=
Date: Tue, 7 Jan 2020 10:44:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 01/59] spapr.c: remove 'out' label in
 spapr_dt_cas_updates()
Message-ID: <20200106234435.GX2098@umbus>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-2-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l4GQ7sizse6iPvDe"
Content-Disposition: inline
In-Reply-To: <20200106182425.20312-2-danielhb413@gmail.com>
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--l4GQ7sizse6iPvDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 03:23:27PM -0300, Daniel Henrique Barboza wrote:
> 'out' can be replaced by 'return' with the appropriate
> return value.
>=20
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: qemu-ppc@nongnu.org
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Applied to ppc-for-5.0.  I see this is part of a larged series which
might have a different merge plan, but it should be an easy conflict
to resolve if that happens.

> ---
>  hw/ppc/spapr.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f11422fc41..1bfe47337c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -878,7 +878,7 @@ static int spapr_dt_cas_updates(SpaprMachineState *sp=
apr, void *fdt,
>          g_assert(smc->dr_lmb_enabled);
>          ret =3D spapr_populate_drconf_memory(spapr, fdt);
>          if (ret) {
> -            goto out;
> +            return ret;
>          }
>      }
> =20
> @@ -889,11 +889,8 @@ static int spapr_dt_cas_updates(SpaprMachineState *s=
papr, void *fdt,
>              return offset;
>          }
>      }
> -    ret =3D spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
> -                                 "ibm,architecture-vec-5");
> -
> -out:
> -    return ret;
> +    return spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
> +                                  "ibm,architecture-vec-5");
>  }
> =20
>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l4GQ7sizse6iPvDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4TxmAACgkQbDjKyiDZ
s5KAURAAh8HW6gNLOiPojeb2WYWPsUFh9EctIsImKhszDVbE0XNIBZ2k/iEqZUb9
23UqawnlqVziTtMEDRcAhxekwlGiZy1RFo3mkp+p/UPGLnmJPHBXnQIUbKURMUoZ
WLjeI/y+hbl5BbbUijGKfrApCHnp1PueTwoMIgAOfpSCq5d9qnIlqKtTOasYJJkq
WN2bGaOpbJlkkYe66Z7tVhFNZ1Bwz81/gV80tg6FKNo7rV6VlMys38gs1jjZRalO
I2PyTEGEzyRqXlQ9J2b/nk52pkOArqiD/wl+AG5A9ceNqWUvlKK2iscQTZcHAdrn
zht0Fgl7HUjyayyXZYlmexoy19/+qjWDlpp+9kf8DLD0xIGpmeDtx87k857Gfpod
FzFQsbgD5JkMGJZSbeOXJwc/uM6B5hMnRWWrAMYhy7LLcZqGGOSsUfJ7K8XY4xDe
f0AtYEt7M+eaC9X7jyZMJNpRz6X3tL2r7GTsM3uamL9D+/JM2i8Usu2yKlnkozft
7Gn3LnIsPSyQhPYF1xRl8pKlFaA97zUjzS7hRiWzrGmX43opD91NVKZ0BmMtlVkZ
W4rNZqZ9UkgibFTm4DViuc1uWy2tM4bL1YXYyu6UexPZ0vVkBCg6Oul5hQE57CUW
DNuWki5aAGaVrh7xvRmWu1upxXf4atYEEH/QOnR4ksQ3SzmPbnI=
=+++J
-----END PGP SIGNATURE-----

--l4GQ7sizse6iPvDe--

