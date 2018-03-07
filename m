Received: from eggs.gnu.org ([2001:4830:134:3::10]:53764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1etYU4-0001Of-2N
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1etYU3-0006hC-Aa
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:47:52 -0500
References: <000e01d3afad$b9a13830$2ce3a890$@codeaurora.org>
	<20180227104708.GA11391@cbox>
	<ac329e1b1f5265a805916ab4f8708f9d@codeaurora.org>
	<20180227124604.GA2373@cbox>
	<20180227132131.fipafmnb56a7fj76@kamzik.brq.redhat.com>
	<20180301105030.2b716e68@redhat.com>
	<CAFEAcA9yaU745Asy--jM0nu8FDJ62CEXSH_TKa-ZZfC16qye6w@mail.gmail.com>
	<b049a501-cd5e-8c22-9c62-88c950e01b1b@redhat.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <acd04e77-33c9-71f1-c140-1f9c20da8022@arm.com>
Date: Wed, 7 Mar 2018 12:47:39 +0000
MIME-Version: 1.0
In-Reply-To: <b049a501-cd5e-8c22-9c62-88c950e01b1b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] VCPU hotplug on KVM/ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Christoffer Dall <cdall@cs.columbia.edu>, QEMU Developers <qemu-devel@nongnu.org>, Christoffer Dall <christofferdall@christofferdall.dk>, qemu-arm <qemu-arm@nongnu.org>, kvmarm@lists.cs.columbia.edu

On 01/03/18 13:32, David Hildenbrand wrote:
> On 01.03.2018 11:05, Peter Maydell wrote:
>> On 1 March 2018 at 09:50, Igor Mammedov <imammedo@redhat.com> wrote:
>>> In QEMU on x86 (and I think ppc, s390 as well), we create vCPUs on demand.>>
>>> It would be nice if ARM would be able to do that too,
>>> so that it could take advantage of the same code.
>>
>> It's not clear to me how that would work, given that for
>> instance the interrupt controller wants to know up-front
>> how many CPUs it has to deal with.
>>
> 
> So how is cpu hotplug handled in HW? Or doesn't it even exist there?

I don't know of any physical system offering that facility.

> (we have max_cpus for the interrupt controller, but not sure if that is
> what we want)
We'd need something along those lines. Each CPU has a notional point to
point link to the interrupt controller (to the redistributor, to be
precise), and this entity must pre-exist.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
