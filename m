Received: from eggs.gnu.org ([2001:4830:134:3::10]:35244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZerz-0004Ub-Jk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZerz-0000Hu-09
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:34:19 -0500
Date: Thu, 11 Jan 2018 15:33:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180111153346.GC7353@stefanha-x1.localdomain>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
	<1513595351-5899-2-git-send-email-den@openvz.org>
	<20180104113435.GD10106@stefanha-x1.localdomain>
	<34dc4551-7aaf-ce61-2385-2c6ab7780cdd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <34dc4551-7aaf-ce61-2385-2c6ab7780cdd@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] docs/interop/prl-xml: description of
 Parallels Disk format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: klim <klim.kireev@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2018 at 07:23:29PM +0300, klim wrote:
> On 01/04/2018 02:34 PM, Stefan Hajnoczi wrote:
> > On Mon, Dec 18, 2017 at 02:09:07PM +0300, Denis V. Lunev wrote:
> > > +    * GUID - image identifier, UUID in curly brackets.
> > > +             For instance, {12345678-9abc-def1-2345-6789abcdef12}.
> > How is the GUID used?  Does it need to be validated against the GUID in
> > the image file?
> Parallels images don't contain GUID, what do you mean?

At this point in the spec nothing has used the GUID yet, so I was
wondering what purpose it serves.  After reading the Snapshots section
below I saw that the GUID is used there.

It would be nice to include something like "The GUID is used by the
Snapshots section to reference images (see below)" so that the reader
knows why this field is needed.

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaV4PaAAoJEJykq7OBq3PImcsIAMkZljRAJWQr5Fwm9U4F9ucp
H8R1ufEyLY61TUYegiZ1qrrxHnScnACkZaf5zR/MF/WKdRQvYuoQnPUFBoho1cy2
qtd3VOpjIMafm6DZuuABRiZA84iB8KFwsZl+OjFXQGAmrLY7iNuYRQl5oHQHvtLC
3XF2OA1hpmv7tH6i8FIz2bf5sPcetwNgDx8G2hGZvSG4kETc1f1qEofSEbtgE8dp
25qyudv9rIyFsVf0TIMhqicmZBGD2XDAv7rpd8YNGp95T2mNjR7HTrbdJcmC3eg0
QSM7Sj+2GSEOMKutkxWmuQAa5CnoerdLPGrSyxXuIybhYZzwiSxRPKyBNLH5at0=
=FPG6
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
