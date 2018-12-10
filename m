Received: from eggs.gnu.org ([2001:4830:134:3::10]:35296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWLVh-0002FK-QS
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWLVh-0005GO-1j
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:22:09 -0500
Date: Mon, 10 Dec 2018 13:21:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181210132156.GG20272@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-4-vsementsov@virtuozzo.com>
	<w51d0q9lkzd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51d0q9lkzd.fsf@maestria.local.igalia.com>
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
To: Alberto Garcia <berto@igalia.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Mon, Dec 10, 2018 at 11:44:22AM +0100, Alberto Garcia wrote:
> On Fri 07 Dec 2018 05:13:49 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> > Rename qcrypto_block_*crypt_helper to qcrypto_cipher_*crypt_helper, as
> 
> You forgot to update the new function names in the commit message.
> 
> > -int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
> > -int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
> > +int qcrypto_block_cipher_decrypt_helper(QCryptoCipher *cipher,
> > +int qcrypto_block_cipher_encrypt_helper(QCryptoCipher *cipher,

I'll take care of that when queuing these patches


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
