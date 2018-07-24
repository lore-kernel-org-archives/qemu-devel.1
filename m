Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhz6x-0001i2-1y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhz6s-0006gK-16
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:20:26 -0400
References: <20180724121753.5753-1-lbloch@janustech.com>
	<d0f7f0f9-93da-6e97-e87b-886f9a77f324@redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <1257ebd3-33d2-97d3-7a7d-1f948aacbbf0@janustech.com>
Date: Tue, 24 Jul 2018 18:19:37 +0300
In-Reply-To: <d0f7f0f9-93da-6e97-e87b-886f9a77f324@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] Introduction of l2-cache-full option
 for qcow2 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

   On 07/24/2018 05:49 PM, Eric Blake wrote:

     On 07/24/2018 07:17 AM, Leonid Bloch wrote:

     This series introduces an option to calculate and allocate
     automatically enough qcow2 L2 cache to cover the entire image.
     Using cache that covers the entire image can benefit performance,
     while having only a small memory overhead (just 1 MB for every 8 GB
     of virtual image size with the default cluster size).

     Is this still needed after Berto's work on commit 603790e and
     related, that maximizes the l2 cache by minimizing the refcount
     cache?

   Yes. In the commits you refer to, the L2 cache was set to cover all the
   image size only in the case that the combined cache size is set, and is
   larger than max_l2_cache+min_refcount_cache. This series adds an option
   to set the L2 cache to cover the entire image without the need to
   calculate the required size externally, and without dependency on the
   combined cache size setting.
