Received: from eggs.gnu.org ([2001:4830:134:3::10]:53451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNgw-00023K-Dw
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNgs-0004Yk-NE
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:18:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGNgs-0004Yg-E9
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:18:38 -0500
Date: Mon, 12 Dec 2016 10:18:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212101832.GC15611@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
	<1481530092-20240-3-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481530092-20240-3-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 2/7] crypto: add HMAC algorithms
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: eblake@redhat.com, armbru@redhat.com, stefanha@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Dec 12, 2016 at 04:08:07PM +0800, Longpeng(Mike) wrote:
> This patch introduce HMAC algorithms framework.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/Makefile.objs |   4 ++
>  crypto/hmac-gcrypt.c |  44 ++++++++++++++
>  crypto/hmac-glib.c   |  44 ++++++++++++++
>  crypto/hmac-nettle.c |  44 ++++++++++++++
>  crypto/hmac.c        |  72 ++++++++++++++++++++++
>  crypto/hmac.h        | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 374 insertions(+)
>  create mode 100644 crypto/hmac-gcrypt.c
>  create mode 100644 crypto/hmac-glib.c
>  create mode 100644 crypto/hmac-nettle.c
>  create mode 100644 crypto/hmac.c
>  create mode 100644 crypto/hmac.h
> 

> diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
> new file mode 100644
> index 0000000..26f42bc
> --- /dev/null
> +++ b/crypto/hmac-gcrypt.c
> @@ -0,0 +1,44 @@
> +/*
> + * QEMU Crypto hmac algorithms (based on libgcrypt)
> + *
> + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Longpeng(Mike) <longpeng2@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "crypto/hmac.h"
> +
> +bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
> +{
> +    return false;
> +}
> +
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHmacAlgorithm alg,
> +                                  const uint8_t *key, size_t nkey,
> +                                  Error **errp)

Nitpick, can you fix alignment of the lines wrt to the "("

> +{
> +    return NULL;
> +}
> +
> +void qcrypto_hmac_free(QCryptoHmac *hmac)
> +{
> +    return;
> +}
> +
> +int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> +                        const struct iovec *iov,
> +                        size_t niov,
> +                        uint8_t **result,
> +                        size_t *resultlen,
> +                        Error **errp)
> +{
> +    return -1;
> +}
> diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
> new file mode 100644
> index 0000000..42f63c6
> --- /dev/null
> +++ b/crypto/hmac-glib.c
> @@ -0,0 +1,44 @@
> +/*
> + * QEMU Crypto hmac algorithms (based on glib)
> + *
> + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Longpeng(Mike) <longpeng2@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "crypto/hmac.h"
> +
> +bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
> +{
> +    return false;
> +}
> +
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHmacAlgorithm alg,
> +                                  const uint8_t *key, size_t nkey,
> +                                  Error **errp)

Nitpick, can you fix alignment of the lines wrt to the "("


> +{
> +    return NULL;
> +}
> +
> +void qcrypto_hmac_free(QCryptoHmac *hmac)
> +{
> +    return;
> +}
> +
> +int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> +                        const struct iovec *iov,
> +                        size_t niov,
> +                        uint8_t **result,
> +                        size_t *resultlen,
> +                        Error **errp)
> +{
> +    return -1;
> +}
> diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
> new file mode 100644
> index 0000000..7a9cd2e
> --- /dev/null
> +++ b/crypto/hmac-nettle.c
> @@ -0,0 +1,44 @@
> +/*
> + * QEMU Crypto hmac algorithms (based on nettle)
> + *
> + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Longpeng(Mike) <longpeng2@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "crypto/hmac.h"
> +
> +bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
> +{
> +    return false;
> +}
> +
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHmacAlgorithm alg,
> +                                  const uint8_t *key, size_t nkey,
> +                                  Error **errp)

Nitpick, can you fix alignment of the lines wrt to the "("

> +{
> +    return NULL;
> +}
> +
> +void qcrypto_hmac_free(QCryptoHmac *hmac)
> +{
> +    return;
> +}
> +
> +int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> +                        const struct iovec *iov,
> +                        size_t niov,
> +                        uint8_t **result,
> +                        size_t *resultlen,
> +                        Error **errp)
> +{
> +    return -1;
> +}
> diff --git a/crypto/hmac.c b/crypto/hmac.c
> new file mode 100644
> index 0000000..5750405
> --- /dev/null
> +++ b/crypto/hmac.c
> @@ -0,0 +1,72 @@
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
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "crypto/hmac.h"
> +
> +static const char hex[] = "0123456789abcdef";
> +
> +int qcrypto_hmac_bytes(QCryptoHmac *hmac,
> +                       const char *buf,
> +                       size_t len,
> +                       uint8_t **result,
> +                       size_t *resultlen,
> +                       Error **errp)
> +{
> +    struct iovec iov = {
> +            .iov_base = (char *)buf,
> +            .iov_len = len
> +    };
> +
> +    return qcrypto_hmac_bytesv(hmac, &iov, 1, result, resultlen, errp);
> +}
> +
> +int qcrypto_hmac_digestv(QCryptoHmac *hmac,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         char **digest,
> +                         Error **errp)
> +{
> +    uint8_t *result = NULL;
> +    size_t resultlen = 0;
> +    size_t i;
> +
> +    if (qcrypto_hmac_bytesv(hmac, iov, niov, &result, &resultlen, errp) < 0) {
> +        return -1;
> +    }
> +
> +    *digest = g_new0(char, (resultlen * 2) + 1);
> +
> +    for (i = 0 ; i < resultlen ; i++) {
> +        (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
> +        (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
> +    }
> +
> +    (*digest)[resultlen * 2] = '\0';
> +
> +    g_free(result);
> +    return 0;
> +}
> +
> +int qcrypto_hmac_digest(QCryptoHmac *hmac,
> +                        const char *buf,
> +                        size_t len,
> +                        char **digest,
> +                        Error **errp)
> +{
> +    struct iovec iov = {
> +            .iov_base = (char *)buf,
> +            .iov_len = len
> +    };
> +
> +    return qcrypto_hmac_digestv(hmac, &iov, 1, digest, errp);
> +}
> diff --git a/crypto/hmac.h b/crypto/hmac.h
> new file mode 100644
> index 0000000..88b4d05
> --- /dev/null
> +++ b/crypto/hmac.h
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
> +    QCryptoHmacAlgorithm alg;
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
> +bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg);
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
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHmacAlgorithm alg,
> +                        const uint8_t *key, size_t nkey,
> +                        Error **errp);

Nitpick, can you fix alignment of the lines wrt to the "("

Also change it to use QCryptoHashAlgorithm in first parameter.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
