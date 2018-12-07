Received: from eggs.gnu.org ([2001:4830:134:3::10]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVFOQ-0008SD-Mf
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVFOK-0002Ga-Uq
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:38:06 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181205144700.26563-3-vsementsov@virtuozzo.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-3-vsementsov@virtuozzo.com>
Date: Fri, 07 Dec 2018 13:37:55 +0100
Message-ID: <w51y391v7fg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/5] crypto/block: refactor
 qcrypto_block_*crypt_helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, berrange@redhat.com, mreitz@redhat.com

On Wed 05 Dec 2018 03:46:57 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> qcrypto_block_encrypt_helper and qcrypto_block_decrypt_helper are
> almost identical, let's reduce code duplication and simplify further
> improvements.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


> +static int do_qcrypto_block_encrypt(QCryptoCipher *cipher,

I also prefer encdec (which is the naming already used in crypto/xts.c),
but I'm also fine with crypt.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
