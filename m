Received: from eggs.gnu.org ([2001:4830:134:3::10]:48910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi086-0004bN-7D
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi085-0006Id-71
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:25:42 -0400
References: <20180724121753.5753-1-lbloch@janustech.com>
	<20180724121753.5753-3-lbloch@janustech.com>
	<f31f05de-08a5-b756-0e41-70bcd1812c58@redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <8636bd8a-6d37-e997-15f9-1b6e1a56b7d3@janustech.com>
Date: Tue, 24 Jul 2018 19:25:20 +0300
In-Reply-To: <f31f05de-08a5-b756-0e41-70bcd1812c58@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] [PATCH 2/4] docs: Fix an inaccuracy due to recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

   On 07/24/2018 06:20 PM, Eric Blake wrote:

     On 07/24/2018 07:17 AM, Leonid Bloch wrote:

     Signed-off-by: Leonid Bloch [1]<lbloch@janustech.com>
     ---
       docs/qcow2-cache.txt | 6 +++---
       1 file changed, 3 insertions(+), 3 deletions(-)
     diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
     index 8a09a5cc5f..a0a1267482 100644
     --- a/docs/qcow2-cache.txt
     +++ b/docs/qcow2-cache.txt
     @@ -97,9 +97,9 @@ need:
          l2_cache_size = disk_size_GB * 131072
          refcount_cache_size = disk_size_GB * 32768
       -QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
     -cache of 256KB (262144 bytes), so using the formulas we've just
     seen
     -we have
     +QEMU has a default L2 cache of 1MB (1048576 bytes) or 8 clusters
     (whichever
     +is larger) and a refcount cache of 256KB (262144 bytes), so using
     the

     Looks suspicious; isn't the refcount cache size also dependent on
     the cluster size?

   Yes, it's 4*cluster_size. But I realize now that the text here speaks
   about the default sizes, which means with with 64KB clusters. So this
   fix is not necessary. Will drop this patch.

     +formulas we've just seen we have (assuming the L2 cache is 1MB):
            1048576 / 131072 = 8 GB of virtual disk covered by that cache
           262144 /  32768 = 8 GB

References

   1. mailto:lbloch@janustech.com
