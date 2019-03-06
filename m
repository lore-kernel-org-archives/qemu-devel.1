Received: from eggs.gnu.org ([209.51.188.92]:46871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1TDL-0004Qs-Ss
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1TDL-0000Oy-3J
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:51:51 -0500
Date: Wed, 6 Mar 2019 09:51:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190306095147.GF22159@stefanha-x1.localdomain>
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-4-kwolf@redhat.com>
	<20190301161724.GB18260@stefanha-x1.localdomain>
	<d6ba8e66-5ddf-9091-ff44-5024a53240a8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <d6ba8e66-5ddf-9091-ff44-5024a53240a8@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 10:32:27AM -0600, Eric Blake wrote:
> On 3/1/19 10:17 AM, Stefan Hajnoczi wrote:
> > On Wed, Feb 27, 2019 at 06:22:39PM +0100, Kevin Wolf wrote:
> >> @@ -148,6 +170,7 @@ be stored. Each extension has a structure like the=
 following:
> >>                          0x6803f857 - Feature name table
> >>                          0x23852875 - Bitmaps extension
> >>                          0x0537be77 - Full disk encryption header poin=
ter
> >> +                        0x44415441 - External data file name
> >=20
> > This new header extension isn't described in this patch?
>=20
> I asked the same on v1, and the answer (which remains valid) is that
> neither is 0xe2792aca Backing file format name.  (In other words, both
> extensions are simple enough as a single file name to be implicitly
> described by the reference to the header in the earlier text).  Making
> both explicit wouldn't hurt my feelings, but I don't see it as a
> showstopper to the patch as-is.

The spec should make the representation clear.  Is it a NUL-terminated
string or is the length dictated by the header extension length field?

Otherwise implementors are forced to look at the QEMU source code or
guess based on hex dumping example files :(.

Stefan

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf5gzAAoJEJykq7OBq3PIF2oIAMbL6VbPd7Qj1x+SUxoos6rK
NdfJSkxLalmfmSFOPznROvtkeM5NvwzjSPhcaoT/fcd2W5dufJvz+IL2dV2W5UWR
bpKuqnzcYDN4hw5b8DIHVSN4pYo+2u4PcCCc2xpjdPNqbqLElrgyYJhfW0Od/Jnv
WmtYk/alKSW9kN+KgRcSREdjspHIiUNMqX7dIirGv0qtqCy/oAGpbmThnAWArhJB
WowkSxV+rkUkXEfOdCI2kI2zt2zpgPDkwhzEIlicqcx1bY7mEdiufbrVHCUFSqSf
oY5EZGF7JHHKl0udHALkIPHSuT24gwJ5qDTi7nR3xgEku7GDIeKWASZJWsOHUwM=
=0rQq
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
