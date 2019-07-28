Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C187EC7618B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 07:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AE62085A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 07:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KYLEBT8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AE62085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrdIN-0001TQ-L1
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 03:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46782)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hrdHw-0000qa-0V
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 03:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hrdHu-0007x6-Uf
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 03:08:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56277 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hrdHt-0007tD-Jg; Sun, 28 Jul 2019 03:08:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45xDRm6zQcz9sBF; Sun, 28 Jul 2019 17:08:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564297684;
 bh=KstfuWTWADoTY+2azzG6eeKuzCRGhB9KMNPt27TM/UI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KYLEBT8pRrcUn7VlqJojdoMMGTkclPzP5RdJ7+TRJbHzKd01sQpAEmirMkzKaGgM+
 YDouSSBv07vUSLSjqyU0qLKZilN1BwDPPRlO2JH6lDeJx7wAY8RihtF2+k8EJvZfoA
 +lTVUWwOampXyCYS4Jagt/vH+ns//CQjNU5t8Zqs=
Date: Sun, 28 Jul 2019 17:06:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190728070639.GD5110@umbus>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415228410.1064338.4486161194061636096.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <156415228410.1064338.4486161194061636096.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr/pci: Free MSIs during reset
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 04:44:44PM +0200, Greg Kurz wrote:
> When the machine is reset, the MSI bitmap is cleared but the allocated
> MSIs are not freed. Some operating systems, such as AIX, can detect the
> previous configuration and assert.
>=20
> Empty the MSI cache, this performs the needed cleanup.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr_pci.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bc22568bfa71..e45507bf2b53 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2078,6 +2078,8 @@ static void spapr_phb_reset(DeviceState *qdev)
>      if (spapr_phb_eeh_available(SPAPR_PCI_HOST_BRIDGE(qdev))) {
>          spapr_phb_vfio_reset(qdev);
>      }
> +
> +    g_hash_table_remove_all(sphb->msi);
>  }
> =20
>  static Property spapr_phb_properties[] =3D {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl09SX8ACgkQbDjKyiDZ
s5I8Fw//ViyaQGe+VNYmLzYob9cxJQMh5y3cJ4uFD0sOB08zj+w5IsdqRMFUQZVj
a+YCiYBwMi5kqrAqiM/cpghKGFIQy3XphSqK0FuRFenP323jimh6+ua5qKBQXSWo
82yypJyMo0CI8b6Q8otLPq+3KYuc60/ViP4nYgvWKnY6y+r6MYOjrcVyF0P9guwy
BZkGERYnipy1gz6qtbJDIU5WtMHvSn6J0l6o9geSYMCvvc61XqPfmYHcwzEZbTfm
y8BtSznlEHjrsYQZ0UlAhdH7BcVY1wx2gELV/gb+H1HIN/OUj9TJNNxwMCI16ty9
YQPNJ7dtWU/lj/MGLUckm4AZvoUvmAJGgrU7lfkMjl1usqddDiBQnJ6aSWQV2L4J
Jdj6KdKaSc3eKAREIpiTb8WDxEtBvOaRk0SIG8sEHz/WlpLM+5qAOsdbyzEvUug8
kd49cWJLy8/8tFIvLOGbOHyVLi5qsG4eh4MfZK/eKy7jAwwKNx+9mKXp5yK5G+Tc
4IcV0IIn4iAroctgKvkE2JYpq5OoRtiqI7/YD2NtV3hVwKQMfv+Pvg9NCy5WIiha
GwmjcSEv/z2QNl9j4/rvaETf9/DYNaIFtRlnX14olZLkkwQhiQcHCjM9nzci/lMZ
DumAOav3Lf9TDZBX3GqLWW7TzIPuNL28pFafkuYF2VSfhbdmNcQ=
=+ub5
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

