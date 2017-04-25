Received: from eggs.gnu.org ([2001:4830:134:3::10]:60788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d35e9-0006RQ-HJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d35e6-0007Ke-W3
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d35e6-0007KB-Q9
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:57:06 -0400
Date: Tue, 25 Apr 2017 19:57:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170425185700.GA8899@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <e3fd9c8b-8976-eb31-4092-887e94f4a5ae@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3fd9c8b-8976-eb31-4092-887e94f4a5ae@web.de>
Subject: Re: [Qemu-devel] [PATCH v3] crypto: qcrypto_random_bytes() now
 works on windows w/o any other crypto lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Martin Ijewski <gm.ijewski@web.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com

On Tue, Apr 25, 2017 at 07:28:07PM +0200, Geert Martin Ijewski wrote:
> If no crypto library is included in the build, QEMU uses
> qcrypto_random_bytes() to generate random data. That function tried to open
> /dev/urandom or /dev/random and if openeing neither file worked it errored
> out.
> 
> Those files obviously do not exist on windows, so there the code uses
> CryptGenRandom().
> 
> Furthermore there was some refactoring and a new function
> qcrypto_random_init() was introduced. If a proper crypto library (gnutls or
> libgcrypt) is included in the build, this function does nothing. If neither
> is included it initalizes the (platform specific) handles that are used by
> qcrypto_random_bytes().
> Either:
> * a handle to /dev/urandom | /dev/random on unix like systems
> * a handle to a cryptographic service provider on windows
> 
> Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


I'll add this to my queue unless someone raises further comments.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
