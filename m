Received: from eggs.gnu.org ([2001:4830:134:3::10]:34490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqfCi-0004vT-0b
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqfCg-0007xM-S3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:22:00 -0500
Date: Tue, 27 Feb 2018 14:21:31 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180227132131.fipafmnb56a7fj76@kamzik.brq.redhat.com>
References: <000e01d3afad$b9a13830$2ce3a890$@codeaurora.org>
	<20180227104708.GA11391@cbox>
	<ac329e1b1f5265a805916ab4f8708f9d@codeaurora.org>
	<20180227124604.GA2373@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227124604.GA2373@cbox>
Subject: Re: [Qemu-devel] VCPU hotplug on KVM/ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <cdall@kernel.org>
Cc: bthakur@codeaurora.org, Christoffer Dall <cdall@cs.columbia.edu>, Christoffer Dall <christofferdall@christofferdall.dk>, kvmarm@lists.cs.columbia.edu, imammedo@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On Tue, Feb 27, 2018 at 01:46:04PM +0100, Christoffer Dall wrote:
> On Tue, Feb 27, 2018 at 05:34:28PM +0530, bthakur@codeaurora.org wrote:
> > Hi Christoffer,
> > 
> > Thanks for your reply.
> > 
> > On 2018-02-27 16:17, Christoffer Dall wrote:
> > >Hi Bhupinder,
> > >
> > >On Tue, Feb 27, 2018 at 03:01:17PM +0530, bthakur@codeaurora.org wrote:
> > >>I hope it is the right forum to post my query.
> > >>
> > >>
> > >>
> > >>I am currently looking at the possibility of adding a new VCPU to a
> > >>running
> > >>guest VM in KVM/ARM. I see that currently, it is not allowed to add a
> > >>new
> > >>VCPU to a guest VM, if it is already initialized. The first check in
> > >>kvm_arch_vcpu_create() returns failure if it is already initialized.
> > >>
> > >
> > >This would require a major rework of a lot of logic surrounding the GIC
> > >and other parts of KVM initialization.
> > >
> > >>
> > >>
> > >>There was some work done in QEMU to add support for VCPU hotplug:
> > >>https://lists.gnu.org/archive/html/qemu-arm/2017-05/msg00404.html
> > >>
> > >>
> > >>
> > >>But I am looking at the KVM side for enabling adding a new VCPU. If you
> > >>can
> > >>point me to any relevant work/resources, which I can refer to then it
> > >>will
> > >>help me.
> > >>
> > >
> > >I don't have any specific pointers, but I was always told that the way
> > >we were going to do CPU hotplug would be to instantiate a large number
> > >of VCPUs, and hotplug would be equivalent to turning on a VCPU which was
> > >previously powered off.
> > >
> > >Is this not still a feasible solution?
> > It should be a feasible solution provided the guest VM is not able to
> > control the onlining/offlining of VCPUs. It should be controlled by the
> > Host.
> > 
> 
> KVM could simply refuse to turn on some of the CPUs unless given
> permission from host userspace.
> 
> > >
> > >How does VCPU hotplug work on x86?
> > On x86, you can add a vcpu through libvirt setvcpu command and it shows up
> > in the guest VM as a new CPU if you do lscpu.
> > 
> 
> Sure, but what is the mechanism, does x86 qemu actually call
> KVM_CREATE_VCPU, or is this also a question of turning on already
> created vcpus ?
>

CC'ing Igor and qemu-devel

drew
