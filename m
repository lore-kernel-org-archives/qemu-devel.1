Received: from eggs.gnu.org ([2001:4830:134:3::10]:56583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2fKf-0007tW-F3
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2fKc-0000uA-Dw
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d2fKc-0000tu-4J
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:51:14 -0400
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492849558-17540-6-git-send-email-zhang.zhanghailiang@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3333f034-0fd2-875f-fbfc-a2c0eda1f09a@redhat.com>
Date: Mon, 24 Apr 2017 09:51:11 -0500
MIME-Version: 1.0
In-Reply-To: <1492849558-17540-6-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nxNraKcIoi73L6G5Op01gvkVF8TpaBEtO"
Subject: Re: [Qemu-devel] [PATCH v2 05/18] COLO: Handle shutdown command for
 VM in COLO state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, quintela@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nxNraKcIoi73L6G5Op01gvkVF8TpaBEtO
From: Eric Blake <eblake@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com,
 zhangchen.fnst@cn.fujitsu.com, quintela@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3333f034-0fd2-875f-fbfc-a2c0eda1f09a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/18] COLO: Handle shutdown command for
 VM in COLO state
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
 <1492849558-17540-6-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-6-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/22/2017 03:25 AM, zhanghailiang wrote:
> If VM is in COLO FT state, we need to do some extra works before
> starting normal shutdown process.
>=20
> Secondary VM will ignore the shutdown command if users issue it directl=
y
> to Secondary VM. COLO will capture shutdown command and after
> shutdown request from user.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -1187,12 +1187,14 @@
>  #
>  # @vmstate-loaded: VM's state has been loaded by SVM.
>  #
> +# @guest-shutdown: shutdown requested from PVM to SVM. (Since 2.9)

You missed 2.9. Please fix this to state 2.10.

> +#
>  # Since: 2.8
>  ##
>  { 'enum': 'COLOMessage',
>    'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-repl=
y',
>              'vmstate-send', 'vmstate-size', 'vmstate-received',
> -            'vmstate-loaded' ] }
> +            'vmstate-loaded', 'guest-shutdown' ] }
> =20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nxNraKcIoi73L6G5Op01gvkVF8TpaBEtO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/hDfAAoJEKeha0olJ0Nqr38IAIfPIeavkRDA+E0cokYmoRiK
nqRjxY7ZT89lzgYGnrqxEKVVChlctqV69r5hO1KTAqavewIQBYOn/Bvk/r8hkmVc
uwiCTcikW/Ed/QhE5MPkLZSVRv2wPsMZ8wA4ukYXn8JQR9kUUpFbj9CGcxJf036D
FV9UvCS79vUniDobGofxFCAa652EGgGYnwT97nEh24EHGOUAZ57VdcapDHc5243J
71HOlO5dArPw9C5Q13qxs0kxw3w2+t0+XCrMSPaHg9/y/pDm7nhAVGsqfCPTNsNH
7eUrODMra/jeWCsQGfJfoF/bxPskHfJQozqBs/if/Qt6NYWr6ya4wy0nRmXzS5o=
=DvrW
-----END PGP SIGNATURE-----

--nxNraKcIoi73L6G5Op01gvkVF8TpaBEtO--
