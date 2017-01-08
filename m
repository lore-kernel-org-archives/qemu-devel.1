Received: from eggs.gnu.org ([2001:4830:134:3::10]:35180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQK5L-0004K3-He
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 15:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQK5I-0004zu-Ex
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 15:28:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQK5I-0004zg-9F
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 15:28:56 -0500
Date: Sun, 8 Jan 2017 18:28:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170108202851.GZ3315@thinpad.lan.raisama.net>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<20170105121950.GP3315@thinpad.lan.raisama.net>
	<20170106103126.GA1575@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170106103126.GA1575@amt.cnet>
Subject: [Qemu-devel] Exporting kvm_max_guest_tsc_khz to userspace (was Re:
 [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com

On Fri, Jan 06, 2017 at 08:31:27AM -0200, Marcelo Tosatti wrote:
[...]
> > > 
> > > > Maybe your use case just needs a explicit "invtsc-migration=on"
> > > > command-line flag without a mechanism to abort migration on
> > > > mismatch? I can't tell.
> > > 
> > > Again, there is no special case.
> > > 
> > > > Note that even if we follow your suggestion and implement an
> > > > alternative version of patch 4/4 to cover your use case, I will
> > > > strongly recommend libvirt developers to support configuring TSC
> > > > frequency if they want to support invtsc + migration without
> > > > surprising/unpredictable restrictions on migratability.
> > > 
> > > Well, alright. If you make the TSC frequency of the host
> > > available to mgmt software as you describe, and write the steps mgmt
> > > software should take, i'm good.
> > 
> > I plan to. The problem is that the mechanism to query the host
> > frequency may be unavailable in the first version.
> 
> Well just export KVM_GET_TSC_KHZ in a QMP command right? Its pretty
> easy.
> 
> Let me know if you need any help coding or testing.

I just found out that KVM doesn't provide something that QEMU and
libvirt need: the value of kvm_max_guest_tsc_khz. Without it, we
have no way to know if a given VM is really migratable to a host.

Could we add a KVM_CAP_MAX_TSC_KHZ capability for that?

-- 
Eduardo
