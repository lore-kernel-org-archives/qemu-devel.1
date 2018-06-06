Received: from eggs.gnu.org ([2001:4830:134:3::10]:34076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZzA-0003HT-Ri
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZzA-0002JN-25
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:04:28 -0400
References: <20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606174412-mutt-send-email-mst@kernel.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4d65e825-5018-a29e-e883-1370ca5461b3@redhat.com>
Date: Wed, 6 Jun 2018 17:04:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180606174412-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qQHWWHeZiy0gRtMiFVIvz7N4vYTOfOEmu"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qQHWWHeZiy0gRtMiFVIvz7N4vYTOfOEmu
From: Max Reitz <mreitz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <4d65e825-5018-a29e-e883-1370ca5461b3@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180528212054.GH2209@redhat.com>
 <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606113720.GA2661@work-vm>
 <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
 <20180606174412-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180606174412-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 16:46, Michael S. Tsirkin wrote:
> On Wed, Jun 06, 2018 at 01:44:02PM +0200, Max Reitz wrote:
>> Because it's a hack, right.  Storing binary data in a qcow2 file,
>> completely ignoring it in qemu (and being completely unusable to any
>> potential other users of the qcow2 format[1]) and only interpreting it=

>> somewhere up the stack is a hack.
>=20
> It's just a first step and it ensures compatibility with old QEMU
> versions. But down the road I think we will start warning
> user if the machine type does not match, and possibly even
> get the type from there if user didn't supply it.

If it's a first step we should have an idea on what the following steps
should be.

I don't want people to convince me that adding a blob to qcow2 is a good
idea because "we are only going to store two or three values!" and then
that blob grows out of control because "well, now we have it anyway".

Max


--qQHWWHeZiy0gRtMiFVIvz7N4vYTOfOEmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX9/EACgkQ9AfbAGHV
z0AVHAf/d+adyo92rmY74lrrkcYaDWI48ScT4xyDTlS0KGONrY2cJBwEDS80zqKj
KglMffzdbrvzAtgElnnZK8+5khAp1oEn4UU3HLPsjKfpUjAEXI67ndRw2zDoqZ+1
4VtFCyEgMGXp6B3u2F98ucL7FgzAPVRbx0grgy/vru18QUsocjtbglNfPXn4/6e0
Orh3C+8bTuc6V/WrmRUi3VLbfqI3tu3f+ZhHlriAfVokl7xZms7+/afiHTc3cbpC
j8oyMgYXKNqe+uqnm+cZK00mIs6wtQL5kEa+/x0S9OEstwV6dQ2ji7gxnDZI4fAC
j9l95FAPy3wirKadmanuX4Exj26F8A==
=iMEx
-----END PGP SIGNATURE-----

--qQHWWHeZiy0gRtMiFVIvz7N4vYTOfOEmu--
