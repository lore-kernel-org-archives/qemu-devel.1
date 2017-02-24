Received: from eggs.gnu.org ([2001:4830:134:3::10]:60516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJbJ-0000Mh-AV
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJbG-0004MG-JX
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:24:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chJbG-0004LX-BJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:24:10 -0500
References: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce3cc3a0-1bde-fa6b-9b1d-517f8eb8a4d1@redhat.com>
Date: Fri, 24 Feb 2017 11:24:07 -0600
MIME-Version: 1.0
In-Reply-To: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6WOqjXN2uBoFao47C1LpB7dXRFPHlhxc5"
Subject: Re: [Qemu-devel] [PATCH V9 0/2] Add new qmp commands to suppurt Xen
 COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6WOqjXN2uBoFao47C1LpB7dXRFPHlhxc5
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>
Message-ID: <ce3cc3a0-1bde-fa6b-9b1d-517f8eb8a4d1@redhat.com>
Subject: Re: [PATCH V9 0/2] Add new qmp commands to suppurt Xen COLO
References: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 01:22 AM, Zhang Chen wrote:
> Xen COLO depend on qemu COLO replication function.
> So, We need new qmp commands for Xen to use qemu replication.
>=20
> Corresponding libxl patches already in xen.git.
> Commit ID:
>=20
> ed37ef1f91c20f0ab162ce60f8c38400b917fa64
> COLO: introduce new API to prepare/start/do/get_error/stop replication
>=20
> a0ddc0b359375b2418213966dfbdbfab593ecc6f
> tools/libxl: introduction of libxl__qmp_restore to load qemu state
>=20

It's nice to call out what changed between v8 and v9 to focus reviewer's
attention on those aspects.

>=20
> Zhang Chen (2):
>   Add a new qmp command to start/stop replication
>   Add a new qmp command to do checkpoint, query xen replication status
>=20
>  migration/colo.c | 49 +++++++++++++++++++++++++++++++++++++
>  qapi-schema.json | 74 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 123 insertions(+)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6WOqjXN2uBoFao47C1LpB7dXRFPHlhxc5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsGw3AAoJEKeha0olJ0NqkRQH/3aPIK3Ta9vfb0NCwRdtD8nv
k0T+CTn6VAS5QNO6u9qUoKiRLYuVzmPxxMmuUroZufmt3t5D5MrVglWNRQc9400Z
KBxyIBpFyb2HftGZO9dNki4FL3kPHxfbBtsWVl0W3LL4cBiHFhJv5YlXdokI7R2m
TC1X2V8DL6yt6C5M2bRTwjv6oFPyD/yuW0EtT/u9PHgFOfsJ1iJqd3KYYS0XnZXw
uM2aqwsBr7LfsSOacnigTf6N2oYgIST0eddPGKARKALjMFeMNmC/qdoORP3qcKMr
C4iHiF3B57ArerhK/d54TzsruYjhltvpLn/MrNZvDeBs3t1lwA7XcLXgcDbpMbg=
=1pXI
-----END PGP SIGNATURE-----

--6WOqjXN2uBoFao47C1LpB7dXRFPHlhxc5--
