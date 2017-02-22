Received: from eggs.gnu.org ([2001:4830:134:3::10]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYwu-0007Hm-Q4
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYwr-0002fr-Li
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:35:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgYwr-0002fd-D3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:35:21 -0500
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-6-git-send-email-zhang.zhanghailiang@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <176b99f5-34fe-460d-8f23-1bb2ee94fa3a@redhat.com>
Date: Wed, 22 Feb 2017 09:35:18 -0600
MIME-Version: 1.0
In-Reply-To: <1487734936-43472-6-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BCCIV3ED2KHSMlGqmWetvwsvJ71XxdhTf"
Subject: Re: [Qemu-devel] [PATCH 05/15] COLO: Handle shutdown command for VM
 in COLO state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, xiecl.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BCCIV3ED2KHSMlGqmWetvwsvJ71XxdhTf
From: Eric Blake <eblake@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, xiecl.fnst@cn.fujitsu.com,
 lizhijian@cn.fujitsu.com
Message-ID: <176b99f5-34fe-460d-8f23-1bb2ee94fa3a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/15] COLO: Handle shutdown command for VM
 in COLO state
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
 <1487734936-43472-6-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-6-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 09:42 PM, zhanghailiang wrote:
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
> v19:
> - fix title and comment

Did you miss putting v19 in the subject line?


> +++ b/qapi-schema.json
> @@ -1157,12 +1157,14 @@
>  #
>  # @vmstate-loaded: VM's state has been loaded by SVM.
>  #
> +# @guest-shutdown: shutdown require from PVM to SVM

maybe s/require/requested/ ?

Missing '(since 2.9)'

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
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BCCIV3ED2KHSMlGqmWetvwsvJ71XxdhTf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYra+2AAoJEKeha0olJ0Nq0KkH/RtYnd2vXwj421T0eMsfWa4x
f2mbcZ+/em3X42vSh2U1xS8dM6Db/N2WcOtpsCBmGJ90aC10LGwDDvGEbGeij+jT
5shTVhp7vadyQ2i9JJ4nTjk7tG8fzHf5bNhrC0u1RyfebwdXLoYeu0i7mjnv7Zai
2DRgjivF6Nt+7iYylKb3y1t52GeL284ZJtTYAB4dO+SjeVxMilUKzNnL7upyVb8+
pURsSiK0hCN7a501eFZJgZhKjrbOdgPqQzmZ4xkjgC5K3Lr6+X1rThUxnmrtJeir
9nO4IQ5hCMg8HjFUCnJE0XD9PBBgFuKBpm+bjktqaQHwSZGa5+zx11LYB3tt2V4=
=BSM8
-----END PGP SIGNATURE-----

--BCCIV3ED2KHSMlGqmWetvwsvJ71XxdhTf--
