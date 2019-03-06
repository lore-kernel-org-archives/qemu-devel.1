Received: from eggs.gnu.org ([209.51.188.92]:53150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1Y81-0000Li-RI
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1Y80-0006GY-JV
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:06:41 -0500
Date: Wed, 6 Mar 2019 16:06:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306150633.GK6818@localhost.localdomain>
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-4-kwolf@redhat.com>
	<20190301161724.GB18260@stefanha-x1.localdomain>
	<d6ba8e66-5ddf-9091-ff44-5024a53240a8@redhat.com>
	<20190306095147.GF22159@stefanha-x1.localdomain>
	<ec417842-c9f4-7a7e-e49f-4d509115e540@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <ec417842-c9f4-7a7e-e49f-4d509115e540@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/20] qcow2: Extend spec for
 external data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.03.2019 um 13:43 hat Eric Blake geschrieben:
> On 3/6/19 3:51 AM, Stefan Hajnoczi wrote:
> > On Fri, Mar 01, 2019 at 10:32:27AM -0600, Eric Blake wrote:
> >> On 3/1/19 10:17 AM, Stefan Hajnoczi wrote:
> >>> On Wed, Feb 27, 2019 at 06:22:39PM +0100, Kevin Wolf wrote:
> >>>> @@ -148,6 +170,7 @@ be stored. Each extension has a structure like t=
he following:
> >>>>                          0x6803f857 - Feature name table
> >>>>                          0x23852875 - Bitmaps extension
> >>>>                          0x0537be77 - Full disk encryption header po=
inter
> >>>> +                        0x44415441 - External data file name
> >>>
> >>> This new header extension isn't described in this patch?
> >>
> >> I asked the same on v1, and the answer (which remains valid) is that
> >> neither is 0xe2792aca Backing file format name.  (In other words, both
> >> extensions are simple enough as a single file name to be implicitly
> >> described by the reference to the header in the earlier text).  Making
> >> both explicit wouldn't hurt my feelings, but I don't see it as a
> >> showstopper to the patch as-is.
> >=20
> > The spec should make the representation clear.  Is it a NUL-terminated
> > string or is the length dictated by the header extension length field?
>=20
> My understanding is length determined by the header field, with optional
> NUL padding out to the alignment boundary (but that also means that it
> does NOT necessarily have a trailing NUL on disk if sizing matches
> alignment).  But yes, being explicit never hurts.
>=20
> >=20
> > Otherwise implementors are forced to look at the QEMU source code or
> > guess based on hex dumping example files :(.
>=20
> Indeed, cleaning up the existing Backing file format name is worth doing
> (at which point this should follow suit). But it still sounds like a
> separate patch, at which point it becomes a question of ordering - if
> the cleanup lands first, then this needs to rebase to do the same; if
> this lands first, then the cleanup does both headers at once.

Maybe add a new section "String header extensions" that covers both?

If this remains the only patch in the series that would need a
significant change, I'd prefer a follow-up patch indeed.

Kevin

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcf+H5AAoJEH8JsnLIjy/WlFYP/3ew6aVbcE6LlJGsoCV9kTfg
8tP2ryxrwwSeCWDrEvRKIlzVtmlm/p7JLEmy6g6M8ic/NndmgBRYJbd/MKKyL+JV
TcpoFGv10CtIyfX9pDoJ1Ki85OqgtlYe64OzbL+J7k/+AR1Nyva0486kJlDswawk
wvLvtJeZoPZV4+SXFJD1mW9g5gP7j/6lkmSkdTMKEAY6XetByxBffbCR5QkN32IF
X8aU83DLH0gC0VqgRkuo8VcPBkc6tu0I7IAxje0OxywV7IeD5H4UJf5irSKp2xnk
37+J98AgSV3ZglpPVlizD/W2CgnEPAd4O7aglw2yHPuAQHH++nY7nBzpoT2AHhTh
MVYGTA2h7cfHxKCXJzSkyfxnzcnjhDKpPJrcPWNI+YuI+Y0UB5ml8L3bQJZ2gK8w
4RhA30ZLwJ6gy9mq7NfF7LxwWlhQKuxKuMSiSfys7si2MSMgv34U9ez2+ozL+dYu
kHQWTBclSZc5WM9DA0tVmxaUwR16FaLunqSgJfG8q5ZoUb/s5UCB9u8aR85Zk58y
bhRJOXUYXiomgXUzqlNTMHlhUzPg4CSTrQe5hLxQoIa3DBtArtrscK7nT8wDwavD
jWR+d45QJfb53nwojymxdePxp95xL/Lc+a+60fiF/skzZqfdhlh+lrlXH/huKlh1
dCi0HZUHXiwWbr3OUV8C
=RnZq
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
