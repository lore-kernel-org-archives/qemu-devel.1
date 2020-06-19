Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6384420771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GseJdLHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6384420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm5QX-0003O6-LK
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 21:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm5PZ-0002J8-QQ; Thu, 18 Jun 2020 21:01:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58341 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm5PV-0007hN-UV; Thu, 18 Jun 2020 21:01:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49p0qv1Sgtz9sDX; Fri, 19 Jun 2020 11:01:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592528491;
 bh=tx0r9aF6bHVTYyJWgJCBQuxygcvmWgiZiJS5B4hROZ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GseJdLHhyS/D3LTe7STDbU76+BQzei5692ei90VtnvS8RWBTz5p5WyrE+AJOSz2lr
 MDyuYpO9beg1WETPbISMubcxannkDc9heIPS50DzhZoie4eNUr68r2YSblLCBUShPQ
 OV4FiAm4/9CTnnccS4N+nkSzkjxnkodjJ8M1noXA=
Date: Fri, 19 Jun 2020 11:01:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200619010122.GH17085@umbus.fritz.box>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200610042554.GD494336@umbus.fritz.box>
 <20200610233714.05174c93.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <20200610233714.05174c93.pasic@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 11:37:14PM +0200, Halil Pasic wrote:
> On Wed, 10 Jun 2020 14:25:54 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > > > I'm going to definitely have a good look at that. What I think spec=
ial
> > > > about s390 is that F_ACCESS_PLATFORM is hurting us because all IO n=
eeds
> > > > to go through ZONE_DMA (this is a problem of the implementation that
> > > > stemming form a limitation of the DMA API, upstream didn't let me
> > > > fix it).  =20
> > >=20
> > > My understanding is that power runs into similar issues, but I don't
> > > know much about power, so I might be entirely wrong :) =20
> >=20
> > Sort of, but not to the same extent, I think.
>=20
> I'm curious what are the ramifications of a misguided hotplug on POWER?
> Does using F_ACCESS_PLATFORM when it isn't required have any
> significant drawbacks, or are you fine to just go with the safe option?

I expect it will have some performance impact, though it shouldn't be
*that* bad, at least if your guest kernel is ddw / large IOMMU window
capable.

Changing the default would require a machine type version bump, of
course.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7sDmIACgkQbDjKyiDZ
s5LzphAAjmB4ZOjj8SQ9Mftxq18eNoUdaFrNO/AU0Xhict72ejnWHW7YzXuU1uGN
N2mt3e8b3Q7WUivkN2m3SHesxojS45Fv5T1m3weWEUwYemkM+zrLbelfCf8Li6TO
p0Nyjk1mhXcYJHI3NaOIekKCHtCPnoJqb4qKa5ENNwIoxWmvgcy6ZOW2/roXSX0T
yOTJWtr+W1V6rWUYykpr2f63eF6IA6vFulyDafNz2G+V3nI02UtNs2E9Y2Oe05Fe
WEMTLTKsreYNiX9HaNGeI2Fy2NHBsc7FKD7jmAihBsKhX9OgNHY77uO2mpclTrRX
6sfkVEAaj3r2mOh5Rm622zHzpeED9Co5xnB27RvXOJ9gLSS5sooh0zWnAHb6Y3WP
cRkhagt8J85QobkJcxiocOtJYbcK3WQJ6ouwXemlSezEECZeuMK1Uw36l763ick2
cMgNl7XBL2P31dVXIsf0pLF/ys8NEJix1IIOHv+5gA+8gQbbVg1OLEUIVMxvqQQS
09lW/V6d3+4lbxikn234CoIzBHV0EsQnJ7ViRGEWA6j7RUnSATsRuXvDKHE+Ytmp
1Pq/0Svup2EBfeHosAEOkinFOkG6eFThII1wo6nJr4FtO/MMfCC9aSjIq/5xGlqT
+8ACj2wSwKZ2uPJryJ0liW2gGTT02QDGUtRiSmBz1Wl+qonL+mU=
=CoWe
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--

