Received: from eggs.gnu.org ([2001:4830:134:3::10]:46487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWlF6-000147-W7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWlF6-0003Wv-2w
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:50:44 -0500
Date: Tue, 11 Dec 2018 16:50:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211165033.GQ921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211164317.32893-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/8] qcow2: encryption threads
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

On Tue, Dec 11, 2018 at 07:43:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The series brings threads to qcow2 encryption/decryption path,
> like it is already done for compression.
> 
> v2: - multiple cipher inside QCryptoBlock instead of multiple
>       blocks inside qcow2, as suggested by Daniel, and it is
>       done in separate series
>     - use threaded encryption in do_perform_cow_encrypt() too
>     - some renaming and refactoring and simplifications
> (Sorry for not being very careful about change list, but v1 isn't
>  actually reviewed, as approach with multiple blocks was early
>  rejected by Denial)
> 
> The series now based on two queued for 4.0 series, which, in
> turn, may be applied in any order: "crypto threads" (Daniel's
> tree), and  "qcow2 decompress in threads", which is now in
> Kevin's block-next.

FYI I've pushed my crypto queue here for benefit of anyone
wishing to test this series

  https://github.com/berrange/qemu/tree/qcrypto-next


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
