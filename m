Received: from eggs.gnu.org ([2001:4830:134:3::10]:34089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e20PF-00013S-Kt
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e20PB-00018t-Oa
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e20PB-00018a-IO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:41:29 -0400
Date: Tue, 10 Oct 2017 16:41:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010194117.GK3246@localhost.localdomain>
References: <20171006215244.27104-1-ehabkost@redhat.com>
	<765f7133-0ccc-2239-d49b-55d8b2a24cc7@redhat.com>
	<fddffbab-7aab-72b4-f42f-d18e94517350@redhat.com>
	<17ed046b-2c29-340b-9802-f43a709715e2@redhat.com>
	<20171010155003.GD3246@localhost.localdomain>
	<4b9e65ed-3636-bff4-3cca-52f6b80bca3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9e65ed-3636-bff4-3cca-52f6b80bca3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] x86: Rework KVM-defaults compat code,
 enable kvm_pv_unhalt by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Waiman Long <longman@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, libvir-list@redhat.com

On Tue, Oct 10, 2017 at 02:07:25PM -0400, Waiman Long wrote:
> On 10/10/2017 11:50 AM, Eduardo Habkost wrote:
> >> Yes.  Another possibility is to enable it when there is >1 NUMA node in
> >> the guest.  We generally don't do this kind of magic but higher layers
> >> (oVirt/OpenStack) do.
> > Can't the guest make this decision, instead of the host?
> 
> By guest, do you mean the guest OS itself or the admin of the guest VM?

It could be either.  But even if action is required from the
guest admin to get better performance in some cases, I'd argue
that the default behavior of a Linux guest shouldn't cause a
performance regression if the host stops hiding a feature in
CPUID.

> 
> I am thinking about maybe adding kernel boot command line option like
> "unfair_pvspinlock_cpu_threshold=4" which will instruct the OS to use
> unfair spinlock if the number of CPUs is 4 or less, for example. The
> default value of 0 will have the same behavior as it is today. Please
> let me know what you guys think about that.

If that's implemented, can't Linux choose a reasonable default
for unfair_pvspinlock_cpu_threshold that won't require the admin
to manually configure it on most cases?

-- 
Eduardo
