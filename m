Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89618C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFBF206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFBF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs3Wb-0007YC-JC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 07:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hs3WB-000744-L6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hs3WA-0006qR-7W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hs3W7-0006lZ-L4; Mon, 29 Jul 2019 07:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41AB130BC58B;
 Mon, 29 Jul 2019 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-188.ams2.redhat.com
 [10.36.116.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B8335D6A0;
 Mon, 29 Jul 2019 11:08:31 +0000 (UTC)
Date: Mon, 29 Jul 2019 13:08:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190729110830.GA5757@localhost.localdomain>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
 <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 29 Jul 2019 11:08:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com, mreitz@redhat.com,
 Pino Toscano <ptoscano@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.07.2019 um 16:24 hat Eric Blake geschrieben:
> On 7/26/19 9:09 AM, Pino Toscano wrote:
> > Add a 'private-key' option which represents the path of a private key
> > to use for authentication, and 'private-key-secret' as the name of an
> > object with its passphrase.
> >=20
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>=20
> > +++ b/qapi/block-core.json
> > @@ -3226,6 +3226,11 @@
> >  # @password-secret:     ID of a QCryptoSecret object providing a passw=
ord
> >  #                       for authentication (since 4.2)
> >  #
> > +# @private-key:         path to the private key (since 4.2)
> > +#
> > +# @private-key-secret:  ID of a QCryptoSecret object providing the pas=
sphrase
> > +#                       for 'private-key' (since 4.2)
>=20
> Is password-secret intended to be mutually-exclusive with
> private-key/private-key-secret?  If so, this should probably utilize an
> enum for a discriminator
> { 'enum': 'SshAuth', 'data': ['ssh-agent', 'password', 'private'key'] }
>=20
> then update BlockdevOptionsSsh to be a union type with an optional
> discriminator (defaulting to ssh-agent) for back-compat, where
> 'auth':'ssh-agent' needs no further fields, 'auth':'password' adds in a
> 'secret' field for use as password, or where 'auth':'private-key' adds
> in both 'key-file' and 'secret' for use as the two pieces needed for
> private key use.

Can we actually support optional discriminators when we don't have
defaults in the QAPI schema yet?

> On a different topic, how much of this work overlaps with the nbdkit ssh
> plugin? Should we be duplicating efforts with both projects supporting
> ssh natively, or is it worth considering getting qemu out of the ssh
> business and instead connecting to an nbd device provided by nbdkit
> connecting to ssh?

ssh behaves essentially like a filesystem whereas NBD behaves like a
block device. This is especially relevant for everything related to the
file size. As far as I know, using an image format like qcow2 that wants
to grow the image file isn't possible over NBD, whereas I expect it to
work with the ssh block driver.

Kevin

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdPtOuAAoJEH8JsnLIjy/WOMgP/icCe8H8AWwFowMIVW7Tt6B3
LBjOCda24mJBYosQr5I5afyfrfxotBoo2r7wgCU/zighPJEUpRHmV7qaQcj9L+4H
45BCSDsPY5u3cfcG9nUeIybMkVak1zdWnLjjoCUyu9NKw/Ishqki6k7iVcq/X2Cm
Z+fMlkvSvts9q9snGta3UpIcw4y5kcm3iN1H2DmaVWPXnafrXGw6REfKl1I+VyKM
jCsBTAg/iAtB2WVDW/UIhbOam6YdWjt1Mco9QOcT3JWksRSYsFb56XHmO8uqrA7N
zRjzCEUpoX0PqcUzAJfk4sVDWyk50AY5BzOdspoo3oXPJ6c7qxXLy7Oxb177CmQP
bouTy52GkF6Bn5ID7HWrzv0AJfgmkuNwj6elRGAbOkEk8qc5dGZ/HgdXKsgeH8hb
9JA5WljHooDMUshx2wgopbDOujHKxP8w+0RI6wRFGYyWvdyWKuwB89xtmtnWMFyP
C9UMC2lFvPi217+fAkNGILseOaGR2sTN/H2WOSBW1oKPTh6Bk6c7sEmPXv707JFF
0tSMAUaA5z6qCaImqmP1CHjpdhY2jIBJSdHruAwc/qnyAPFHToIlQ6ukuX5jAl0w
pO5Xj/HN86aCbdCvT57E2QkmxB/qtQYcYVFmk39pyUaVAFlLKg6WiQX+td1XRkVm
CVD8nG4nxt4ilHesYcwp
=zyut
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

