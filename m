Received: from eggs.gnu.org ([2001:4830:134:3::10]:51620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLnQJ-00075p-B1
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLnQG-0001eL-NP
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:20:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLnQG-0001ct-HK
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:20:08 -0400
Date: Fri, 16 Jun 2017 10:20:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170616092004.GF31462@stefanha-x1.localdomain>
References: <201706131924483092713@zte.com.cn>
	<d62e03ee-f3ab-303e-011d-8b995530b6ab@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <d62e03ee-f3ab-303e-011d-8b995530b6ab@redhat.com>
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTog562U5aSNOiBSZTogW1BBVENI?=
 =?utf-8?q?v2_02/04=5D_colo-compare=3A_Process_pactkets_in_the_IOThread_of?=
 =?utf-8?q?the_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: wang.yong155@zte.com.cn, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 12:23:27PM +0800, Jason Wang wrote:
> Paolo, Marc and Stefan:
>=20
> We want let chardev front-end run in colo comparing IOThread. This looks =
not
> supported by current chardev frontend API. Any idea/suggestion on how to
> achieve this?

A follow-up:

I just noticed that io/ supports AioContext.

This means a different approach is to add AioContext support to the
chardev API so that either GMainContext or AioContext can be used.

Again, I'm not sure how feasible this is.

Stefan

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQ6LEAAoJEJykq7OBq3PIC44IALHVafTvQgfNgthaQovHzb3F
FyVBxHmCP+7kdozsZkbDw8OYFQclx3kEV082UfmHPA+WdNue9UsQvEPv+2f7lLer
SzHbCNiZofGE2AJC6go0zX/GoBkpZq9rJbAiuLcKbG8pN9ns+DyaHWmyz4rQXicy
AYYm3zl+8OOa2c+bQppXAzMRE08YW9DmhEgPgRi10skSPSS1WVZ247m2tX7u5HD4
P9Gkl5mVkIJ9DICzlA2EFb/e7B5uVENxmxc8quVkDq6zVZNVXC07zxNBpH9FNVzZ
kHl4bWIq8R4cu8lzjfdqj2nJqLcuFrdnoijTyuww5I8qH9qB5onJ2T9LmE+LHr0=
=d2wz
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
