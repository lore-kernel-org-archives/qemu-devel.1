Received: from eggs.gnu.org ([2001:4830:134:3::10]:53319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRIvb-0001el-Jy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRIvY-0006GE-Er
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:26:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRIvY-0006G5-9S
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:26:56 -0500
Date: Wed, 11 Jan 2017 11:26:53 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170111132653.GB3315@thinpad.lan.raisama.net>
References: <20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<20170105121950.GP3315@thinpad.lan.raisama.net>
	<20170106103126.GA1575@amt.cnet>
	<20170108202851.GZ3315@thinpad.lan.raisama.net>
	<d9ff1970-7d2d-6a49-b93e-27fe2817f412@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ff1970-7d2d-6a49-b93e-27fe2817f412@redhat.com>
Subject: Re: [Qemu-devel] Exporting kvm_max_guest_tsc_khz to userspace (was
 Re: [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com

On Mon, Jan 09, 2017 at 03:58:11PM +0100, Paolo Bonzini wrote:
> 
> 
> On 08/01/2017 21:28, Eduardo Habkost wrote:
> >> Well just export KVM_GET_TSC_KHZ in a QMP command right? Its pretty
> >> easy.
> >>
> >> Let me know if you need any help coding or testing.
> > I just found out that KVM doesn't provide something that QEMU and
> > libvirt need: the value of kvm_max_guest_tsc_khz. Without it, we
> > have no way to know if a given VM is really migratable to a host.
> > 
> > Could we add a KVM_CAP_MAX_TSC_KHZ capability for that?
> 
> The ratio is really quite high, 256x the host frequency for AMD and
> 65536x for Intel.  Anything below 2^32 Hz (above that, there would
> probably be other failures) is safe.

2^32 Hz (~4.3 GHz) sounds like a limit likely to be hit by future
CPUs. Which kind of failures do you think we could see?

-- 
Eduardo
