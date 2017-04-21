Received: from eggs.gnu.org ([2001:4830:134:3::10]:49488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XPR-0005c1-0P
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XPN-0003L4-NO
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:11:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3388
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XPM-0003Js-IU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:11:29 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 12:11:06 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238A2E@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-8-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-8-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 07/18] crypto: hmac: move
 crypto/hmac.h into include/crypto/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> -----Original Message-----
> From: longpeng
> Sent: Monday, April 17, 2017 9:33 AM
> To: berrange@redhat.com
> Cc: Gonglei (Arei); Huangweidong (C); armbru@redhat.com;
> eblake@redhat.com; mst@redhat.com; qemu-devel@nongnu.org; longpeng
> Subject: [PATCH v2 for-2.10 07/18] crypto: hmac: move crypto/hmac.h into
> include/crypto/
>=20
> Moves crypto/hmac.h into include/crypto/, likes cipher.h and hash.h
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hmac.h         | 166 --------------------------------------------=
------
>  include/crypto/hmac.h | 166
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 166 insertions(+), 166 deletions(-)
>  delete mode 100644 crypto/hmac.h
>  create mode 100644 include/crypto/hmac.h
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


> diff --git a/crypto/hmac.h b/crypto/hmac.h
> deleted file mode 100644
> index 0d3acd7..0000000
> --- a/crypto/hmac.h
> +++ /dev/null
> @@ -1,166 +0,0 @@
> -/*
> - * QEMU Crypto hmac algorithms
> - *
> - * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> - * (at your option) any later version.  See the COPYING file in the
> - * top-level directory.
> - *
> - */
> -
> -#ifndef QCRYPTO_HMAC_H
> -#define QCRYPTO_HMAC_H
> -
> -#include "qapi-types.h"
> -
> -typedef struct QCryptoHmac QCryptoHmac;
> -struct QCryptoHmac {
> -    QCryptoHashAlgorithm alg;
> -    void *opaque;
> -};
> -
> -/**
> - * qcrypto_hmac_supports:
> - * @alg: the hmac algorithm
> - *
> - * Determine if @alg hmac algorithm is supported by
> - * the current configured build
> - *
> - * Returns:
> - *  true if the algorithm is supported, false otherwise
> - */
> -bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg);
> -
> -/**
> - * qcrypto_hmac_new:
> - * @alg: the hmac algorithm
> - * @key: the key bytes
> - * @nkey: the length of @key
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Creates a new hmac object with the algorithm @alg
> - *
> - * The @key parameter provides the bytes representing
> - * the secret key to use. The @nkey parameter specifies
> - * the length of @key in bytes
> - *
> - * Note: must use qcrypto_hmac_free() to release the
> - * returned hmac object when no longer required
> - *
> - * Returns:
> - *  a new hmac object, or NULL on error
> - */
> -QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> -                              const uint8_t *key, size_t nkey,
> -                              Error **errp);
> -
> -/**
> - * qcrypto_hmac_free:
> - * @hmac: the hmac object
> - *
> - * Release the memory associated with @hmac that was
> - * previously allocated by qcrypto_hmac_new()
> - */
> -void qcrypto_hmac_free(QCryptoHmac *hmac);
> -
> -/**
> - * qcrypto_hmac_bytesv:
> - * @hmac: the hmac object
> - * @iov: the array of memory regions to hmac
> - * @niov: the length of @iov
> - * @result: pointer to hold output hmac
> - * @resultlen: pointer to hold length of @result
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory regions
> - * present in @iov. The @result pointer will be
> - * filled with raw bytes representing the computed
> - * hmac, which will have length @resultlen. The
> - * memory pointer in @result must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns:
> - *  0 on success, -1 on error
> - */
> -int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> -                        const struct iovec *iov,
> -                        size_t niov,
> -                        uint8_t **result,
> -                        size_t *resultlen,
> -                        Error **errp);
> -
> -/**
> - * qcrypto_hmac_bytes:
> - * @hmac: the hmac object
> - * @buf: the memory region to hmac
> - * @len: the length of @buf
> - * @result: pointer to hold output hmac
> - * @resultlen: pointer to hold length of @result
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory region
> - * @buf of length @len. The @result pointer will be
> - * filled with raw bytes representing the computed
> - * hmac, which will have length @resultlen. The
> - * memory pointer in @result must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns:
> - *  0 on success, -1 on error
> - */
> -int qcrypto_hmac_bytes(QCryptoHmac *hmac,
> -                       const char *buf,
> -                       size_t len,
> -                       uint8_t **result,
> -                       size_t *resultlen,
> -                       Error **errp);
> -
> -/**
> - * qcrypto_hmac_digestv:
> - * @hmac: the hmac object
> - * @iov: the array of memory regions to hmac
> - * @niov: the length of @iov
> - * @digest: pointer to hold output hmac
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory regions
> - * present in @iov. The @digest pointer will be
> - * filled with the printable hex digest of the computed
> - * hmac, which will be terminated by '\0'. The
> - * memory pointer in @digest must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns:
> - *  0 on success, -1 on error
> - */
> -int qcrypto_hmac_digestv(QCryptoHmac *hmac,
> -                         const struct iovec *iov,
> -                         size_t niov,
> -                         char **digest,
> -                         Error **errp);
> -
> -/**
> - * qcrypto_hmac_digest:
> - * @hmac: the hmac object
> - * @buf: the memory region to hmac
> - * @len: the length of @buf
> - * @digest: pointer to hold output hmac
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory region
> - * @buf of length @len. The @digest pointer will be
> - * filled with the printable hex digest of the computed
> - * hmac, which will be terminated by '\0'. The
> - * memory pointer in @digest must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns: 0 on success, -1 on error
> - */
> -int qcrypto_hmac_digest(QCryptoHmac *hmac,
> -                        const char *buf,
> -                        size_t len,
> -                        char **digest,
> -                        Error **errp);
> -
> -#endif
> diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
> new file mode 100644
> index 0000000..0d3acd7
> --- /dev/null
> +++ b/include/crypto/hmac.h
> @@ -0,0 +1,166 @@
> +/*
> + * QEMU Crypto hmac algorithms
> + *
> + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + *
> + */
> +
> +#ifndef QCRYPTO_HMAC_H
> +#define QCRYPTO_HMAC_H
> +
> +#include "qapi-types.h"
> +
> +typedef struct QCryptoHmac QCryptoHmac;
> +struct QCryptoHmac {
> +    QCryptoHashAlgorithm alg;
> +    void *opaque;
> +};
> +
> +/**
> + * qcrypto_hmac_supports:
> + * @alg: the hmac algorithm
> + *
> + * Determine if @alg hmac algorithm is supported by
> + * the current configured build
> + *
> + * Returns:
> + *  true if the algorithm is supported, false otherwise
> + */
> +bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg);
> +
> +/**
> + * qcrypto_hmac_new:
> + * @alg: the hmac algorithm
> + * @key: the key bytes
> + * @nkey: the length of @key
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Creates a new hmac object with the algorithm @alg
> + *
> + * The @key parameter provides the bytes representing
> + * the secret key to use. The @nkey parameter specifies
> + * the length of @key in bytes
> + *
> + * Note: must use qcrypto_hmac_free() to release the
> + * returned hmac object when no longer required
> + *
> + * Returns:
> + *  a new hmac object, or NULL on error
> + */
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> +                              const uint8_t *key, size_t nkey,
> +                              Error **errp);
> +
> +/**
> + * qcrypto_hmac_free:
> + * @hmac: the hmac object
> + *
> + * Release the memory associated with @hmac that was
> + * previously allocated by qcrypto_hmac_new()
> + */
> +void qcrypto_hmac_free(QCryptoHmac *hmac);
> +
> +/**
> + * qcrypto_hmac_bytesv:
> + * @hmac: the hmac object
> + * @iov: the array of memory regions to hmac
> + * @niov: the length of @iov
> + * @result: pointer to hold output hmac
> + * @resultlen: pointer to hold length of @result
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory regions
> + * present in @iov. The @result pointer will be
> + * filled with raw bytes representing the computed
> + * hmac, which will have length @resultlen. The
> + * memory pointer in @result must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns:
> + *  0 on success, -1 on error
> + */
> +int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> +                        const struct iovec *iov,
> +                        size_t niov,
> +                        uint8_t **result,
> +                        size_t *resultlen,
> +                        Error **errp);
> +
> +/**
> + * qcrypto_hmac_bytes:
> + * @hmac: the hmac object
> + * @buf: the memory region to hmac
> + * @len: the length of @buf
> + * @result: pointer to hold output hmac
> + * @resultlen: pointer to hold length of @result
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory region
> + * @buf of length @len. The @result pointer will be
> + * filled with raw bytes representing the computed
> + * hmac, which will have length @resultlen. The
> + * memory pointer in @result must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns:
> + *  0 on success, -1 on error
> + */
> +int qcrypto_hmac_bytes(QCryptoHmac *hmac,
> +                       const char *buf,
> +                       size_t len,
> +                       uint8_t **result,
> +                       size_t *resultlen,
> +                       Error **errp);
> +
> +/**
> + * qcrypto_hmac_digestv:
> + * @hmac: the hmac object
> + * @iov: the array of memory regions to hmac
> + * @niov: the length of @iov
> + * @digest: pointer to hold output hmac
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory regions
> + * present in @iov. The @digest pointer will be
> + * filled with the printable hex digest of the computed
> + * hmac, which will be terminated by '\0'. The
> + * memory pointer in @digest must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns:
> + *  0 on success, -1 on error
> + */
> +int qcrypto_hmac_digestv(QCryptoHmac *hmac,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         char **digest,
> +                         Error **errp);
> +
> +/**
> + * qcrypto_hmac_digest:
> + * @hmac: the hmac object
> + * @buf: the memory region to hmac
> + * @len: the length of @buf
> + * @digest: pointer to hold output hmac
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory region
> + * @buf of length @len. The @digest pointer will be
> + * filled with the printable hex digest of the computed
> + * hmac, which will be terminated by '\0'. The
> + * memory pointer in @digest must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hmac_digest(QCryptoHmac *hmac,
> +                        const char *buf,
> +                        size_t len,
> +                        char **digest,
> +                        Error **errp);
> +
> +#endif
> --
> 1.8.3.1
>=20
