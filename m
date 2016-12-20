Received: from eggs.gnu.org ([2001:4830:134:3::10]:42252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJLZJ-0001cb-Ae
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJLZF-0007Ef-6g
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:39:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJLZE-0007Dl-TP
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:39:01 -0500
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <610c64a5-5bb5-a125-302f-69a4761f3130@redhat.com>
Date: Tue, 20 Dec 2016 08:38:57 -0600
MIME-Version: 1.0
In-Reply-To: <1481856403-23599-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3TtuHs8tJSXlukCIVwwdk0JtfO7OXs2al"
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 1/2] Add a new qmp command to
 start/stop replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3TtuHs8tJSXlukCIVwwdk0JtfO7OXs2al
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>,
 Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <610c64a5-5bb5-a125-302f-69a4761f3130@redhat.com>
Subject: Re: [PATCH for-2.9 V4 1/2] Add a new qmp command to start/stop
 replication
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1481856403-23599-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1481856403-23599-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2016 08:46 PM, Zhang Chen wrote:
> We can call this qmp command to start/stop replication outside of qemu.=

> Like Xen colo need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  docs/qmp-commands.txt | 18 ++++++++++++++++++
>  migration/colo.c      | 23 +++++++++++++++++++++++
>  qapi-schema.json      | 19 +++++++++++++++++++
>  3 files changed, 60 insertions(+)

For the QMP side:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3TtuHs8tJSXlukCIVwwdk0JtfO7OXs2al
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWUKBAAoJEKeha0olJ0NqTTgH/RWt3hvvmmvOWu5ZK/41xzs2
gC3QdEpp+VGXjuX26eLoR0eKE8xrDQewvmH729q7LkZPijEj4dTgrI1LlcTlJ1x9
CDPrUPJGUkdUZc4pzTOk5UjlbrL3ZrLY3vtX4w5Hk3hc8c/DpSmwmJsfBTXBGKmU
C8lrrXWHP/gODrgfH/dbDTzCTn624XTHZhK+bFDJGY+LTvSOaovXaRVPdWn20RcZ
bmEXaR15a8lA03/BI7ZhZ6Gdrpx0R42rqP8VOEJslfNCKXJpJY3tQblNiKY3oKaS
2k/4WjiTLO3KpBQx/qBnF56YLnT47QexuI6fI6DAluCDqZYXvgj+6q8EkGChLb8=
=rlqJ
-----END PGP SIGNATURE-----

--3TtuHs8tJSXlukCIVwwdk0JtfO7OXs2al--
