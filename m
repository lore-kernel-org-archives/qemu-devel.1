Received: from eggs.gnu.org ([2001:4830:134:3::10]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK5x6-00066A-7n
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK5x2-00023Y-8e
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eK5x2-00022u-2C
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:15:12 -0500
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<5A1E43A6.1010607@huawei.com>
	<20171129104122.GY3037@localhost.localdomain>
	<5A1EA0DB.60303@huawei.com> <20171129133524.GA2279@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ebcd22a-4c6c-8260-c94c-26810d6a24cd@redhat.com>
Date: Wed, 29 Nov 2017 18:15:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171129133524.GA2279@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "Longpeng (Mike)" <longpeng2@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, rth@twiddle.net, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, zhaoshenglong <zhaoshenglong@huawei.com>

On 29/11/2017 14:35, Roman Kagan wrote:
>>
>>> IMO, the long term solution is to make Linux guests not misbehave
>>> when we stop lying about the L3 cache.  Maybe we could provide a
>>> "IPIs are expensive, please avoid them" hint in the KVM CPUID
>>> leaf?
> We already have it, it's the hypervisor bit ;)  Seriously, I'm unaware
> of hypervisors where IPIs aren't expensive.
> 

In theory, AMD's AVIC should optimize IPIs to running vCPUs.  Amazon's
recently posted patches to disable HLT and MWAIT exits might tilt the
balance in favor of IPIs even for Intel APICv (where sending the IPI is
expensive, but receiving it isn't).

Being able to tie this to Amazon's other proposal, the "DEDICATED" CPUID
bit, would be nice.  My plan was to disable all three of MWAIT/HLT/PAUSE
when setting the dedicated bit.

Paolo
