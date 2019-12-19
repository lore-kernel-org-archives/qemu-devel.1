Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6D02146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aazYsJr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6D02146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihoAs-0001FL-71
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 00:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iho9N-00008y-2p
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iho9L-0002vR-Vm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:15:01 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:46339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iho9L-0002k2-It; Thu, 19 Dec 2019 00:14:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47dg6n3QhHz9sPc; Thu, 19 Dec 2019 16:14:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576732497;
 bh=oFzpFz9kbAh9ftjRFcAXMzOLF1wdcKWmMQxb1S17Q14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aazYsJr/7CKYAAS/BvxQj2iNcBSPTQ7hONld9P5keh4MGzmFhMldwKg0SNM3b/TWH
 dppMQoihOrv6/ctis0oNZoKGB7IvqwdbCN2cHpYO0orwGGwvi5WKlzbnKegWNu+G3P
 mngp3SK7sDK7RXM7J13E2CiTUCuRF3hyIFCkRnF4=
Date: Thu, 19 Dec 2019 16:14:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 1/5] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
Message-ID: <20191219051444.GH2321@umbus.fritz.box>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-2-stefanb@linux.vnet.ibm.com>
 <20191213053453.GD207300@umbus.fritz.box>
 <75fd3e95-d72f-069b-22ce-f354e1c34660@linux.ibm.com>
 <20191217002954.GH6242@umbus.fritz.box>
 <1efef315-cb85-79ea-9c46-ff318e05a543@linux.ibm.com>
 <20191219015414.GC2321@umbus.fritz.box>
 <db0d3dbe-3b01-e62b-2cf0-3d0c50e3c4fb@linux.ibm.com>
 <20191219051357.GG2321@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Content-Disposition: inline
In-Reply-To: <20191219051357.GG2321@umbus.fritz.box>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 04:13:57PM +1100, David Gibson wrote:
> On Wed, Dec 18, 2019 at 08:59:18PM -0500, Stefan Berger wrote:
> > On 12/18/19 8:54 PM, David Gibson wrote:
> > > On Tue, Dec 17, 2019 at 02:44:04PM -0500, Stefan Berger wrote:
> > > > On 12/16/19 7:29 PM, David Gibson wrote:
> > > >=20
> > > >=20
> > > > > Since you need to change compatible based on an internal variable,
> > > > > we'd need to replace the static dt_compatible in the class with a
> > > > > callback.
> > > >=20
> > > > Why can we not initialize it once we know the version of TPM? From =
the
> > > > perspective of SLOF at least this seems to be building the device t=
ree fine
> > > > since it sees the proper value...
> > > Because it's a serious layering / isolation violation.  You're
> > > modifying QOM type information from the runtime code of a specific
> > > instance.  You get away with it (now) because there's only one
> > > instance and the ordering of things happens to let it work, but that's
> > > assuming way too much about QOM's implementation details.
> > >=20
> > > As a rule, once the QOM classes are set up with their class_init
> > > function, they should never be modified.
> >=20
> >=20
> > If we now add a get_dt_compatible() callback to the class that gets inv=
oked
> > when dt_compatible is NULL, does this then solve the issue?
>=20
> Yes, that's what I'm suggesting.

Well, almost.  Actually I'd suggest the other way around - call the
callback method, but if that's NULL, fallback to the static value.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl37B0MACgkQbDjKyiDZ
s5JVow//Wv2G2Nk0aJkR5w7LieY6qxJdXXKlSixTNWCLoivOf7Uw4HN0pGwhSYSz
MAGNbhQT4sTJR6zbY1KeQFTjwdheNO5w3U/vDxMoHHGYqr+ZzXHtJuuOHUZHqhex
lFLTgyM3SS9uua7/1eNi/PqRVJlSV2NaPydqFqf4j47n0MGDmVDLnRx9SxE806Bw
xgwbvcHvTaDd7N8FICNCyDtFB7ezO+vRdzibywdEa6wOzvSlstQ5+Hj+LbPY44Ag
D+XSm7a1o/3IRAtcSTEXvULkROd5p/MRmHAgNaTV8pp1WiGU7iSTreHvLPY/tbIj
WnB3aAjErGUaZ4eKNitRLRqiAttZrkGKIfHi9Rs1lrNinROMl5q9trnnWUr21Dma
MXMnin45OskY7ap9NX4rIeRdOSSnSVO8JFDUNKRV+UWroX0f/X2CgoCBRIqU2TG0
nbA2jQCggVg1/lhMYX9TITRmVg2KWX2t4TGHQh1sL5gaBRzSfFTsNniZ+qaVhWb+
72F0llNBJefddKt+UBk1TZNQ0fNJYNb4o1YZWknix70uDKQEmWagCO0AZmBmUob+
4oDlv+ejJJOGIKVT4wTI6t0nzhJgfy6okzxc5KMORV6pS7JCqu7cZWybesZiqeQn
/0Oy5I7/VyE9pqDF4R7eOe1n4XCz7OHRSk7w1nLlHeoGuXcPFzY=
=Y+SI
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--

