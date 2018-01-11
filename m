Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eZcG0-0005nN-I6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eZcFz-0001Ew-Ou
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:46:56 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
Date: Thu, 11 Jan 2018 13:46:38 +0100
MIME-Version: 1.0
In-Reply-To: <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MdrWBPrsY4VugZSdSSNI5gBH2lS6ZA33h"
Subject: Re: [Qemu-devel] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, rpalethorpe@suse.com, quintela@redhat.com, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MdrWBPrsY4VugZSdSSNI5gBH2lS6ZA33h
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, rpalethorpe@suse.com,
 quintela@redhat.com, Qemu-block <qemu-block@nongnu.org>
Message-ID: <5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add save-snapshot, load-snapshot and
 delete-snapshot to QAPI
References: <20180107122336.29333-1-richiejp@f-m.fm>
 <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
In-Reply-To: <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-08 14:52, Eric Blake wrote:
> On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
>> Add QAPI wrapper functions for the existing snapshot functionality. Th=
ese
>> functions behave the same way as the HMP savevm, loadvm and delvm
>> commands. This will allow applications, such as OpenQA, to programmati=
cally
>> revert the VM to a previous state with no dependence on HMP or qemu-im=
g.
>=20
> That's already possible; libvirt uses QMP's human-monitor-command to
> access these HMP commands programmatically.
>=20
> We've had discussions in the past about what it would take to have
> specific QMP commands for these operations; the biggest problem is that=

> these commands promote the use of internal snapshots, and there are
> enough performance and other issues with internal snapshots that we are=

> not yet ready to commit to a long-term interface for making their use
> easier.  At this point, our recommendation is to prefer external snapsh=
ots.

We already have QMP commands for internal snapshots, though.  Isn't the
biggest issue that savevm takes too much time to be a synchronous QMP
command?

Max


--MdrWBPrsY4VugZSdSSNI5gBH2lS6ZA33h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpXXK4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdMIIALDzSfTBtWvmTEMGNJGeqNX6WHH/7o/r
PW0lERPwdnIPjcDgyyN0BF84S1WNDfordzXOqA7uPwTwY7KNgBDaQhb3OMk//lD4
h6QVx56QRHQ99sSICYQLZUe6c0NbmDMWXwanLl6VqBTFuFxUT2WWbdnEjM2tP0YO
5fUdxC/LOvcbpS2SwTlNM3GmAPvM9yhTyQ/If2KAltwL2qDX1B+YiH1jXxT6mrPv
g67alAv9wZr1k2CPugm3VcGZ8DqdnA7+m/25peOvpga4axrsQTm23HmRsb/WTVSR
y602p8wwt5ViY+2ap9/j16ie0k1mn1S0QAMRACnWYU787CU/SRhnA2w=
=e0Nj
-----END PGP SIGNATURE-----

--MdrWBPrsY4VugZSdSSNI5gBH2lS6ZA33h--
