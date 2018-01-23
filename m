Received: from eggs.gnu.org ([2001:4830:134:3::10]:52069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ee1dF-00047G-68
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ee1dE-00061Z-EH
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:09 -0500
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
	<CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
	<1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
	<CAATJJ0+swtq=6Q7U9fShDRvbm13YukdfXqOX0pcvf9=z-KR3ZQ@mail.gmail.com>
	<CAFEAcA9RQB7xAzXgKN3E8cL2SauiwOkqFMpmQg43YzD09OF52A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e09cb727-6e0b-3e90-24a6-c4b0a53e55cb@redhat.com>
Date: Tue, 23 Jan 2018 17:40:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RQB7xAzXgKN3E8cL2SauiwOkqFMpmQg43YzD09OF52A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x]  [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23.01.2018 12:14, Peter Maydell wrote:
> On 23 January 2018 at 10:34, Christian Ehrhardt
> <christian.ehrhardt@canonical.com> wrote:
>> Also adding Suraj for a statement in this regard about his "[QEMU-PPC]
>> [PATCH V5 0/7] target/ppc: Rework spapr_caps" series which I think is
>> the PPC version of all of this right?
>> Not sure who to add for Arm :-/
> 
> AIUI for Arm no QEMU changes should be required -- KVM VMs always
> use the same CPU type as the host, and the kernel always exposes
> the same MIDR (main ID register) value to the guest as the host has,
> and the guest kernel fixes will key off the MIDR.

Unrelated, but how can ARM make sure that migration back and forth works
reliably? (e.g. from a system with spectre fixes to a system without
spectre fixes)

Thanks!

> 
> thanks
> -- PMM
> 


-- 

Thanks,

David / dhildenb
