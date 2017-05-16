Received: from eggs.gnu.org ([2001:4830:134:3::10]:38013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dAjCe-0006IC-3y
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dAjCd-0007E6-E0
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:36:20 -0400
Date: Tue, 16 May 2017 16:43:28 -0400
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170516204327.GB28520@localhost.localdomain>
References: <1494961859-14833-1-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494961859-14833-1-git-send-email-sbates@raithlin.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Add support for Controller Memory
 Buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sbates@raithlin.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Tue, May 16, 2017 at 01:10:59PM -0600, sbates@raithlin.com wrote:
> From: Stephen Bates <sbates@raithlin.com>
> 
> Implement NVMe Controller Memory Buffers (CMBs) which were added in
> version 1.2 of the NVMe Specification. This patch adds an optional
> argument (cmb_size_mb) which indicates the size of the CMB (in
> MB). Currently only the Submission Queue Support (SQS) is enabled
> which aligns with the current Linux driver for NVMe.
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>

Awesome, this looks great!

Acked-by: Keith Busch <keith.busch@intel.com>
