Received: from eggs.gnu.org ([2001:4830:134:3::10]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYXAJ-000582-ON
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYXAI-0006nI-RP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:36:19 -0400
References: <20170721102059.14663-1-famz@redhat.com>
	<20170721102059.14663-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <723efea0-9256-0710-3d6c-8d8868b32550@redhat.com>
Date: Fri, 21 Jul 2017 07:36:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170721102059.14663-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xwPVPCxWrtxrrv4mWsQ1CLQjJJ2Go1Kjt"
Subject: Re: [Qemu-devel] [PATCH 2/2] file-posix: Do runtime check for ofd
 lock API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xwPVPCxWrtxrrv4mWsQ1CLQjJJ2Go1Kjt
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com,
 Max Reitz <mreitz@redhat.com>
Message-ID: <723efea0-9256-0710-3d6c-8d8868b32550@redhat.com>
Subject: Re: [PATCH 2/2] file-posix: Do runtime check for ofd lock API
References: <20170721102059.14663-1-famz@redhat.com>
 <20170721102059.14663-3-famz@redhat.com>
In-Reply-To: <20170721102059.14663-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 05:20 AM, Fam Zheng wrote:
> It is reported that on Windows Subsystem for Linux, ofd operations fail=

> with -EINVAL. In other words, QEMU binary built with system headers tha=
t
> exports F_OFD_SETLK doesn't necessarily run in an environment that
> actually supports it:
>=20
> $ qemu-system-aarch64 ... -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0 \
>     -device virtio-blk-pci,drive=3Dhd0
> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed=
 to unlock byte 100
> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed=
 to unlock byte 100
> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed=
 to lock byte 100
>=20
> Let's do a runtime check to cope with that.

You may want to mention that the same is possible on a system with old
kernel but new glibc (ie. this issue is not necessarily specific to WSL).=


>=20
> Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xwPVPCxWrtxrrv4mWsQ1CLQjJJ2Go1Kjt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx9TcACgkQp6FrSiUn
Q2oMYQf/TPgnsERjck+amyDZ4IUBKDnCFP7r1i/Q0+HU0RAVJ83U9hZiYZUSrKYj
89NWmQxlTJkdmI/S6k1cRrw4j2iA0xsxZTBg4WLuXqEC56Vu1VUv+ogRKxbprm54
5fd+8uVK1DN4hx6/6upSDZJ6pxAGFqiRCNMPG6RuBTW9iAMa2NJ1HOIvW+225pPP
qiWmqqdhQ3oBH4X5MFRNS4Gsew97yZqV6gzkvSZoIymExOAjLmlekUA+BiSlmGr8
VNtucgX8g8BYXbBbhYqU3/xf/Tw0wp3I1RDTyCTqOAdIbqEvZE2z8uQGj2X/pi/4
tcoR3yO+6Bq10eyv36rgmV3JBe2RxA==
=nuNg
-----END PGP SIGNATURE-----

--xwPVPCxWrtxrrv4mWsQ1CLQjJJ2Go1Kjt--
