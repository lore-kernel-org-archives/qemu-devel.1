Received: from eggs.gnu.org ([2001:4830:134:3::10]:42446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWJ3j-0006ez-BK
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 05:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWJ3f-0002e3-9k
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 05:45:07 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181207161351.4380-4-vsementsov@virtuozzo.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-4-vsementsov@virtuozzo.com>
Date: Mon, 10 Dec 2018 11:44:22 +0100
Message-ID: <w51d0q9lkzd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/5] crypto/block: rename
 qcrypto_block_*crypt_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Fri 07 Dec 2018 05:13:49 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Rename qcrypto_block_*crypt_helper to qcrypto_cipher_*crypt_helper, as

You forgot to update the new function names in the commit message.

> -int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
> -int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
> +int qcrypto_block_cipher_decrypt_helper(QCryptoCipher *cipher,
> +int qcrypto_block_cipher_encrypt_helper(QCryptoCipher *cipher,

Berto
