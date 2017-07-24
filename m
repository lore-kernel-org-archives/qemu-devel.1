Received: from eggs.gnu.org ([2001:4830:134:3::10]:32793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZbwz-00088x-MC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZbww-00063B-K4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:55:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZbww-00062P-AO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:54:58 -0400
References: <1500921322-36875-1-git-send-email-peng.hao2@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <961f88c4-c863-5242-c38a-f86dfa6834ee@redhat.com>
Date: Mon, 24 Jul 2017 06:54:52 -0500
MIME-Version: 1.0
In-Reply-To: <1500921322-36875-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JWphJdlC0Vhj2Im5IiuaGnlMkVbWrsDSL"
Subject: Re: [Qemu-devel] [PATCH V3] rtc: fix a infinite loop in windows vm
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, mst@redhat.com, pbonzini@redhat.com
Cc: Liu Yi <liu.yi24@zte.com.cn>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JWphJdlC0Vhj2Im5IiuaGnlMkVbWrsDSL
From: Eric Blake <eblake@redhat.com>
To: Peng Hao <peng.hao2@zte.com.cn>, mst@redhat.com, pbonzini@redhat.com
Cc: Liu Yi <liu.yi24@zte.com.cn>, qemu-devel@nongnu.org
Message-ID: <961f88c4-c863-5242-c38a-f86dfa6834ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3] rtc: fix a infinite loop in windows vm
 startup
References: <1500921322-36875-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1500921322-36875-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 01:35 PM, Peng Hao wrote:
> When a windows vm starts, periodic timer of rtc will stop several times=
=2E
> windows kernel will check whether REG_A_UIP is changed. REG_C's interru=
pt
> flags will not be cleared when periodic timer stops and the update time=
r
> will switch to alarm timer. So the expiration time of alarm timer is ve=
ry
> long and REG_A_UIP will not vary.At last windows kernel will repeat to =

> check REG_A_UIP all the time.
>=20
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Liu Yi <liu.yi24@zte.com.cn>
> ---

When posting a v3, it's useful to tell us (after the --- separator) what
changed from v2, to help us focus on why a v3 was needed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JWphJdlC0Vhj2Im5IiuaGnlMkVbWrsDSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll14AwACgkQp6FrSiUn
Q2pplggAh2pVfNySXmTy1b1wiRQu2pZtYPAr+Sgo6cG4XuPr0UoreosoPGOmRkp0
b+enGxURCPtu930Sq7Buh6Fr6V9qc0CQGxk6CupH3HIBGqrRzXI4RHtLseymNERa
Frm6iqfm5HS/cH4oRMS0XGgPG0dFxBVSX43exEGxJsovCxkXWt9+fjMsOvEwki6Y
D4fT0VG3wNIRu2HB6AK7OQ9zTqTfp6XWjPsf5J3kFnZjC/8xClflzie0rq4vvvA0
iJ8nANyhyUl4o0O0+Dr2yT7vPyzZoGSwStGQD2Nj4s/LAWWzx3nw501jZscTp+Vf
P5KMfJehwbTztzkNt7OD4ed+euTlkg==
=AWfR
-----END PGP SIGNATURE-----

--JWphJdlC0Vhj2Im5IiuaGnlMkVbWrsDSL--
