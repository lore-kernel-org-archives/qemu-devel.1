Received: from eggs.gnu.org ([2001:4830:134:3::10]:40052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWNLa-0002hs-OG
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWNLX-0004V1-0h
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:19:50 -0500
Date: Mon, 10 Dec 2018 15:19:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181210151918.GO20272@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207161351.4380-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] crypto threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, den@openvz.org

On Fri, Dec 07, 2018 at 07:13:46PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> v3:
> 01: add r-b by Daniel and Alberto
> 02: Alberto r-b
>     encrypt->encdec for generic
> 03: qcrypto_cipher_*crypt_helper->
>     qcrypto_block_cipher_*crypt_helper
> 04: rebased on previous renamings
>     Daniel r-b
> 05: use size_t
>     improve comment about n_threads
>     don't use ret in qcrypto_block_luks_create
>     do qemu_mutex_init at the end of open/create
>     do qemu_mutex_destroy in free
>     fix comment for qcrypto_block_get_cipher
> 
> v2:
> 05: fix compilation of test-crypto-block (I am ashamed:(
>     and change QCryptoBlock interface to be a bit more safe.
> 
> These series are preliminary step before moving encryption code in
> qcow2 to the threads. The first attempt of doing it is on list
> ([PATCH 00/11] qcow2: encryption threads : 
>  https://lists.gnu.org/archive/html/qemu-block/2018-11/msg00729.html)
> But it's approach with multiplying the whole QCryptoBlock per thread
> was rejected. So, here is a solution to maintain multitasking inside
> QCryptoBlock.

Thanks, I've queued this series for when 4.0 opens up.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
