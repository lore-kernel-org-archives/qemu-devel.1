Received: from eggs.gnu.org ([2001:4830:134:3::10]:38723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dbCQn-0002H0-9z
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dbCQm-0002Qx-JU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:04:21 -0400
Date: Fri, 28 Jul 2017 17:04:14 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170728210414.GD5109@localhost.localdomain>
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728131452.15316-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/7] qemu-iotests/141: Fix image
 cleanup
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

On Fri, Jul 28, 2017 at 03:14:48PM +0200, Kevin Wolf wrote:
> qemu-iotests 141 attempted to use brace expansion to remove all images
> with a single command. However, for this to work, the braces shouldn't
> be quoted.
> 
> With this fix, the tests correctly cleans up its scratch images.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/141 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
> index 40a3405968..2f9d7b9bc2 100755
> --- a/tests/qemu-iotests/141
> +++ b/tests/qemu-iotests/141
> @@ -31,7 +31,7 @@ _cleanup()
>  {
>      _cleanup_qemu
>      _cleanup_test_img
> -    rm -f "$TEST_DIR/{b,m,o}.$IMGFMT"
> +    rm -f "$TEST_DIR"/{b,m,o}.$IMGFMT
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
