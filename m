Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7971C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 03:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2CA20856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 03:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ILqb8Sbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2CA20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAR5l-0004Ft-CJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 23:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAR4C-0003HO-St
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 23:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAR4B-0001yJ-CC
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 23:55:44 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53715)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iAR49-0001ua-TZ; Tue, 17 Sep 2019 23:55:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Y5jc2FHvz9sNf; Wed, 18 Sep 2019 13:55:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568778932;
 bh=MR0TN8nYgOoLtwVJWvO5G3hJ9rE0cPiPIEHANYjYN88=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ILqb8Sbb1qt9K4RXCxv56OFipaI/myM7pFtgzs4X+Q4eOjj9z7kxmK2iIhkpjZEHM
 enT9Fjn/ZcqJ2ul7OF/vouJvmqyHnFrY3cNJCEB0ZfSdLkZkrelggUg9zNB5scx519
 Fg2Z+hw8lpvMZLMQmIPQa+ATfrASyZ/6JNqhAf7E=
Date: Wed, 18 Sep 2019 10:46:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190918004642.GC2440@umbus.fritz.box>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
 <20190916093445.20507-4-bala24@linux.ibm.com>
 <20190916144709.GD2884@work-vm>
 <20190917084537.GA30607@dhcp-9-120-237-81.in.ibm.com>
 <20190917094425.GD3370@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <20190917094425.GD3370@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/acceptance/migration: test to
 migrate will all machine types
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
Cc: ehabkost@redhat.com, groug@kaod.org, qemu-devel@nongnu.org,
 sathnaga@linux.vnet.ibm.com, clg@kaod.org, crosa@redhat.com,
 qemu-ppc@nongnu.org, Balamuruhan S <bala24@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 10:44:25AM +0100, Dr. David Alan Gilbert wrote:
> * Balamuruhan S (bala24@linux.ibm.com) wrote:
> > On Mon, Sep 16, 2019 at 03:50:06PM +0100, Dr. David Alan Gilbert wrote:
> > > * Balamuruhan S (bala24@linux.ibm.com) wrote:
> > > > add migration test to query machine types supported by qemu binary
> > > > and migrate vm will all supported type.
> > > >=20
> > > > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > >=20
> > > Depending on the architecture you might find that some machine types
> > > aren't migratable while some are.
> >=20
> > Thanks Dave, is there a way to query/check whether a machine type on the
> > architecture is migratable or should we try migrating and handle except=
ion
> > on failure ?
>=20
> I don't know a way to detect it; you can add -only-migratable to get
> qemu to fai early if a device is declared as being non-migratable; but
> that still doesn't say that all the devices have actually been tested
> migrating.

At present we kind of have an informal distinction between those
machine types that are mature and maintained enough to support
migration (which I think is just pc, q35, pseries and arm virt) and
those which aren't.

There isn't, as far as I know, a way to detect this.

I know we've mentioned at least briefly the idea of formalizing this
distinction at qemu summit, but I don't think the discussion went
anywhere.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2BfnEACgkQbDjKyiDZ
s5J2Vw//WijngvwtoL4/jDC9LjmDRKBCS4k48c1qJg6D4hdixG7P03d82uka/9ne
vINnzFN2uXwnlGuUvRV65+tbWHDyUJ6rf0FIKuO+H/EHgcJlcRF6mkd2Ko3Qk6z1
IXoQ+evfZOuNTDxFYbiAM0BBBoAFjRZ/cFE2dhHf57iLPGsLGl5G1ErnBOexden0
YzuywgoyscPjKmLL54++AF/BBYAHCvxNhXVVozLOLFlPhqd4m5GUxp4swBGdi2K4
03oAKvo7dhQKyWygPvEI6Li7GBknEvwP4cnVe2odT3f/uYmi4mgtFRAx5ssVnS96
wWNQ7kCgrqJE2zLl2+9v+ZLUuEDUJ9b8Rcl/dfRwscYyoCp0RbfJFuJZdu/BSX2T
Db29HbHY6Q38HbxsF9N+xaCrUzn69QUtkLS99j2EjC1a/z9RQA23HSG3fkDsvhj2
C1rOEhE9rZlLo/raOSQRd12TyI4Yowh/abC65XqP/bf0KcDaC6fYi2Ul8SZS9kXN
cURahBhVL+ukqb/UvJmL5gwJEnB/QdfIHsk9SO6gAvkUzYet4u0532SfhugZdErD
V+hafBD6sgMi89jUe6sLKWkjKwk4zjQjWAkHeq9zrq3KJdh7JYtE7QCuG2J0IYGG
4sb2Lp6MyrLOzJlLb0qzdq4XkuX3hJULqDiPZdJpd2lza4B53W4=
=FQ6T
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--

