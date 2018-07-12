Received: from eggs.gnu.org ([2001:4830:134:3::10]:43571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fddp8-0008T8-RK
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fddp8-0005OC-41
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:48:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fddp7-0005Nk-Ul
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:48:06 -0400
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-3-git-send-email-robert.hu@linux.intel.com>
	<20180628182820.GE914@localhost.localdomain>
	<1530603313.22880.36.camel@linux.intel.com>
	<20180703110007.GL7451@localhost.localdomain>
	<1531387131.78672.1.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6e4bc7e-339d-34ab-f61b-8dc3fe5cb16f@redhat.com>
Date: Thu, 12 Jul 2018 17:47:57 +0200
MIME-Version: 1.0
In-Reply-To: <1531387131.78672.1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] i386: Add CPUID bit and feature
 words for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, qemu-devel@nongnu.org, rth@twiddle.net

On 12/07/2018 11:18, Robert Hoo wrote:
>>> And you'd like to set  IA32_ARCH_CAPABILITIES.RSBA by default in qemu or
>>> kvm layer?
>> Probably we need to make this decision in QEMU.  If KVM set RSBA
>> automatically on .get_msr_feature(), QEMU won't be able to
>> differentiate a host with RSBA set from a host with RSBA unset.
>>
> What's the default value for MSR IA32_ARCH_CAPABILITIES? is it clear
> now?
> 

It's the host value.  However, QEMU never sets the CPUID bit so it
doesn't matter if you are using QEMU.

Paolo
