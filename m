Received: from eggs.gnu.org ([2001:4830:134:3::10]:53557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dN41o-0005Cx-Ud
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dN41n-00024m-Tt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:16:08 -0400
Date: Mon, 19 Jun 2017 17:24:35 -0400
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170619212435.GB22260@localhost.localdomain>
References: <1497348515-6391-1-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497348515-6391-1-git-send-email-sbates@raithlin.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Add support for Read Data and Write
 Data in CMBs.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sbates@raithlin.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, logang@deltatee.com, kwolf@redhat.com, mreitz@redhat.com

On Tue, Jun 13, 2017 at 04:08:35AM -0600, sbates@raithlin.com wrote:
> From: Stephen Bates <sbates@raithlin.com>
> 
> Add the ability for the NVMe model to support both the RDS and WDS
> modes in the Controller Memory Buffer.
> 
> Although not currently supported in the upstreamed Linux kernel a fork
> with support exists [1] and user-space test programs that build on
> this also exist [2].
> 
> Useful for testing CMB functionality in preperation for real CMB
> enabled NVMe devices (coming soon).
> 
> [1] https://github.com/sbates130272/linux-p2pmem
> [2] https://github.com/sbates130272/p2pmem-test
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

This looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
