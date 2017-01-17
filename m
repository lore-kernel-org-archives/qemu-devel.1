Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTYQk-0003tv-GJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTYQg-0006LJ-H5
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:24:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTYQg-0006Kl-94
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:24:22 -0500
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484657864-21708-4-git-send-email-zhang.zhanghailiang@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c79e149c-7d0e-76ae-20f5-b99a595650b5@redhat.com>
Date: Tue, 17 Jan 2017 12:24:19 -0600
MIME-Version: 1.0
In-Reply-To: <1484657864-21708-4-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eecJuWGhfj4b8q6vm4rSOeTiRlIMHxr0F"
Subject: Re: [Qemu-devel] [PATCH 3/3] COLO: Don't process failover request
 while loading VM's state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, quintela@redhat.com, dgilbert@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eecJuWGhfj4b8q6vm4rSOeTiRlIMHxr0F
From: Eric Blake <eblake@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 eddie.dong@intel.com, lizhijian@cn.fujitsu.com,
 zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com
Message-ID: <c79e149c-7d0e-76ae-20f5-b99a595650b5@redhat.com>
Subject: Re: [PATCH 3/3] COLO: Don't process failover request while loading
 VM's state
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
 <1484657864-21708-4-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484657864-21708-4-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2017 06:57 AM, zhanghailiang wrote:
> We should not do failover work while the main thread is loading
> VM's state. Otherwise the consistent of VM's memory and
> device state will be broken.
>=20
> We will restart the loading process after jump over the stage,
> The new failover status 'RELAUNCH' will help to record if we
> need to restart the process.
>=20
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/colo.c | 26 ++++++++++++++++++++++++++
>  qapi-schema.json |  4 +++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi-schema.json
> @@ -856,10 +856,12 @@
>  #
>  # @completed: finish the process of failover
>  #
> +# @relaunch: restart the failover process, from 'none' -> 'completed'

You'll need to add a '(since 2.9)' tag

> +#
>  # Since: 2.8
>  ##
>  { 'enum': 'FailoverStatus',
> -  'data': [ 'none', 'require', 'active', 'completed'] }
> +  'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> =20
>  ##
>  # @x-colo-lost-heartbeat:
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eecJuWGhfj4b8q6vm4rSOeTiRlIMHxr0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfmFTAAoJEKeha0olJ0NqdWcH/RvK8zYXvLa4M+5oxc5hCKta
cxF/A/5j/ArAoKGSFrEnGj9UqUFYu2Y3LDRhaUTW11ra+fjJxHtMzkj42xC+F9AP
DT1R9yVhFI4whU/earNcBU7WzrWrwI3GV0P+UfKR0EWJfNBqIUv47yiFVRKvAegr
z+2ICOsMs8ytkj1kZasWOiRvgGLceGHfQ8d/xH9qgU7zoYGIsDl/o3zmPRYl/Qv9
DmFMKAxVN8yXGIZGLUkEi9rN7DrkuVmipzhPGWgVx+tKR/imIz5IYxHV89cB53zX
VBm06nb/GnuN55yHKc7GMSYHXdywYNk7Iu7aDUnWOf4X3dzMCHfQrxMPQCBVzxo=
=PBdv
-----END PGP SIGNATURE-----

--eecJuWGhfj4b8q6vm4rSOeTiRlIMHxr0F--
