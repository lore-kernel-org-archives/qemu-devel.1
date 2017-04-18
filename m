Received: from eggs.gnu.org ([2001:4830:134:3::10]:60784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0HsP-0002vl-Ri
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0HsO-00006M-Th
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:24:17 -0400
References: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
	<1489756546-27142-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac3e7855-9dfb-5bc7-daee-6d062173f6cb@redhat.com>
Date: Mon, 17 Apr 2017 20:23:56 -0500
MIME-Version: 1.0
In-Reply-To: <1489756546-27142-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6GjsTjhmgRJbGVBBmA3iPiwhtQwVpRbRk"
Subject: Re: [Qemu-devel] [PULL 2/8] replication: clarify permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Wen Congyang <wency@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>, Wen Congyang <wencongyang2@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6GjsTjhmgRJbGVBBmA3iPiwhtQwVpRbRk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Wen Congyang <wency@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>, Wen Congyang <wencongyang2@huawei.com>
Message-ID: <ac3e7855-9dfb-5bc7-daee-6d062173f6cb@redhat.com>
Subject: Re: [Qemu-devel] [PULL 2/8] replication: clarify permissions
References: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
 <1489756546-27142-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489756546-27142-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/17/2017 08:15 AM, Kevin Wolf wrote:
> From: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
>=20
> Even if hidden_disk, secondary_disk are backing files, they all need
> write permissions in replication scenario. Otherwise we will encouter
> below exceptions on secondary side during adding nbd server:
>=20
> {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk', 'wri=
table': true } }
> {"error": {"class": "GenericError", "desc": "Conflicts with use by hidd=
en-qcow2-driver as 'backing', which does not allow 'write' on sec-qcow2-d=
river-for-nbd"}}
>=20
> CC: Zhang Hailiang <zhang.zhanghailiang@huawei.com>
> CC: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> CC: Wen Congyang <wencongyang2@huawei.com>

This address for Wen Congyang is different than the one listed in
MAINTAINERS for replication (M: Wen Congyang <wency@cn.fujitsu.com>),
and different still from addresses my mailer has harvested from other
posts (wencongyang@gmail.com).  The MAINTAINERS entry is now resulting
in 'undelivered mail' bounce messages, can you please submit an update
to MAINTAINERS with your new preferred address? [or gently correct me if
I'm confusing two people with the same name?]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6GjsTjhmgRJbGVBBmA3iPiwhtQwVpRbRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9WqsAAoJEKeha0olJ0NqDAkH/0Vv3q23WKtPPoPhM7Xe0ohA
Rt5OEFBXwuTKhRjGT+fjbOiYAsOPIP8ztV5/3W2gNCGqbgnlT7NKa24YDbgQeZ65
dJLyuvUMMB1CsQPDDlEy43D4CF4vnuc9m74YsiFgBNHwyo6EMGmfOzssxUQg3ODQ
FTb3XnRdpJlK2uaeDvTgmDau/E4uE+bjuCIjB0Oq6n8ioR93zBtVkoFSBaEsZhnb
OJczpWrWRqq7ewasAPK1vW3Mon/6i3ylh9A5/+Zj9BsuFGYDONTo3NN82kgAdUjj
egvsqcQpKtVyQ2mQQu4WfS2cJa5bn7Wk28fGwIQGrLCxfF1e4tmK4NjKOuhMsqQ=
=jacy
-----END PGP SIGNATURE-----

--6GjsTjhmgRJbGVBBmA3iPiwhtQwVpRbRk--
