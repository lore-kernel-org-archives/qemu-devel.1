Received: from eggs.gnu.org ([2001:4830:134:3::10]:42427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30Wf-0001Y0-Kg
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30Wb-0006In-25
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d30Wa-0006Ho-PK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:29:00 -0400
References: <1492662763-13852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d45772de-5011-9b0c-f5aa-6dcdd6f4c00f@redhat.com>
Date: Tue, 25 Apr 2017 08:28:53 -0500
MIME-Version: 1.0
In-Reply-To: <1492662763-13852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BnBljppD11mEbuR44LbGh0dEX83gsUiW7"
Subject: Re: [Qemu-devel] [PATCH] COLO-compare: Add compare_lock aviod
 comparison conflict
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
--BnBljppD11mEbuR44LbGh0dEX83gsUiW7
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-ID: <d45772de-5011-9b0c-f5aa-6dcdd6f4c00f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] COLO-compare: Add compare_lock aviod
 comparison conflict
References: <1492662763-13852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1492662763-13852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 11:32 PM, Zhang Chen wrote:

In the subject: s/aviod/avoid/

> When network traffic heavy, compare_pri_rs_finalize() and
> compare_sec_rs_finalize() have a chance to confilct.

s/confilct/conflict/

> Both of them call colo_compare_connection() to compare packet,
> But during compare_pri_rs_finalize() comparison, have secondary
> packet come and call compare_sec_rs_finalize(), that packet will be
> handle twice. If packet same, the pkt will be double free.
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BnBljppD11mEbuR44LbGh0dEX83gsUiW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/08WAAoJEKeha0olJ0NqZQQIAK8AA0VK81ceo830vQn2YfDw
WzR6ijWALflT9jyTg8FPj8uiKxK5tQw1TOAd9h/YHo5dKgdBQUr2mwjP/j9Tk01d
KX3oTw5GHtMFg2Ani7d+k6u6tN3GRlLweAXSeW6dN4nBpMXETIbuhUrL9QHkQuTj
VhqxVMvlzXX/5u03XExzpqsEtyRkStw/qqTqJRcM3wJbFpz8X50jU45vdkvBNfbt
qccMYIv1rd2ygASQuTNZiUrt+CmYxYAx/LxJhsbkF8WyOYRtYLty1qbR7tiqa4+c
x++elcMMwAwq5LjIeAfLKn1xirtU0ICCFe3nszZcF/tnoFVumTP8PuLoyDzewkI=
=uTCX
-----END PGP SIGNATURE-----

--BnBljppD11mEbuR44LbGh0dEX83gsUiW7--
