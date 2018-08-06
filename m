Received: from eggs.gnu.org ([2001:4830:134:3::10]:46587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fmnav-00082G-A1
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fmnaq-0006i9-Gl
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:03:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fmnaq-0006g3-A7
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:03:12 -0400
Date: Mon, 6 Aug 2018 19:03:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180806220307.GC23195@localhost.localdomain>
References: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
	<1531213054-63327-2-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531213054-63327-2-git-send-email-jingqi.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] x86/cpu: Enable UMONITOR/UMWAIT/TPAUSE
 cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jingqi Liu <jingqi.liu@intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, wei.w.wang@intel.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Jul 10, 2018 at 04:57:32PM +0800, Jingqi Liu wrote:
> UMONITOR, UMWAIT, and TPAUSE are a set of user wait instructions.
> 
> UMONITOR arms address monitoring hardware using an address. A store
> to an address within the specified address range triggers the
> monitoring hardware to wake up the processor waiting in umwait.
> 
> UMWAIT instructs the processor to enter an implementation-dependent
> optimized state while monitoring a range of addresses. The optimized
> state may be either a light-weight power/performance optimized state
> or an improved power/performance optimized state.
> 
> TPAUSE instructs the processor to enter an implementation-dependent
> optimized state c0.1 or c0.2 state and wake up when time-stamp counter
> reaches specified timeout.
> 
> The bit definition:
> CPUID.(EAX=7,ECX=0):ECX[bit 05] WAITPKG
> 
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>

Is it really OK to expose these features to the guest without
"-overcommit cpu-pm=on"?

Don't we need code to migrate IA32_UMWAIT_CONTROL?

(I don't see code to handle writes to IA32_UMWAIT_CONTROL on the
KVM patches, either.)

-- 
Eduardo
