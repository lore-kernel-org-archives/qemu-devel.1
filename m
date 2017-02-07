Received: from eggs.gnu.org ([2001:4830:134:3::10]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb82m-0004VC-Ls
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb82i-0001Sp-JW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:51:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cb82i-0001SQ-BD
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:50:56 -0500
References: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1483596532-14552-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fd43c21-f16c-e9ef-7a3b-90b4e2949eed@redhat.com>
Date: Tue, 7 Feb 2017 09:50:53 -0600
MIME-Version: 1.0
In-Reply-To: <1483596532-14552-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ICXe3CeckdTvjI1PLoXgmHifWcxKTF2UI"
Subject: Re: [Qemu-devel] [PATCH V6 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Bian Naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Wen Congyang <wencongyang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ICXe3CeckdTvjI1PLoXgmHifWcxKTF2UI
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Bian Naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <7fd43c21-f16c-e9ef-7a3b-90b4e2949eed@redhat.com>
Subject: Re: [PATCH V6 2/2] Add a new qmp command to do checkpoint, query xen
 replication status
References: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1483596532-14552-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1483596532-14552-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 12:08 AM, Zhang Chen wrote:
> We can call this qmp command to do checkpoint outside of qemu.
> Xen colo will need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  docs/qmp-commands.txt | 24 ++++++++++++++++++++++++

This file no longer exists since commit 4d8bb958; can you please rebase
this and post a v7? (The docs now live directly in the qapi-schema.json
file).

>  migration/colo.c      | 17 +++++++++++++++++
>  qapi-schema.json      | 50 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  3 files changed, 91 insertions(+)

It looks like you have addressed all my concerns from earlier versions,
though, so the API seems reasonable.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ICXe3CeckdTvjI1PLoXgmHifWcxKTF2UI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmezdAAoJEKeha0olJ0NqaJ8H/2sHLeplcWBvVKeiSZeTlmxd
h2eZsCoZv2qOhU4t9STYJVpVh9yZyMV1tyuWbQqtfBcNCqwiotvqtLCebVIt2Bqx
vsHOTTi7kqP9zV/sKeBNQGfejy4iGT3FfX+PpRpWYVp7P1oo4WcRvLLLsXwifjQK
uYNuGBERMzAGRswZKHwWJ3i8jBqFZx3glP5rx8qE4AjmdD/1cOitps/zJR96yd8b
mMN4FSITUFalqBdzaa27mKhqrYX7eDiGhg5noJKJOwsaY+U0ssbp81Sv/0FC5oHp
P6Jb37hOtTSx/KMmDdoCpvvscL0CNIi3pKGAWNYsnuksSVIvjfDXxLeyjeh2HRo=
=7wfG
-----END PGP SIGNATURE-----

--ICXe3CeckdTvjI1PLoXgmHifWcxKTF2UI--
