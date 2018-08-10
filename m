Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1foBKc-0002io-3Z
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1foBKb-00076Y-9x
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:36:10 -0400
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e695078a-90e5-2d96-924d-b85cd8fba29e@redhat.com>
Date: Fri, 10 Aug 2018 12:36:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180810162658.6562-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-iotests: Test commit with
 top-node/base-node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 08/10/2018 11:26 AM, Kevin Wolf wrote:
> This adds some tests for block-commit with the new options top-node and
> base-node (taking node names) instead of top and base (taking file
> names).

May need a rewrite if you like my idea of "by-node":true.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/040     | 52 ++++++++++++++++++++++++++++++++++++++++++++--
>   tests/qemu-iotests/040.out |  4 ++--
>   2 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 1beb5e6dab..1cb1ceeb33 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -57,9 +57,12 @@ class ImageCommitTestCase(iotests.QMPTestCase):
>           self.assert_no_active_block_jobs()
>           self.vm.shutdown()
>   
> -    def run_commit_test(self, top, base, need_ready=False):
> +    def run_commit_test(self, top, base, need_ready=False, node_names=False):

Especially since you've already picked that style of signature here :)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
