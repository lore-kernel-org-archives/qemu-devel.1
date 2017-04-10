Received: from eggs.gnu.org ([2001:4830:134:3::10]:35273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cxVe3-0000Q9-IM
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cxVe0-0007er-FU
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:29:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3360
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cxVdz-0007co-NH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:29:56 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 10 Apr 2017 09:28:45 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA224512@DGGEMA505-MBS.china.huawei.com>
References: <1491814997-58268-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1491814997-58268-1-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.10 00/19] crypto: add af_alg-backend
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
Cc: "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> -----Original Message-----
> From: longpeng
> Sent: Monday, April 10, 2017 5:03 PM
> To: berrange@redhat.com; kraxel@redhat.com; pbonzini@redhat.com;
> eblake@redhat.com; armbru@redhat.com
> Cc: Xuquan (Quan Xu); Gonglei (Arei); qemu-devel@nongnu.org; longpeng
> Subject: [PATCH for-2.10 00/19] crypto: add af_alg-backend support
>=20
> The AF_ALG socket family is the userspace interface for linux
> crypto API, users can use it to access hardware accelerators.
>=20
> This patchset adds a afalg-backend for qemu crypto subsystem. Currently
> when performs encrypt/decrypt, we'll try afalg-backend first and will
> back to libiary-backend if it failed.
>=20
Cool.

You'd better add the performance compared results in the cover letter. :)


Regards,
-Gonglei

> In the next step, It would support a command parameter to specifies
> which backends prefer to and some other improvements.
>=20
> Longpeng(Mike) (19):
>   crypto: cipher: introduce context free function
>   crypto: cipher: introduce qcrypto_cipher_ctx_new for gcrypt-backend
>   crypto: cipher: introduce qcrypto_cipher_ctx_new for nettle-backend
>   crypto: cipher: introduce qcrypto_cipher_ctx_new for builtin-backend
>   crypto: cipher: add cipher driver framework
>   crypto: hash: add hash driver framework
>   crypto: hmac: move crypto/hmac.h into include/crypto/
>   crypto: hmac: introduce qcrypto_hmac_ctx_new for gcrypt-backend
>   crypto: hmac: introduce qcrypto_hmac_ctx_new for nettle-backend
>   crypto: hmac: introduce qcrypto_hmac_ctx_new for glib-backend
>   crypto: hmac: add hmac driver framework
>   socket: add af_alg family support
>   crypto: introduce some common functions for af_alg backend
>   crypto: cipher: add af_alg cipher support
>   tests: crypto: add cipher speed case
>   crypto: hash: add af_alg hash support
>   tests: crypto: add hash speed case
>   crypto: hmac: add af_alg hmac support
>   tests: crypto: add hmac speed case
>=20
>  configure                   |  21 ++++
>  crypto/Makefile.objs        |   3 +
>  crypto/afalg-comm.c         |  71 ++++++++++++++
>  crypto/cipher-afalg.c       | 229
> +++++++++++++++++++++++++++++++++++++++++++
>  crypto/cipher-builtin.c     | 120 +++++++++++------------
>  crypto/cipher-gcrypt.c      |  99 ++++++++++---------
>  crypto/cipher-nettle.c      |  78 ++++++++-------
>  crypto/cipher.c             |  87 +++++++++++++++++
>  crypto/hash-afalg.c         | 232
> ++++++++++++++++++++++++++++++++++++++++++++
>  crypto/hash-gcrypt.c        |  17 ++--
>  crypto/hash-glib.c          |  17 ++--
>  crypto/hash-nettle.c        |  17 ++--
>  crypto/hash.c               |  22 +++++
>  crypto/hmac-gcrypt.c        |  39 ++++----
>  crypto/hmac-glib.c          |  58 +++++------
>  crypto/hmac-nettle.c        |  39 +++-----
>  crypto/hmac.c               |  65 +++++++++++++
>  crypto/hmac.h               | 166 -------------------------------
>  include/crypto/afalg-comm.h |  74 ++++++++++++++
>  include/crypto/cipher.h     |  29 ++++++
>  include/crypto/hash.h       |  13 +++
>  include/crypto/hmac.h       | 199
> +++++++++++++++++++++++++++++++++++++
>  include/qemu/sockets.h      |   6 ++
>  qapi-schema.json            |  21 +++-
>  tests/test-crypto-cipher.c  |  92 ++++++++++++++++--
>  tests/test-crypto-hash.c    |  56 ++++++++++-
>  tests/test-crypto-hmac.c    |  66 ++++++++++++-
>  util/qemu-sockets.c         |  91 +++++++++++++++++
>  28 files changed, 1599 insertions(+), 428 deletions(-)
>  create mode 100644 crypto/afalg-comm.c
>  create mode 100644 crypto/cipher-afalg.c
>  create mode 100644 crypto/hash-afalg.c
>  delete mode 100644 crypto/hmac.h
>  create mode 100644 include/crypto/afalg-comm.h
>  create mode 100644 include/crypto/hmac.h
>=20
> --
> 1.8.3.1
>=20
