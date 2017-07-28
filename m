Received: from eggs.gnu.org ([2001:4830:134:3::10]:46668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1db7K9-00065z-Rk
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1db7K8-0006N9-VG
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:37:09 -0400
Date: Fri, 28 Jul 2017 11:37:00 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170728153700.GC5109@localhost.localdomain>
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728131452.15316-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/7] qemu-iotests/153: Fix leaked
 scratch images
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

On Fri, Jul 28, 2017 at 03:14:49PM +0200, Kevin Wolf wrote:
> qemu-iotests 153 left t.qcow2.c behind in the scratch directory. Make
> sure to clean it up after completing the tests.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/153 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> index 0b45d78ea3..fa25eb24bd 100755
> --- a/tests/qemu-iotests/153
> +++ b/tests/qemu-iotests/153
> @@ -35,6 +35,7 @@ _cleanup()
>      rm -f "${TEST_IMG}.convert"
>      rm -f "${TEST_IMG}.a"
>      rm -f "${TEST_IMG}.b"
> +    rm -f "${TEST_IMG}.c"
>      rm -f "${TEST_IMG}.lnk"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
