Received: from eggs.gnu.org ([2001:4830:134:3::10]:45569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dT7tT-0008N9-TP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dT7tT-0006Dh-5E
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:36:35 -0400
Date: Thu, 6 Jul 2017 22:36:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170706143623.GA28118@lemon.lan>
References: <149934999661.27.13789728207994914021@f0098f8687cc>
	<1ff791c6-a914-2a26-e5d2-683cacc82b86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff791c6-a914-2a26-e5d2-683cacc82b86@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] block: Add VFIO based driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, keith.busch@intel.com, stefanha@redhat.com, krister@redhat.com

On Thu, 07/06 16:22, Paolo Bonzini wrote:
> 
> 
> On 06/07/2017 16:06, no-reply@patchew.org wrote:
> > ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> > #843: FILE: block/nvme.c:40:
> > +    volatile uint32_t *doorbell;
> > 
> > ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> > #869: FILE: block/nvme.c:66:
> > +typedef volatile struct {
> 
> Indeed volatile should not be necessary, since we use memory barriers
> appropriately.  But these are hardware registers (like, host hardware)
> so I guess it's okay for this special case.

I think I used it because we don't have ACCESS_ONCE (maybe we should?).

Fam
