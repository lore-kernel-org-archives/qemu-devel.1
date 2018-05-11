Received: from eggs.gnu.org ([2001:4830:134:3::10]:60173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fH9DC-0003ro-5L
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fH9D9-0006O0-3r
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fH9D8-0006Nj-Tx
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:39:55 -0400
Date: Fri, 11 May 2018 11:33:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180511143300.GL25013@localhost.localdomain>
References: <1525854989-14165-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525854989-14165-1-git-send-email-jingqi.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/7] numa: Classify the numa nodes as
 memory initiators and memory targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On Wed, May 09, 2018 at 04:36:29PM +0800, Liu Jingqi wrote:
> An initiator proximity domain (memory initiator) is any device
> such as a CPU or a separate memory I/O device that can initiate
> a memory request. A target proximity domain (memory target)
> is a CPU-accessible physical address range.
> 
[...]
> +    if (node->cpus) {
> +        initiator_pxm[num_initiator++] = nodenr;
> +    }
[...]
> +        target_pxm[num_target++] = nodenr;

I suggest NumaNode::is_initiator and NumaNode::is_target boolean
fields instead of a separate global table.

Or numa.c could simply provide
  bool numa_node_is_initiator(int node) and
  bool numa_node_is_target(int node)
helpers.

-- 
Eduardo
