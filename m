Received: from eggs.gnu.org ([2001:4830:134:3::10]:36286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cLtf7-0006xR-Mm
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cLtf6-0002wf-Sz
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:27:37 -0500
References: <20161208175030.12269-1-drjones@redhat.com>
	<20161208175030.12269-4-drjones@redhat.com>
	<dfb48863-82a7-3bd2-d2dc-498570325970@arm.com>
	<20161209121541.i3advgnpbu5gvoft@hawk.localdomain>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <cd3f8a17-f080-5ac8-9398-cddee4d23521@codeaurora.org>
Date: Tue, 27 Dec 2016 10:27:25 -0500
MIME-Version: 1.0
In-Reply-To: <20161209121541.i3advgnpbu5gvoft@hawk.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH kvm-unit-tests v8 03/10] arm/arm64: add
 some delay routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Andre Przywara <andre.przywara@arm.com>
Cc: peter.maydell@linaro.org, kvm@vger.kernel.org, marc.zyngier@arm.com, qemu-devel@nongnu.org, eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org, kvmarm@lists.cs.columbia.edu, christoffer.dall@linaro.org

On 12/09/2016 07:15 AM, Andrew Jones wrote:
> On Fri, Dec 09, 2016 at 11:41:06AM +0000, Andre Przywara wrote:
>> Hi,
>>
>> On 08/12/16 17:50, Andrew Jones wrote:
>>> Allow a thread to wait some specified amount of time. Can
>>> specify in cycles, usecs, and msecs.

>>> +++ b/lib/arm/asm/delay.h
>>> @@ -0,0 +1,14 @@
>>> +#ifndef _ASMARM_DELAY_H_
>>> +#define _ASMARM_DELAY_H_
>>> +/*
>>> + * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU LGPL, version 2.
>>> + */
>>> +#include <libcflat.h>
>>> +
>>> +extern void delay(u64 cycles);
>>
>> Nit: Shouldn't this parameter be called "ticks"? Cycles might be a bit
>> misleading, especially since this prototype is the only documentation on
>> this. You might just want to fix this when applying the patches.
> 
> Right or wrong the kernel uses 'cycles' for this function, named
> __timer_delay for arm and __delay for arm64. I guess I prefer
> consistency here.

I too expect timers to tick and CPUs to cycle. The benefit of
parameter-name-precise consistency with the Linux source is not
obvious to me.

Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
