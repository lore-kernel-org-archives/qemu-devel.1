Received: from eggs.gnu.org ([2001:4830:134:3::10]:39240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDw2Y-0004As-Dy
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDw2T-0006UY-LL
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:22:54 -0500
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <082106be-a571-e98f-d1b6-a09ee36abb57@redhat.com>
Date: Mon, 5 Dec 2016 10:22:37 -0600
MIME-Version: 1.0
In-Reply-To: <1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UAmf010DWBNI35PjGqdQwRtEx9bWrWvKM"
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/6] replication: add shared-disk
 and shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, wency@cn.fujitsu.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UAmf010DWBNI35PjGqdQwRtEx9bWrWvKM
From: Eric Blake <eblake@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com,
 Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, wency@cn.fujitsu.com,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <082106be-a571-e98f-d1b6-a09ee36abb57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/6] replication: add shared-disk and
 shared-disk-id options
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
 <1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2016 02:35 AM, zhanghailiang wrote:
> We use these two options to identify which disk is
> shared
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
> v2:
> - add these two options for BlockdevOptionsReplication to support
>   qmp blockdev-add command.
> - fix a memory leak found by Changlong
> ---

> +++ b/qapi/block-core.json
> @@ -2232,12 +2232,19 @@
>  #          node who owns the replication node chain. Must not be given=
 in
>  #          primary mode.
>  #
> +# @shared-disk-id: #optional The id of shared disk while in replicatio=
n mode.
> +#
> +# @shared-disk: #optional To indicate whether or not a disk is shared =
by
> +#               primary VM and secondary VM.

Both of these need a '(since 2.9)' designation since they've missed 2.8,
and could probably also use documentation on the default value assumed
when the parameter is omitted.

> +#
>  # Since: 2.8
>  ##
>  { 'struct': 'BlockdevOptionsReplication',
>    'base': 'BlockdevOptionsGenericFormat',
>    'data': { 'mode': 'ReplicationMode',
> -            '*top-id': 'str' } }
> +            '*top-id': 'str',
> +            '*shared-disk-id': 'str',
> +            '*shared-disk': 'bool' } }
> =20
>  ##
>  # @NFSTransport
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UAmf010DWBNI35PjGqdQwRtEx9bWrWvKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRZRNAAoJEKeha0olJ0NqjBEIAJWKsHd+N46c2GusqGA7Wg1S
4+yeBpNcZEeZlfHJA5JYUn1F0Zbs86bjk+bNVvU0HB1wYv3RqEd0eUgZxK8HBLPH
Of6c5/uPNlqfZFNYo+5GmlIhWb72ADJi1+OXxMuiC7Sk6+/Y/a2Z0uRbrLdKZ6GF
QRc8xN7M+u6G8ZaXlOr7fuLzyVfkXeKRlyPrFXDuJsnA/d3tPmUkku9kquBIL4hl
QMRWCNYTzsNedLh2FdAFFRt64iENT4hjsJwG8kAikNo4EVkGp9kA0FTn70PzxgaP
Sn2kagOxDLWRQIhRm2tkM0bn06X25gN8tldrGnKl4cc8UhJ/LQDWHG2QjNatjRE=
=g80e
-----END PGP SIGNATURE-----

--UAmf010DWBNI35PjGqdQwRtEx9bWrWvKM--
