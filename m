Received: from eggs.gnu.org ([2001:4830:134:3::10]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1faJtv-0000IX-Am
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1faJtu-0008Kc-GS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:55:19 -0400
Date: Tue, 3 Jul 2018 13:55:07 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180703115507.nqmyo7c5q5lrevgt@kamzik.brq.redhat.com>
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
	<1529500053-21704-6-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529500053-21704-6-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [RFC 5/6] hw/arm/virt: support kvm_type property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, suzuki.poulose@arm.com, dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au

On Wed, Jun 20, 2018 at 03:07:32PM +0200, Eric Auger wrote:
> The kvm-type property currently is used to pass
> a user parameter to KVM_CREATE_VM. This matches
> the way KVM/ARM expects to pass the max_vm_phys_shift
> parameter.
> 
> This patch adds the support or the kvm-type property in
> machvirt and also implements the machine class kvm_type()
> callback so that it either returns the kvm-type value
> provided by the user or returns the max_vm_phys_shift
> exposed by KVM.
> 
> for instance, the usespace can use the following option to
> instantiate a 42b IPA guest: -machine kvm-type=42

'kvm-type' is a very generic name. It looks like you're creating a KVM
VM of type 42 (which I assume is the ultimate KVM VM that answers the
meaning to Life, the Universe, and Everything), but it's not obvious
how it relates to physical address bits. Why not call this property
something like 'min_vm_phys_shift'? Notice the 'min' in the name,
because this is where the user is stating what the minimum number of
physical address bits required for the VM is. IIUC, if KVM supports
more, then it shouldn't be a problem.

Thanks,
drew
