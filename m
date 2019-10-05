Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294DDC4740A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24F2222BE
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="McKhIDMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24F2222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGuVq-0006kp-UV
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 20:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGuUk-0005hl-P5
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGuUj-0001m3-FT
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:33:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGuUi-0001jI-6W; Sat, 05 Oct 2019 20:33:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46m4NT1F3Vz9sPd; Sun,  6 Oct 2019 11:33:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570322025;
 bh=vd2tMt6ADm3Nb+MHs45Q9Ze3gSK32QOFcAiikIPx/c0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=McKhIDMJzM2Z+LUOcc0cL1ll17973zgPfP7hb/mMQQg550sSAE00fuIyCfp0ZQDas
 0rnVnCh+MwQwmYLhwIfR+IoST1hBcejg05+6WNFmlDc/XPlwzjC+TOJI/9UkiWmnrt
 ecA2yqOfcvKcOyHZU4vExYFcCF0XyT0rrQT4XgKc=
Date: Sat, 5 Oct 2019 20:21:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] xics: Make some device types not user creatable
Message-ID: <20191005102133.GE29310@umbus.fritz.box>
References: <157017826724.337875.14822177178282524024.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <157017826724.337875.14822177178282524024.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 10:37:47AM +0200, Greg Kurz wrote:
> Some device types of the XICS model are exposed to the QEMU command
> line:
>=20
> $ ppc64-softmmu/qemu-system-ppc64 -device help | grep ic[sp]
> name "icp"
> name "ics"
> name "ics-spapr"
> name "pnv-icp", desc "PowerNV ICP"
>=20
> These are internal devices that shouldn't be instantiable by the
> user. By the way, they can't be because their respective realize
> functions expect link properties that can't be set from the command
> line:
>=20
> qemu-system-ppc64: -device icp: required link 'xics' not found:
>  Property '.xics' not found
> qemu-system-ppc64: -device ics: required link 'xics' not found:
>  Property '.xics' not found
> qemu-system-ppc64: -device ics-spapr: required link 'xics' not found:
>  Property '.xics' not found
> qemu-system-ppc64: -device pnv-icp: required link 'xics' not found:
>  Property '.xics' not found
>=20
> Hide them by setting dc->user_creatable to false in the base class
> "icp" and "ics" init functions.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2Ybq0ACgkQbDjKyiDZ
s5K9AA//b3NQtlo4E7tORSlai4K3AIeifC7skpUPWU91rVOASf0SzVL2TAfYjYxl
xo+BVCaAe577iu7kInFYaReA4ZGcQod51DuZ96+eFRrXXbKZY6L3z2zRcVtj2k2M
w4b3TIfkKFTjBu95UkzlhETVz8W/Nos+4ljHnl+lqz34C4RRfLqkwNtE4B1rKwJP
qK0ai+elMYkUdDaS92+TCD1uWszFr4OYo0Tr8GN93aHdrvCdXCuNpbrJcrAXUutM
psrNdiGJYbsbKLjbFBXSRpUzW6nqtLpgWGuRei3bDBbVg/U/EWSrQQvC/+hwQP0p
ZQewdEeoZs7eVlAOsfZA8cfo7KByerkwrhQS/K3t8aVo+eR883YGraQNGPZyiXAE
LUdUkfzcmluvMoXSvqqZDL02EeQsZ8iYtxFhJnKQcoMqPFIBf8ijLCqT0xbWBW/t
Ojo7am6C5jG6vQXDUcD2Y+ySfWWhzFtjWLQUvgtB8yRt2s6ejwvqTgImM5BJq6sH
aEeDqz9QC7gE8s/gIE+rF8sHS/xXbXyoBrnT5ybyrx01+wvSWUCbZV8IkBWKHswv
Ce/XUjufZnqJKeV/13SCUF/CBfqhKbRnT5pmA2FBNXZ6sWut6FpHsU61QL7zRR4Y
1VpAVkZYFY1nS7BsIDW52sTo5f8RauWL6MtRTPc1wrHdzqwms0k=
=tA2q
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--

