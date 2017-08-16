Received: from eggs.gnu.org ([2001:4830:134:3::10]:41699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1di61q-0002E6-8G
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1di61p-0005ZJ-Cr
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:39:06 -0400
References: <20170808143416.3581-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4288ec4a-750f-62b2-174f-d255474d086d@redhat.com>
Date: Wed, 16 Aug 2017 17:38:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170808143416.3581-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] tests/multiboot: Fix
 whitespace failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

No replies that I can see, but merged as:

01a02ec4f6b6a12df7acfb6ad820b384b48cbf70 tests/multiboot: Fix whitespace
failure

Thanks

On 08/08/2017 10:34 AM, Eric Blake wrote:
> Commit b43671f8 accidentally broke run_test.sh within tests/multiboot;
> due to a subtle change in whitespace.
> 
> These two commands produce theh same output (at least, for sane $IFS
> of space-tab-newline):
> 
> echo -e "...$@..."
> echo -e "...$*..."
> 
> But that's only because echo inserts spaces between multiple arguments
> (the $@ case), while the $* form gives a single argument to echo with
> the spaces already present.
> 
> But when converting to printf %b, there are no automatic spaces between
> multiple arguments, so we HAVE to use $*.
> 
> It doesn't help that run_test.sh isn't part of 'make check'.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/multiboot/run_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
> index c8f3da8f37..0278148b43 100755
> --- a/tests/multiboot/run_test.sh
> +++ b/tests/multiboot/run_test.sh
> @@ -26,7 +26,7 @@ run_qemu() {
>      local kernel=$1
>      shift
> 
> -    printf %b "\n\n=== Running test case: $kernel $@ ===\n\n" >> test.log
> +    printf %b "\n\n=== Running test case: $kernel $* ===\n\n" >> test.log
> 
>      $QEMU \
>          -kernel $kernel \
> 
