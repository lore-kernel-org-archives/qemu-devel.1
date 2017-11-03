Received: from eggs.gnu.org ([2001:4830:134:3::10]:54062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAbhj-00088g-Av
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAbhg-0007v8-1h
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:08:11 -0400
Date: Fri, 3 Nov 2017 13:08:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171103130803.GI20155@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509710092-31645-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1509710092-31645-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] tests: Run the luks tests in
 test-crypto-block only if encryption is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, Nov 03, 2017 at 12:54:52PM +0100, Thomas Huth wrote:
> The test-crypto-block currently fails if encryption has not been
> compiled into QEMU:
> 
> TEST: tests/test-crypto-block... (pid=22231)
>   /crypto/block/qcow:                                                  OK
>   /crypto/block/luks/default:
>   Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
> FAIL
> GTester: last random seed: R02Sbbb5b6f299c6727f41bb50ba4aa6ef5c
> (pid=22237)
>   /crypto/block/luks/aes-256-cbc-plain64:
>   Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
> FAIL
> GTester: last random seed: R02S3e27992a5ab4cc95e141c4ed3c7f0d2e
> (pid=22239)
>   /crypto/block/luks/aes-256-cbc-essiv:
>   Unexpected error in qcrypto_pbkdf2() at qemu/crypto/pbkdf-stub.c:41:
> FAIL
> GTester: last random seed: R02S51b52bb02a66c42d8b331fd305384f53
> (pid=22241)
> FAIL: tests/test-crypto-block
> 
> So run the luks test only if the required encryption support is available.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Added the check to TEST_LUKS in the .c file instead of disabling
>      test-crypto-block completely in the Makefile.include.
> 
>  tests/test-crypto-block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
