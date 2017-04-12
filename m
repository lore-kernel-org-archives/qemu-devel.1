Received: from eggs.gnu.org ([2001:4830:134:3::10]:42881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyJFq-0002nc-Qb
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyJFp-0000X1-TM
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:28:18 -0400
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4125e702-1298-f7c6-5152-fbf3b5d06f57@redhat.com>
Date: Wed, 12 Apr 2017 09:28:07 -0500
MIME-Version: 1.0
In-Reply-To: <1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GtlSwAGtdgJIKkvemOoaQpbEJXHCwQpwl"
Subject: Re: [Qemu-devel] [PATCH v4 2/6] replication: add shared-disk and
 shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GtlSwAGtdgJIKkvemOoaQpbEJXHCwQpwl
From: Eric Blake <eblake@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com,
 zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>,
 qemu-block@nongnu.org
Message-ID: <4125e702-1298-f7c6-5152-fbf3b5d06f57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/6] replication: add shared-disk and
 shared-disk-id options
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
 <1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 09:05 AM, zhanghailiang wrote:
> We use these two options to identify which disk is
> shared
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
> v4:
> - Add proper comment for primary_disk (Stefan)
> v2:
> - Move g_free(s->shared_disk_id) to the common fail process place (Stef=
an)
> - Fix comments for these two options
> ---

> +++ b/qapi/block-core.json
> @@ -2661,12 +2661,20 @@
>  #          node who owns the replication node chain. Must not be given=
 in
>  #          primary mode.
>  #
> +# @shared-disk-id: Id of shared disk while is replication mode, if @sh=
ared-disk
> +#                  is true, this option is required (Since: 2.10)
> +#
> +# @shared-disk: To indicate whether or not a disk is shared by primary=
 VM
> +#               and secondary VM. (The default is false) (Since: 2.10)=

> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsReplication',
>    'base': 'BlockdevOptionsGenericFormat',
>    'data': { 'mode': 'ReplicationMode',
> -            '*top-id': 'str' } }
> +            '*top-id': 'str',
> +            '*shared-disk-id': 'str',
> +            '*shared-disk': 'bool' } }

Do we need a separate bool and string? Or is it sufficient to say that
if shared-disk is omitted, we are not sharing, and that if a shared-disk
string is present, then we are sharing and it names the id of the shared
disk.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GtlSwAGtdgJIKkvemOoaQpbEJXHCwQpwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7jl3AAoJEKeha0olJ0NqA5EIAKkgVStf5VCDuMdjfHny9x4d
VuFxMDSkzscHLTNDdLjIC8gWXTjfamoL1K+E0cg6BbzQqs7g0P4k7gRP/WksdZjv
rMRnv8O6/WK//+8mmhseanRIJRIljYYFXT2QB4NOJnyFs4YOJJXw2QprC9pzhMmN
8FQYAPWCofsUwM7sQru4jDAsrgYLFDFdWce1hLVENYnMq7fWvblMohkKKZ+PbYNc
TLEcEBuGQm1sh2H1H3zF7JDrEpLnHsRMPsa7QDfuILuZjabdWVOaT3ET3jLXxRMR
pkYdsnHgrXTcDP3vhQw7H2vpul6mABtoVX7ZTJQQeN0PoHSazAvjLiHwjYX71lQ=
=pGIF
-----END PGP SIGNATURE-----

--GtlSwAGtdgJIKkvemOoaQpbEJXHCwQpwl--
