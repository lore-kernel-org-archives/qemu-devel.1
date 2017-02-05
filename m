Received: from eggs.gnu.org ([2001:4830:134:3::10]:54942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUW5-0002Yt-Nm
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUW5-0003tL-4e
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:38:37 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-2-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4c519938-54dc-fd74-0f07-ccdd428e6876@redhat.com>
Date: Sun, 5 Feb 2017 22:38:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="adl3rEa162HLW4qEIpiXEJ1wX5TH9Q7IE"
Subject: Re: [Qemu-devel] [PATCH v12 01/16] osdep: Add qemu_lock_fd and
 qemu_unlock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--adl3rEa162HLW4qEIpiXEJ1wX5TH9Q7IE
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <4c519938-54dc-fd74-0f07-ccdd428e6876@redhat.com>
Subject: Re: [PATCH v12 01/16] osdep: Add qemu_lock_fd and qemu_unlock_fd
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-2-famz@redhat.com>
In-Reply-To: <20170123123056.30383-2-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> They are wrappers of POSIX fcntl "file private locking", with a
> convenient "try lock" wrapper implemented with F_OFD_GETLK.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/qemu/osdep.h |  3 +++
>  util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++=
++++
>  2 files changed, 51 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--adl3rEa162HLW4qEIpiXEJ1wX5TH9Q7IE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliXm1MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxaIH/1AxhI4KJFOqTq1nx8yk+AqTfWQMlx76
AAvmKtX+bHkNzmtgbStYAtmsL1w2O/zBxa0p7jHrLBkYDdZlmiH+oikkuHLNFhKG
Wtf+ng3jtxKJThLmQI6fQ+lhiEW8xuDld9twbzHej6KWAaMw2QnkqTOIH93R467g
jiilolRNLn7G7jGLxthiWW59VFamcBXAi3+mJCeeotKCGyWeY0XcndPHfSnTCwfE
98lF24bblDBlJE57sWLaoVglUdcuNhFmzDg2Wn04TzlbPqv8I7rCRpPxeGhGcFdJ
lLAFpu/6bh8gAz5cCZ4V61wrMq5FJArZjgUVG3na+x6BNjgms91gVFI=
=QBuq
-----END PGP SIGNATURE-----

--adl3rEa162HLW4qEIpiXEJ1wX5TH9Q7IE--
