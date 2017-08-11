Received: from eggs.gnu.org ([2001:4830:134:3::10]:49629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dg8TK-0000qo-5c
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dg8TH-000534-2C
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dg8TG-00051q-Rl
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:51:18 -0400
Date: Fri, 11 Aug 2017 08:51:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170811115114.GD3108@localhost.localdomain>
References: <1502337500-5718-1-git-send-email-tianyu.lan@intel.com>
	<20170810180838.GS2547@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170810180838.GS2547@char.us.oracle.com>
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

On Thu, Aug 10, 2017 at 02:08:38PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Aug 09, 2017 at 11:58:20PM -0400, Lan Tianyu wrote:
> > Intel Xeon phi chip will support 352 logical threads. For HPC
> > usage case, it will create a huge VM with vcpus number as same as host
> > cpus. This patch is to increase max vcpu number to 352.
> 
> There is this ioctl called KVM_CAP_MAX_VCPUS. Why not use that?
> 
> Oh wait, this is generic code. Perhaps there is a way to make
> this more abstract? Where this information is provided via
> an function to which various accelerators register?

We already check KVM_CAP_MAX_VCPUS, see kvm-all.c:kvm_init().
MachineClass::max_cpus is a limit defined at compile time, based
on the limitations of the existing QEMU machine/device code.

-- 
Eduardo
