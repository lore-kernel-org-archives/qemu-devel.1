Received: from eggs.gnu.org ([2001:4830:134:3::10]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSp2-0002Do-MF
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSp1-0001vp-Q8
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:24:12 -0400
References: <20180509154949.8206-1-mreitz@redhat.com>
	<20180509154949.8206-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9bbaffe-2543-929f-7ee2-c41704046416@redhat.com>
Date: Wed, 9 May 2018 12:24:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180509154949.8206-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Add test for rebasing with
 relative paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>

On 05/09/2018 10:49 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/024     | 82 ++++++++++++++++++++++++++++++++++++++++++++--
>   tests/qemu-iotests/024.out | 30 +++++++++++++++++
>   2 files changed, 109 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
> index e0d77ce2f5..4071ed6093 100755
> --- a/tests/qemu-iotests/024
> +++ b/tests/qemu-iotests/024
> @@ -29,9 +29,14 @@ status=1	# failure is the default!
>   
>   _cleanup()
>   {
> -	_cleanup_test_img
> -	rm -f "$TEST_DIR/t.$IMGFMT.base_old"
> -	rm -f "$TEST_DIR/t.$IMGFMT.base_new"
> +    _cleanup_test_img
> +    rm -f "$TEST_DIR/t.$IMGFMT.base_old"
> +    rm -f "$TEST_DIR/t.$IMGFMT.base_new"
> +
> +    rm -f "$TEST_DIR/subdir/t.$IMGFMT"
> +    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_old"
> +    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_new"
> +    rmdir "$TEST_DIR/subdir" 2> /dev/null

Any easier to just 'rm -rf "$TEST_DIR/subdir"' instead of calling out 
individual files?  And was Jeff ever going to finish the iotests 
cleanups that took care of cleanup globally by running tests in a 
per-test directory in preparation for running tests in parallel?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
