Received: from eggs.gnu.org ([2001:4830:134:3::10]:49528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEogl-0005mZ-4e
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEogi-0003oH-0u
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:44:03 -0500
Received: from [45.249.212.187] (port=2494 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEogg-0003lH-MK
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:43:59 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 8 Dec 2016 02:43:15 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA156ACB@DGGEMA505-MBX.china.huawei.com>
References: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] crypto: add 3des-ede support
 when using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
Cc: "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: longpeng
> Sent: Thursday, December 08, 2016 10:33 AM
> To: berrange@redhat.com; eblake@redhat.com; armbru@redhat.com
> Cc: Wubin (H); Zhoujian (jay, Euler); Gonglei (Arei); qemu-devel@nongnu.o=
rg;
> longpeng
> Subject: [PATCH for-2.9 v2] crypto: add 3des-ede support when using
> libgcrypt/nettle
>=20
> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
> support when using libgcrypt or nettle.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
> Changes since v1:
>     - rename 3des-ede to 3des. [Daniel]
>     - add (since 2.9) in comment. [Gonglei]
>     - add ctr(3des) testcase. [Gonglei]
>     - split original patchset. [Gonglei]
>=20
> ---
>  crypto/cipher-gcrypt.c     |   6 +++
>  crypto/cipher-nettle.c     |  37 ++++++++++++++
>  crypto/cipher.c            |   7 ++-
>  qapi/crypto.json           |   3 +-
>  tests/test-crypto-cipher.c | 119
> +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
