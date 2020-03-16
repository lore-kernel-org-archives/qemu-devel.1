Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E40C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 03:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFDC20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 03:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IcJzuZbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFDC20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDgGW-0002Vx-Ja
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 23:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDgAp-00011L-32
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 23:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDgAm-0007NR-MW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 23:12:14 -0400
Received: from ozlabs.org ([203.11.71.1]:34995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDgAm-0007BP-85; Sun, 15 Mar 2020 23:12:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48ghDS5ph4z9sP7; Mon, 16 Mar 2020 14:12:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584328328;
 bh=rWp0kCwF/mgRUOryiJHj0URSWLD+4CW9MiMnqlu1W/M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IcJzuZbQGDu+xHnj177JQXN+YCrttZOahUSfAOUrLo4Ii8rt7gtAEQQEL58Rr3Pgt
 aV7Whp5prgeX347XieICvB91GLDFhfRggla6t09IQLnncpsH96FBJ2KAAq6w4LHs2l
 B43PjAFLwlh4OnWvtM8+wrHSoTEgEhEoysvMi7gQ=
Date: Mon, 16 Mar 2020 14:06:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200316030646.GH2013@umbus.fritz.box>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
 <20200311011247.GT660117@umbus.fritz.box>
 <20200311031202-mutt-send-email-mst@kernel.org>
 <20200312011049.GC711223@umbus.fritz.box>
 <20200312023041-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Content-Disposition: inline
In-Reply-To: <20200312023041-mutt-send-email-mst@kernel.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: pair@us.ibm.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, aik@ozlabs.ru,
 groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 02:32:11AM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 12:10:49PM +1100, David Gibson wrote:
> > On Wed, Mar 11, 2020 at 03:33:59AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Mar 11, 2020 at 12:12:47PM +1100, David Gibson wrote:
> > > > I am wondering if we have to introduce an "svm=3Don" flag anyway.  =
It's
> > > > pretty ugly, since all it would be doing is changing defaults here =
and
> > > > there for compatibilty with a possible future SVM transition, but
> > > > maybe it's the best we can do :/.
> > >=20
> > > Frankly I'm surprised there's no way for the hypervisor to block VM
> > > transition to secure mode. To me an inability to disable DRM looks li=
ke
> > > a security problem.
> >=20
> > Uh.. I don't immediately see how it's a security problem, though I'm
> > certainly convinced it's a problem in other ways.
>=20
> Well for one it breaks introspection, allowing guests to hide
> malicious code from hypervisors.

Hm, ok.  Is that much used in practice?

(Aside: I don't think I'd call that "introspection" since it's one
thing examining another, not something examining itself).

>=20
> > > Does not the ultravisor somehow allow
> > > enabling/disabling this functionality from the hypervisor?
> >=20
> > Not at present, but as mentioned on the other thread, Paul and I came
> > up with a tentative plan to change that.
> >=20
> > > It would be
> > > even better if the hypervisor could block the guest from poking at the
> > > ultravisor completely but I guess that would be too much to hope for.
> >=20
> > Yeah, probably :/.
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5u7UUACgkQbDjKyiDZ
s5K4lhAAsH+/+1eM/obXI6wAXaRv9WUWALHMVNzFxhHcBHdVZmgKObIS9Xduvsmn
UypNqeaAehJZsyaI8bjUMCG0cHgEljpOpPx4Rujm9CwXBxiiJW6LbqoWjsxJLbX6
OHdfa+cWZ9fM6t/GHPoxC7OFA/UGxqzRC4zy2ScrjN4ncTLS5Uo7JRAhwfyej2S7
d+oYhMbEUkAdKUXAT/a6l+Se2/5L3N5icT3c0VR5BWMj9Dx0pb598WlWt24GAS6I
vOS1Y/i36xbWUsfLeNyWlAuBRUfjH12Hp/yVujCI3P4Wm1JodakdVhAkJKYvM8Bu
Txsun3QW/bH2R9HX8HDmzbKKuI85YYA84RiyUg9Y/S9nqTF3tQaMIkW1DxuOgI9j
9eR7xbaagJ8oMMJEkyaOdLNLPfX7LF1qx6ahYKi0O3kWe1hzFXrv1gIyhEHhpI60
UB+2DXD26tekTDxs6sv3jVz3tPyIhvDRNC5WP44sSDnvfVj6Lb87tgcZoKYuix3V
8LLuFjiBd8AvCcZVnjVdBTjtZgdbFl/qzBHXsvhmAbYTttLGNYt48yO6NIgq+ere
O4pduUuHXjqR/OtS3uyd3AD3wdKh2kz5uRClqNW+96h9GL+Yl6giBG9IO33RvhkF
mJxMzFKVGq/PesB77FAxOL9JJrmnfkO+rYSoD+Osi34lw6gO0Vo=
=Nalz
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--

