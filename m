Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D3C3A5A7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD67215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BLWmnKyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD67215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4iZ5-000649-Jl
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i4iXb-0004Tm-Rb
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i4iXa-0005b7-M6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:22:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51053 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i4iXY-0005W1-PF; Mon, 02 Sep 2019 05:22:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46MPk45F0Nz9sNf; Mon,  2 Sep 2019 19:22:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567416140;
 bh=HfCPBq2mC6akf6Q0McRaU+SzgK78ua6Mhb5jaXngj4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BLWmnKyVYxYAlH3mqCJ63USpr2AIr8C3B63TBSpo4p2Eu2TLwTCprEIF3PVeeH0M9
 fz3UkN/s9EyFdRp1L1hNU6kmAhsTfYp9heABsCziSPm+bDcFhzQDeL+dAga8eHOJME
 YLXbgunGDLoimV7LL2Z1dhK+08bokOTVfomXCq0I=
Date: Mon, 2 Sep 2019 19:14:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190902091423.GB30674@umbus.fritz.box>
References: <20190830161345.22436-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20190830161345.22436-1-lvivier@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] pseries: do not allow memory-less/cpu-less
 NUMA node
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


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 06:13:45PM +0200, Laurent Vivier wrote:
> When we hotplug a CPU on memory-less/cpu-less node, the linux kernel
> crashes.
>=20
> This happens because linux kernel needs to know the NUMA topology at
> start to be able to initialize the distance lookup table.
>=20
> On pseries, the topology is provided by the firmware via the existing
> CPUs and memory information. Thus a node without memory and CPU cannot be
> discovered by the kernel.
>=20
> To avoid the kernel crash, do not allow to start pseries with empty
> nodes.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-4.2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1s3W4ACgkQbDjKyiDZ
s5JltA//b/eyIAVD4+ftbCMz/Obm+AtBwo7ZoQsH9FtRG2Rgjdrdu/L8u24YVciY
FKBQUpNrjq+2HEKsAL80bqm993LjOrg6JCh7a/k+7/Cif6b8nhptQePb1xU3L2E7
02+h15/fd1a+FOgG1i58iSj3b0DdnvAoNNEcnHsvMQW9+q7Q1aA98iKRPar8g5Z8
wt0NRtop3RufZzG4L5q4ppZiOj4bfnbsGFZoyY60I/yfqkY/Nt0iYKyZ6FUB5/UG
uLQVtnCi3LrmIVAfNw20QQL8+oNzW9Lmvn52jwogJnWZF4M+VSLV5KOGSEBCixPC
HwUEMtAUvpzjfNMDRG3ocX+7CSuKaADPx2JKa1ANwgHummLO67ziOOJGNy3PFp8n
h3OY+fCiLzm9gt1cOgU/AcNHba49atE/5NxUmrpilyTRC0JUjicigPLr99l7gy6v
ejCcCXekrrTqB/5J4LUyYZhXAu1pfAedhK3W31V9dDlzpVNlbIpcVR8DfTv5qGpH
ozfojzcR5SFcswLWTmOSZDGq3pAa910uiANaPDOrPeXnA4nnb1noHRcO1NjZNJnv
z2c2bOKpZhslmfhOexFj6J5q451Hlogy0MRmVNVohIyGH82H6gYldlP4zSRDg/8X
xIEYy8cg3BuyuQG3U3uEM/BT4nhhtxdO1iJKLytHqd4GsneYsDA=
=fu9I
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

