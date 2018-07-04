Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fad9h-0006sl-O4
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fad9c-0005Pk-7u
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:28:53 -0400
Received: from foss.arm.com ([217.140.101.70]:40606)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fad9c-0005PK-1w
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:28:48 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-11-git-send-email-suzuki.poulose@arm.com>
	<e0c8dc62-42e8-ee24-5519-e19b2739160b@redhat.com>
	<a6fa912a-b2ff-ac1e-0120-b2f7eabb6f7f@arm.com>
	<3192c7dc-4127-ec97-6ba3-262fa3ff6243@redhat.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1696a35f-9cd5-d807-f2e9-41d9f19d919a@arm.com>
Date: Wed, 4 Jul 2018 09:29:06 +0100
MIME-Version: 1.0
In-Reply-To: <3192c7dc-4127-ec97-6ba3-262fa3ff6243@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/20] kvm: arm64: Dynamic configuration
 of VTTBR mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu

On 07/04/2018 09:24 AM, Auger Eric wrote:
>>>> + *
>>>> + * We have a magic formula for the Magic_N below.
>>>> + *
>>>> + *  Magic_N(PAGE_SIZE, Entry_Level) = 64 - ((PAGE_SHIFT - 3) *
>>>> Number of levels)
>>
>> [0] ^^^
>>
>>
>>
>>>> + *
>>>> + * where number of levels = (4 - Entry_Level).
>>
>> ^^^ Doesn't this help make it clear ? Using the expansion makes it a bit
>> more
>> unreadable below.
> 
> I just wanted to mention the tables you refer (D4-23 and D4-25) give
> Magic_N for a larger scope as they deal with any lookup level while we
> only care about the entry level for BADDR. So I was a little bit
> confused when reading the explanation but that's not a big deal.

Ah, ok. I will try to clarify it.

Cheers
Suzuki
