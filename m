Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543EDC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 06:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215852238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 06:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SdZXTJoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215852238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpoSF-0002IZ-B4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 02:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57792)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpoS4-0001tx-JP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 02:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpoS3-0000Gi-Dg
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 02:39:08 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53639 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpoS2-0000EA-OI; Tue, 23 Jul 2019 02:39:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t82Y62lhz9sDB; Tue, 23 Jul 2019 16:39:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563863941;
 bh=ZuITjtz4JeqRURiGsl6V04M1zh7CHzI8O123Hajp1S4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SdZXTJoLLaweSIb6kBKcbiRq6wovOdoj/vDNENdFhPsF+SbJHRa2Vm5OjyCdwrL6y
 eK5OQBKgX/kVFAJ/h67+iX1zOjzy8NmAUeRmETIqdL9+dm60iaWqNZ39auQS2Ajel/
 ka6fNL5skSxXkjYkv0ZnRMq4SjXEtOjYotIWPm5w=
Date: Tue, 23 Jul 2019 16:37:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190723063730.GT25073@umbus.fritz.box>
References: <20190722182347.25075-1-clg@kaod.org>
 <20190723013808.GJ25073@umbus.fritz.box>
 <177076c3-b418-fb52-74c9-ee98f5fe4694@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4AfY4lbNVy6SI0IG"
Content-Disposition: inline
In-Reply-To: <177076c3-b418-fb52-74c9-ee98f5fe4694@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Introduce PowerNV machines with
 fixed CPU models
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4AfY4lbNVy6SI0IG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 08:00:27AM +0200, C=E9dric Le Goater wrote:
> On 23/07/2019 03:38, David Gibson wrote:
> > On Mon, Jul 22, 2019 at 08:23:47PM +0200, C=E9dric Le Goater wrote:
> >> Make the current "powernv" machine an abstract type and derive from it
> >> new machines with specific CPU models: power8, power8e, power8nvl,
> >> power9.
> >>
> >> The "powernv" machine is now an alias on the "powernv9" machine.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Ah, sorry, I wasn't clear here.  I don't think we need a different
> > machine type for every cpu model, I just think we should have powernv8
> > and powernv9.  POWER8E and POWER8NVL don't significantly change the
> > system design (IIUC) so they can still be done with "-machine powernv8
> > -cpu POWER8E" or whatever.  I expect the same will be true for POWER9'
> > when that comes along
>=20
> I understand but I am afraid we will to have one machine per CPU family=
=20
> because POWER8E and POWER8NVL already have their own PnvChip :=20
>=20
>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_ini=
t),
>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_i=
nit),
>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
>                           pnv_chip_power8nvl_class_init),

Hrm.  Is there an actual reason we need different chip classes for
these?  Even if there is, I don't see an inherent reason that implies
separate machine classes as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4AfY4lbNVy6SI0IG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02qygACgkQbDjKyiDZ
s5IQ2BAAhQwIs46dEIpr5G/q+UfZhfnVr243i12G6ptqHiwdt2xMiliVu8m9rdEc
ibahkocd6kT5cWAL+TXc/jhawJNg0iJpyPrQ+t4nMbHhOvZY3s+5iEwfFTyzCuGG
vMGpmazXmJWxscuBuEIHVZunOckgnXhyaiRIGi/mT9W+IlI5BnoleRzikL9Rp999
7msY9k93msspKh8W+hllkXuyfHuzjKLan0hdt9shOHbkQ7/h+naHfN7Y97efMh+8
UwTsc2dWMLMopuCVlXiuIZocE03WpjBvO6G9n3GuQoy62DP1nxOaG3aIPsSztMq7
BZV0TzAggZbEbPv0zIzdOG+wXkVnlmQbh8ApSiMfHT2apyQu2HkcKC/jYoOscb78
l4GltNn6Ww8b7glqNh4AW/umdM4nfd4toPCdziOOkNm46xLXLrxCaASbfOPfEfkM
aoj3BBNsc4OcF2TonPbKbecMS/BAK+MUbnJ/Q7PCdTUMPYX5Bi0aOQxQL+3rwFeV
F70ezc5q35ahVzPDtFVcuWM/H56ssgIsw2cQD0NQhGrEQ99RnFf7fjgcjkv3UMny
WIzQO8/68wMrW9mVH70XjprzqOcXp3LLHOrW2hWvoaGKNF2yP4m5UAfheuzddppT
eJme3FA364yZhQClvjIbylopldYq58fylZ6Xy7iAP7k54rxTTps=
=x5/r
-----END PGP SIGNATURE-----

--4AfY4lbNVy6SI0IG--

