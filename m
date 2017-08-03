Received: from eggs.gnu.org ([2001:4830:134:3::10]:38285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddGFb-0001Uq-97
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddGFa-0007ff-Cd
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:33:19 -0400
Date: Thu, 3 Aug 2017 15:32:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803133258.GI4456@dhcp-200-186.str.redhat.com>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-8-el13635@mail.ntua.gr>
	<20170803080750.GB4456@dhcp-200-186.str.redhat.com>
	<20170803132455.bth53wkxr35imfhd@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <20170803132455.bth53wkxr35imfhd@postretch>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block: add throttle block filter
 driver interface tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.08.2017 um 15:24 hat Manos Pitsidianakis geschrieben:
> On Thu, Aug 03, 2017 at 10:07:50AM +0200, Kevin Wolf wrote:
> > Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
> > > Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> >=20
> > I would add at least two more cases:
> >=20
> > * Both limits and throttle-group are given in blockdev-add
> This exists in the "property changes in ThrottleGroup" section,

You're right, I missed this. The test result shows that this command
succeeds. Do we really want to allow other nodes to be affected with a
blockdev-add? Wouldn't it be cleaner to just forbid the combination of
limits and throtte-group?

> > * limits and throttle-group are both missing
> this creates an anonymous group with no limits. Should we fail at this ca=
se?

I'm not sure, you could argue either way. But there should be a test to
check that the semantics won't change.

If we're going with Stefan's suggestion that anonymous groups shouldn't
exist, then the question is moot anyway.

> > It would also be nice to test that query-block reflects the new throttle
> > group limits correctly when they are changed after the fact.
>=20
> This belongs to the remove legacy patch, since query-block displays the
> legacy limits.

Ok, fair enough.

Kevin

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZgyYKAAoJEH8JsnLIjy/WgmkQAKYsfjuL4YlopXaAasB6ajW1
MHjw3XE1bNEWQQlfYcU9zirXg3y0Y/EGat3gk6A0CVGMPV6vBjkdVsaTPCLGCDOS
rbR9P22bY08snF/x867lcUgGKivKsJp6eXFC2bCe+rPVurDTXt3/oG6XoTvJ3N0N
rgZ29hUHaIycuAhX92EratNPoGhPACYcRQHp+/sHHz9m5yD4x7RLlSV/UWcxOgwx
WT+MJj8K8dprgOdsMJtWUD111XSry+RDN/wI2xEQa1IMRt7nicTDuYIoGJelUfHl
6Bly4RwCzLSMbMBeoBoUp7RYwcwobTIHAz7GyJHhOdYOruirLmwsfxV/KEqwxliv
d0WYUZFz/C7Cfb4QxRGQu2B3xZbo0MSZy6KsUrf2iFKbp5iyMy/SlnFL2/oWzOAU
HyjOB9N0hVaIjO294G8zpcYE0pjPf8Ipe4efbNokGQiZTPqwJXSA99qMF3/VkboW
zLQ/2d2fkOOzJrDqH/xI7zSYtosR/gYhxpek3+ZhDaklZbaJ+coCstZRPfq2iusT
bPYKdAq9zLPl2LhCXnV/E2gywF4BNPu9TLzJmd71WiFhb4k2yYbTVa5NfxbD1kIf
YEs6AOXpBWLmhbWEqo/ypaMxnC6lGN+XkhFPHulIyvbUiEWaL60foCVoVoLVhSIc
8cZFJ7G7Wm3Kx80DPlPk
=prSW
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
