Received: from eggs.gnu.org ([2001:4830:134:3::10]:36242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Ear-00024h-RD
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Ean-0006VT-QD
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:43:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9Ean-0006Tw-H4
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:43:05 -0400
References: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494552955-30529-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d3b85f2-fdb3-641a-96c9-4bb158a50856@redhat.com>
Date: Fri, 12 May 2017 12:43:02 -0500
MIME-Version: 1.0
In-Reply-To: <1494552955-30529-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BQeeUB84P8kvsXqKommmHB7e9AQce6lN2"
Subject: Re: [Qemu-devel] [PATCH 3/3] net/filter-rewriter: Remove unused
 option in filter-rewirter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BQeeUB84P8kvsXqKommmHB7e9AQce6lN2
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-ID: <9d3b85f2-fdb3-641a-96c9-4bb158a50856@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] net/filter-rewriter: Remove unused
 option in filter-rewirter
References: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1494552955-30529-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494552955-30529-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 08:35 PM, Zhang Chen wrote:
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

In the subject: s/rewirter/rewriter/

> ---
>  qemu-options.hx | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 70c0ded..f5e088e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4038,7 +4038,8 @@ Create a filter-redirector we need to differ outd=
ev id from indev id, id can not
>  be the same. we can just use indev or outdev, but at least one of inde=
v or outdev
>  need to be specified.
> =20
> -@item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},re=
writer-mode=3D@var{mode}[,queue=3D@var{all|rx|tx}]
> +@item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},
> +[,queue=3D@var{all|rx|tx}]

Texinfo sources have restrictions on how line-wrapping works, and it's
not always consistent.  It's probably best to stick with the long line,
if you haven't actually validated that the rendered documentation is not
broken when you split the line.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BQeeUB84P8kvsXqKommmHB7e9AQce6lN2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFfQmAAoJEKeha0olJ0NqBpAH/2KbdX60cajtuVMm/eQLkylm
xpjXYouZ2URYlTq1oRE6EE3lICHMvAqwL+CN3848mRvuZVUKPbqnBA5mW4/1qkpR
nmFwqWEeO4QelZps1kDLuCShbGjC35nS8qriBuTTlw3WdWdPecAmi9JtDbShwiky
ouHF6B1SuEKzWwFkTbaMbplWFzf18qtATOpc7ViMi3tncM4iIf69rSuRyBgR2Zh7
ANBJnqP5IAOw0m8sDQosFuiXokgqjMevSrWbcUInkpSq4OYHw7MaorWztSD+zFjq
tVQi/KdwPVkfqGXiMf66CSF/sGI5wZVe23pnagUrb3qG3KAQpzoPFt4LD8Gso/4=
=uM/n
-----END PGP SIGNATURE-----

--BQeeUB84P8kvsXqKommmHB7e9AQce6lN2--
