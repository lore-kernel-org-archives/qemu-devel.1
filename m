Received: from eggs.gnu.org ([2001:4830:134:3::10]:38943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWLmf-0006gr-0m
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWLXj-0006F7-RD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:24:19 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181210132156.GG20272@redhat.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-4-vsementsov@virtuozzo.com>
	<w51d0q9lkzd.fsf@maestria.local.igalia.com>
	<20181210132156.GG20272@redhat.com>
Date: Mon, 10 Dec 2018 14:24:04 +0100
Message-ID: <w517eghldl7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Mon 10 Dec 2018 02:21:56 PM CET, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Dec 10, 2018 at 11:44:22AM +0100, Alberto Garcia wrote:
>> On Fri 07 Dec 2018 05:13:49 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>> > Rename qcrypto_block_*crypt_helper to qcrypto_cipher_*crypt_helper, as
>>=20
>> You forgot to update the new function names in the commit message.
>>=20
>> > -int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
>> > -int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
>> > +int qcrypto_block_cipher_decrypt_helper(QCryptoCipher *cipher,
>> > +int qcrypto_block_cipher_encrypt_helper(QCryptoCipher *cipher,
>
> I'll take care of that when queuing these patches

Ok then

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
