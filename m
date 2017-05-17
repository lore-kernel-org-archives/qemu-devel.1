Received: from eggs.gnu.org ([2001:4830:134:3::10]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAyyT-0000nP-JH
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAyyS-00008J-Pu
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:26:45 -0400
Date: Wed, 17 May 2017 09:26:37 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170517132637.GO19824@localhost.localdomain>
References: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Test streaming with missing
 job ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, berto@igalia.com, qemu-devel@nongnu.org

On Mon, May 15, 2017 at 02:39:40PM +0200, Kevin Wolf wrote:
> This adds a small test for the image streaming error path for failing
> block_job_create(), which would have found the null pointer dereference
> in commit a170a91f.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Jeff Cody <jcody@redhat.com>


>  tests/qemu-iotests/030     | 4 ++++
>  tests/qemu-iotests/030.out | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index e00c11b..feee861 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -147,6 +147,10 @@ class TestSingleDrive(iotests.QMPTestCase):
>          result = self.vm.qmp('block-stream', device='nonexistent')
>          self.assert_qmp(result, 'error/class', 'GenericError')
>  
> +    def test_job_id_missing(self):
> +        result = self.vm.qmp('block-stream', device='mid')
> +        self.assert_qmp(result, 'error/class', 'GenericError')
> +
>  
>  class TestParallelOps(iotests.QMPTestCase):
>      num_ops = 4 # Number of parallel block-stream operations
> diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
> index 84bfd63..391c857 100644
> --- a/tests/qemu-iotests/030.out
> +++ b/tests/qemu-iotests/030.out
> @@ -1,5 +1,5 @@
> -......................
> +.......................
>  ----------------------------------------------------------------------
> -Ran 22 tests
> +Ran 23 tests
>  
>  OK
> -- 
> 1.8.3.1
> 
> 
