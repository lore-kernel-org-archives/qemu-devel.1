Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813CC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 05:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B73222C2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 05:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GqfEG2Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B73222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFtX7-0001p0-2G
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 01:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFtWN-0001Oq-Sv
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 01:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFtWM-0000s3-6Q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 01:19:23 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34651 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFtWK-0000pZ-TC; Thu, 03 Oct 2019 01:19:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kLs91wR3z9sDB; Thu,  3 Oct 2019 15:19:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570079949;
 bh=lzcfRtjfty8DllnKvmevovUWJI98eP0X245HAozNe1o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GqfEG2TiKFsqlxMWtvqWNm/EN6Db1heX72dnZe1Or3vvIgqaK5EZQpB9964642yBB
 +nfyE9FkcjYHW+NDIUe1lvDcD0mHBCwp7Jcyy7hMvkYHo7nzbnf4CPOxD5KOC6mS3G
 vfZjlDXI+Gt4tEXO8zTuG0ot1jb+PlfHypRbyyfw=
Date: Thu, 3 Oct 2019 15:19:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 34/34] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191003051907.GR11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-35-david@gibson.dropbear.id.au>
 <20191002122035.6f667938@bahia.lan>
 <20191002223111.GB11105@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cNrVs/mD1E3KQVoV"
Content-Disposition: inline
In-Reply-To: <20191002223111.GB11105@umbus.fritz.box>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cNrVs/mD1E3KQVoV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2019 at 08:31:11AM +1000, David Gibson wrote:
> On Wed, Oct 02, 2019 at 12:20:35PM +0200, Greg Kurz wrote:
> > On Wed,  2 Oct 2019 12:52:08 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > The only thing remaining in this structure are the flags to allow eit=
her
> > > XICS or XIVE to be present.  These actually make more sense as spapr
> > > capabilities - that way they can take advantage of the existing
> > > infrastructure to sanity check capability states across migration and=
 so
> > > forth.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> >=20
> > This needs some more care. Incoming migration of older existing machine
> > types breaks:
> >=20
> > qemu-system-ppc64: cap-xics higher level (1) in incoming stream than on=
 destination (0)
> > qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'spapr'
> > qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> Ah, right, thanks for testing that.  What machine type exactly was
> broken?

Never mind, found it.  And in fact it was broken with the lastest
machine type and ic-mode=3Dxics as well.  Turns out I wrote the
vmstatedescription for the new caps, but didn't wire them up.

It's a real pain the number of places that need to be adjusted to get
a new cap properly working, unfortunately, I've not come up with a
good way to avoid it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cNrVs/mD1E3KQVoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VhMgACgkQbDjKyiDZ
s5Lt7xAAq8/EzCZI6dwapiaO2NN5IxOFK+rfWDIl1ePZXtHuHCjwwqYDS6vf7FQD
m86G3BxW3380M6Z9z0o3MTJH+R5vm6UE7vkI/J9vtaBpPn1eo9uLZe91O4QkRXGa
ZWQTt694mULl/B794SulbbVlvUwOqOo4Pw9aYWd4oXeTEDEZXvXU38dhqQdi/wRl
OkANDsWeSHgY4lh5GLQSGViLtNkRl99qThuKLb/Y+YAZNoMNk9FvYw1DreoAuT/k
f8GDyKswFNO3+8oIKqzNAPbtiKctX52aRnkQ4NCV3sqIClJ9hv0FluLRlt/dxUj4
C6z8Tth7RXule/1yXbBfEoFeq74F1Qhp5GepSEuGX5K2pQLqNc2YaAYHohu8ORzb
vjWOrptF7MRbc6xMU5Payt7E8fpew2cNckdAF3K1Bc2pI2vYp3TjfV/fWHsONGNc
3lYu6C3OUA/ynHM4dDvAyzDM4oX05OPn/AsqONCrmnBpXOryGryNLwejsh2rOLw5
dakSx6h7zlucGb1ugBtu+tpX6Y2GZU6j7p42XZN4w5H6WjbGbHO4OXsqKVqWx8MQ
uXigvd4P3+eSsR5aemxDkNGi5M8O5UaooF1+1YVW2prI+617azBkEevJsrHbhU6o
vC/oPMMjSGUmHSkeTTgI19N1sKdR8ftjdx/OHCBYXi5zqmPpfB0=
=FxYq
-----END PGP SIGNATURE-----

--cNrVs/mD1E3KQVoV--

