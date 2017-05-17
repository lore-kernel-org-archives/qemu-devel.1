Received: from eggs.gnu.org ([2001:4830:134:3::10]:43670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dAtYX-0000mm-RW
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dAtYX-00018s-27
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:39:37 -0400
Date: Wed, 17 May 2017 09:39:25 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170517073925.nd5cledugl2bjsk5@eukaryote>
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

Thanks.

FWIW:

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
