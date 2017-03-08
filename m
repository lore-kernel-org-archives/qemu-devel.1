Received: from eggs.gnu.org ([2001:4830:134:3::10]:52489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clj7C-0007AZ-Si
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clj79-0005pX-NT
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clj79-0005pI-HZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:19 -0500
Date: Wed, 8 Mar 2017 18:27:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308212715.GQ4694@thinpad.lan.raisama.net>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
Subject: Re: [Qemu-devel] [RFC PATCH v4 00/20] x86: Secure Encrypted
 Virtualization (AMD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com

On Wed, Mar 08, 2017 at 03:51:07PM -0500, Brijesh Singh wrote:
> This RFC series provides support for AMD's new Secure Encrypted 
> Virtualization (SEV) feature. This RFC is based KVM RFC [1].
> 
> SEV is an extension to the AMD-V architecture which supports running
> multiple VMs under the control of a hypervisor. The SEV feature allows
> the memory contents of a virtual machine (VM) to be transparently encrypted
> with a key unique to the guest VM. The memory controller contains a
> high performance encryption engine which can be programmed with multiple
> keys for use by a different VMs in the system. The programming and
> management of these keys is handled by the AMD Secure Processor firmware
> which exposes a commands for these tasks.
> 
> The KVM RFC introduced a new ioctl (KVM_MEMORY_ENCRYPTION_OP) which can be
> used by qemu to issue the SEV commands to assist performing common hypervisor
> activities such as a launching, running, snapshooting, migration and debugging
> guests.
> 
> The following links provide additional details:
> 
> AMD Memory Encryption whitepaper:
>  
> http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
> 
> AMD64 Architecture Programmer's Manual:
>     http://support.amd.com/TechDocs/24593.pdf
>     SME is section 7.10
>     SEV is section 15.34

I am looking for detailed CPUID documentation, and latest version
of Volume 3 I can find
(http://support.amd.com/TechDocs/24594.pdf) is from June 2015 and
doesn't include CPUID Fn8000_001F.

Is there a public updated version of AMD64 Architecture
Programmer's Manual Volume 3 including SEV CPUID info?

> 
> Secure Encrypted Virutualization Key Management:
> http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
> 
> KVM Forum slides:
> http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf
> 
> KVM RFC link:
> 
> [1] http://marc.info/?l=linux-mm&m=148846752931115&w=2
> 
> Video of the KVM Forum Talk:
> https://www.youtube.com/watch?v=RcvQ1xN55Ew
> 
[...]

-- 
Eduardo
