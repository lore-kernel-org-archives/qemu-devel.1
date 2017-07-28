Received: from eggs.gnu.org ([2001:4830:134:3::10]:52159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dbCtr-000281-5f
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dbCtq-0004IM-BN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:34:23 -0400
Date: Fri, 28 Jul 2017 17:34:13 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170728213413.GG5109@localhost.localdomain>
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728131452.15316-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/7] qemu-iotests/041: Fix leaked
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

On Fri, Jul 28, 2017 at 03:14:46PM +0200, Kevin Wolf wrote:
> qemu-iotests 041 left quorum_snapshot.img and target.img behind in the
> scratch directory. Make sure to clean up after completing the tests.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/041 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 4cda540735..a860a31e9a 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -418,6 +418,7 @@ new_state = "1"
>      def tearDown(self):
>          self.vm.shutdown()
>          os.remove(test_img)
> +        os.remove(target_img)
>          os.remove(backing_img)
>          os.remove(self.blkdebug_file)
>  
> @@ -568,6 +569,7 @@ new_state = "1"
>      def tearDown(self):
>          self.vm.shutdown()
>          os.remove(test_img)
> +        os.remove(target_img)
>          os.remove(backing_img)
>          os.remove(self.blkdebug_file)
>  
> @@ -821,7 +823,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
>  
>      def tearDown(self):
>          self.vm.shutdown()
> -        for i in self.IMAGES + [ quorum_repair_img ]:
> +        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file ]:
>              # Do a try/except because the test may have deleted some images
>              try:
>                  os.remove(i)
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
