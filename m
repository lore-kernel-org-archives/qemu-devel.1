Received: from eggs.gnu.org ([2001:4830:134:3::10]:39879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3MhK-00060e-69
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3MhF-0003g5-VX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3MhF-0003f5-QF
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:09:29 -0400
Date: Wed, 26 Apr 2017 14:09:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426130925.GW18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493158501-22284-1-git-send-email-gm.ijewski@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493158501-22284-1-git-send-email-gm.ijewski@web.de>
Subject: Re: [Qemu-devel] [PATCH v5] crypto: qcrypto_random_bytes() now
 works on windows w/o any other crypto libs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Martin Ijewski <gm.ijewski@web.de>
Cc: qemu-devel@nongnu.org

On Wed, Apr 26, 2017 at 12:15:01AM +0200, Geert Martin Ijewski wrote:
> If no crypto library is included in the build, QEMU uses
> qcrypto_random_bytes() to generate random data. That function tried to open
> /dev/urandom or /dev/random and if opening both files failed it errored out.
> 
> Those files obviously do not exist on windows, so there the code uses
> CryptGenRandom().
> 
> Furthermore there was some refactoring and a new function
> qcrypto_random_init() was introduced. If a proper crypto library (gnutls or
> libgcrypt) is included in the build, this function does nothing. If neither
> is included it initializes the (platform specific) handles that are used by
> qcrypto_random_bytes().
> Either:
> * a handle to /dev/urandom | /dev/random on unix like systems
> * a handle to a cryptographic service provider on windows
> 
> Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>
> ---
>  crypto/init.c            |  6 ++++++
>  crypto/random-gcrypt.c   |  2 ++
>  crypto/random-gnutls.c   |  3 +++
>  crypto/random-platform.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  include/crypto/random.h  |  9 +++++++++
>  5 files changed, 57 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

I'll add this to my queue now.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
