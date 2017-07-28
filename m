Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1db7Gl-0003x3-H5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1db7Gk-0002sY-Og
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:33:39 -0400
Date: Fri, 28 Jul 2017 11:33:29 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170728153329.GB5109@localhost.localdomain>
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728131452.15316-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/7] qemu-iotests: Remove
 blkdebug.conf after tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Fri, Jul 28, 2017 at 03:14:47PM +0200, Kevin Wolf wrote:
> qemu-iotests 074 and 179 left a blkdebug.conf behind the scratch
> directory. Make sure to clean up after completing the tests.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/074 | 1 +
>  tests/qemu-iotests/179 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
> index aba126cb69..b17866bd34 100755
> --- a/tests/qemu-iotests/074
> +++ b/tests/qemu-iotests/074
> @@ -32,6 +32,7 @@ _cleanup()
>      echo "Cleanup"
>      _cleanup_test_img
>      rm "${TEST_IMG2}"
> +    rm -f "$TEST_DIR/blkdebug.conf"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
> index 7bc8db8fe0..115944a753 100755
> --- a/tests/qemu-iotests/179
> +++ b/tests/qemu-iotests/179
> @@ -30,6 +30,7 @@ status=1	# failure is the default!
>  _cleanup()
>  {
>  	_cleanup_test_img
> +    rm -f "$TEST_DIR/blkdebug.conf"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
