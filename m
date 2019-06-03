Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A6AC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544F927C73
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EnXpnuZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544F927C73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgy8-0006tK-G8
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:01:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hXgqe-0000zG-ST
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hXgqb-0004aL-7b
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:53:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hXgqX-0004Qv-Qn; Mon, 03 Jun 2019 02:53:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45HQkD3WGqz9s7h; Mon,  3 Jun 2019 16:53:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559544804;
	bh=YAoY1NXQKRdLk+MDmT7Ggel0JrcUK/Jy4LcDH+d6e+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnXpnuZlv6Tjmv7Fx0ms0qKxG9S5kTX30UbM6SnQba0fMXtncEMwDvmwwtRS3ZNMf
	VC5a0Lk4fC8HLp+zALunn1r6nKqA6quHsSSFlv17C8BzDKtA9rz8YHDL98vZ4z49KD
	SGMvqaOsHoMtjNP5W2yEezDOmjPO10qmT7irqWuo=
Date: Mon, 3 Jun 2019 15:04:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <20190603050417.GA3285@umbus>
References: <20190530053831.22115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20190530053831.22115-1-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 0/8] pseries: Allow hotplug of P2P
 bridges and devices under P2P bridges
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mdroth@linux.ibm.com, groug@kaod.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2019 at 03:38:23PM +1000, David Gibson wrote:
> PAPR has its own PCI hotplug mechanism which we implemented quite a
> while ago.  However, we weren't able to hotplug devices under PCI
> bridges, because the pci-bridge code would try to handle the hotplug
> using SHPC which won't work with PAPR.
>=20
> We now have the infrastructure in the hotplug core to have the machine
> take control of the hotplug before the bus tries to claim it, which
> lets us address this.  While we're about it, make a bunch of cleanups
> and also allow hot plug of P2P bridges themselves (this turns out to
> be quite straightforward once the rest is in place).
>=20
> For now, we don't support hot unplug of bridges - this seems to cause
> problems, at least for a Linux guest.  I suspect the problem is on the
> guest side, but for now just prohibit until we have time to
> investigate properly.

I've fixed the problem Alexey pointed out, and I've merged this
tentatively to the ppc-for-4.1 branch.

>=20
> Changes since v1:
>  * Added proper cover letter
>  * Addressed some minor comments
>=20
> David Gibson (8):
>   spapr: Clean up device node name generation for PCI devices
>   spapr: Clean up device tree construction for PCI devices
>   spapr: Clean up dt creation for PCI buses
>   spapr: Clean up spapr_drc_populate_dt()
>   spapr: Clean up DRC index construction
>   spapr: Don't use bus number for building DRC ids
>   spapr: Direct all PCI hotplug to host bridge, rather than P2P bridge
>   spapr: Allow hot plug/unplug of PCI bridges and devices under PCI
>     bridges
>=20
>  hw/ppc/spapr.c              |  25 +-
>  hw/ppc/spapr_drc.c          |  13 +-
>  hw/ppc/spapr_pci.c          | 486 ++++++++++++++++++++++--------------
>  include/hw/pci-host/spapr.h |   4 +-
>  include/hw/ppc/spapr_drc.h  |   3 +-
>  5 files changed, 327 insertions(+), 204 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz0qlEACgkQbDjKyiDZ
s5JBhRAAm09Oz6bZ6yRVKTYYR/5Y7+eBogcMKNCnX2J09j28YREonPBhCWWvdAaL
SV5jJHIIMrtwgG2wa+d2jcIkXxIIUHRSj7al65eF/tIsjivAgCt4KOSd82S0WG3U
5A7Gd8Pk8gZ8OcnfSTb1Z+6J8Y0DsQkvEGUzlWnKdM5OddH9Ifzw2gkvFf2UAg2x
ZZm6WiWanqIu/Ysi3fWpodWFiwJgbHxvL89msz438L3vFFbtAAXYqTqTQOZEH6yk
O4MQRr2/OgdE1cUNPDGAYVzsRNj8hy0Y0ulNqcZvNNT9yDd/BQ5EbfRxrrIv6xZx
vL1DSyDjp+omQSsdM26186yre9AhTr3szNPEyUx6uDdrKr94C8hkc8cWIDvpeBUR
e4kmvpHPY17scEQHd8n9iFyBqEZOnEkyzGoNEqRN2JEby9p+wwKPqgfj13vfJdpM
LKiXiQm4JBYCG/VCZgeaCGp4DBRpMQuIDHp89CrU+MijCPPq0KXLGRZdRhiDrMYG
QqK50z+mlvhXpZwxsezvIMt4wkzlZTLTIQ3vVfh7aWb4Sm8aVvTKDWU880gG6L3t
x/YICKnPFfSv8oVE3f349SV1NLMVYGHD/CIhv80slAISGFE1Iw6qmPGP+EVtq/Yg
P1ETq3Pe3U3PEFf8pXwTm5SZLGDFZ8C6CscxLzMMU78pGC71Xe4=
=vysS
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

