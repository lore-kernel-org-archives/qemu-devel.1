Received: from eggs.gnu.org ([2001:4830:134:3::10]:49545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1er072-0007kT-4N
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1er06x-0001s6-0f
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:41:32 -0500
Date: Wed, 28 Feb 2018 12:40:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180228124058.6166d957.cohuck@redhat.com>
In-Reply-To: <bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On Wed, 28 Feb 2018 11:26:30 +0100
David Hildenbrand <david@redhat.com> wrote:

> Then I request the following change in KVM:
> 
> If KVM_S390_VM_CPU_FEAT_AP is enabled in KVM, ECA.28 is _always_ set
> (not just if an AP device is configured). This especially makes things a
> lot easier when it comes to handling hotplugged CPUs and avoiding race
> conditions when enabling these bits as mentioned in the KVM series.
> 
> KVM_S390_VM_CPU_FEAT_AP == AP instructions available for the guest
> (don't throw an operation exception).
> 
> So this feature then really is guest ABI. The instructions are
> available. If there is no device configured, bad luck.

Sounds sensible from my POV.
