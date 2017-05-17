Received: from eggs.gnu.org ([2001:4830:134:3::10]:33600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dB0oQ-0004kg-Hm
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dB0oN-0000k4-BY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:24:30 -0400
From: Laurent Vivier <lvivier@redhat.com>
References: <149503190026.11264.1637374942003022823.stgit@bahia.lan>
	<b1400dd4-ee4a-fa5e-a7b3-d2c5185d58ca@redhat.com>
Message-ID: <a464cc50-650a-9aa9-ffe6-aa96582b1e3e@redhat.com>
Date: Wed, 17 May 2017 17:24:23 +0200
MIME-Version: 1.0
In-Reply-To: <b1400dd4-ee4a-fa5e-a7b3-d2c5185d58ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] xics_kvm: cache already enabled vCPU ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 17/05/2017 17:18, Laurent Vivier wrote:
> On 17/05/2017 16:38, Greg Kurz wrote:
>> Since commit a45863bda90d ("xics_kvm: Don't enable KVM_CAP_IRQ_XICS if
>> already enabled"), we were able to re-hotplug a vCPU that had been hot-
>> unplugged ealier, thanks to a boolean flag in ICPState that we set when
>> enabling KVM_CAP_IRQ_XICS.
>>
>> This could work because the lifecycle of all ICPState objects was the
>> same as the machine. Commit 5bc8d26de20c ("spapr: allocate the ICPState
>> object from under sPAPRCPUCore") broke this assumption and now we always
>> pass a freshly allocated ICPState object (ie, with the flag unset) to
>> icp_kvm_cpu_setup().
>>
>> This cause re-hotplug to fail with:
>>
>> Unable to connect CPU8 to kernel XICS: Device or resource busy
>>
>> Let's fix this by caching all the vCPU ids for which KVM_CAP_IRQ_XICS was
>> enabled. This also drops the now useless boolean flag from ICPState.
>>
>> Reported-by: Laurent Vivier <lvivier@redhat.com>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> Tested-by: Laurent Vivier <lvivier@redhat.com>

and:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
