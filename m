Received: from eggs.gnu.org ([2001:4830:134:3::10]:35955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1dlz29-0006X3-S2
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 10:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1dlz26-0003hG-QI
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 10:59:29 -0400
Received: from [2a02:25b0:aaaa:57a::affe:bade] (port=47606
	helo=vps01.wiesinger.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lists@wiesinger.com>) id 1dlz26-0003gV-IK
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 10:59:26 -0400
References: <35eda6a9-086e-f899-e131-288f2346effe@wiesinger.com>
	<ce477c53-25bc-e6dd-3e05-c74af1f33c2d@wiesinger.com>
	<3e1f41a8-faff-1858-6f0d-154694dff02d@wiesinger.com>
	<CABgObfYzngJPgS9agXMrRENVD_e+3Hm=y+KD5dp9na8jNwuumw@mail.gmail.com>
	<CABgObfZFwJMpU_D8SMkuiEhb0qBokHL0jpwmuzdE73TReHMFkg@mail.gmail.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <583438b7-4acc-5b66-0c7f-8a542b20495c@wiesinger.com>
Date: Sun, 27 Aug 2017 16:59:11 +0200
MIME-Version: 1.0
In-Reply-To: <CABgObfZFwJMpU_D8SMkuiEhb0qBokHL0jpwmuzdE73TReHMFkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] kvm_intel fails to load on Conroe CPUs running
 Linux 4.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>

On 27.08.2017 14:03, Paolo Bonzini wrote:
> Il 27 ago 2017 9:49 AM, "Gerhard Wiesinger" <lists@wiesinger.com> ha
> scritto:
>
> On 17.08.2017 23:14, Gerhard Wiesinger wrote:
>
>> On 17.08.2017 22:58, Gerhard Wiesinger wrote:
>>> On 07.08.2017 19:50, Paolo Bonzini wrote:
>>>
>>>> Not much to say, unfortunately. It's pretty much the same capabilities
>>>> as a Prescott/Cedar Mill processor, except that it has MSR bitmaps. It
>>>> also lacks FlexPriority compared to the Conroe I had checked.
>>>>
>>>> It's not great that even the revert patch doesn't apply cleanly---this
>>>> is *not* necessarily a boring area of the hypervisor...
>>>>
>>>> Given the rarity of your machine I'm currently leaning towards _not_
>>>> reverting the change. I'll check another non-Xeon Core 2 tomorrow that
>>>> is from December 2008 (IIRC). If that one also lacks vNMI, or if I get
>>>> other reports, I suppose I will have to reconsider that.
>> Hello Paolo,
>>
>> Can you please revert the patch.
>>
>> CPU is a Core 2 Extreme QX6700: SL9UL (B3) running VERY stable with ECC
>> RAM for years now.
>> https://ark.intel.com/products/28028/Intel-Core2-Extreme-
>> Processor-QX6700-8M-Cache-2_66-GHz-1066-MHz-FSB?q=Core%
>> 202%20Extreme%20QX6700
>> https://en.wikipedia.org/wiki/List_of_Intel_Core_2_microprocessors
>>
>> CPU details below.
>>
>> Thank you.
>>
>> Ciao,
>> Gerhard
>>
> Hello Paolo,
>
> Any update on this major issue?
>
>
> We will revert the patch, but 4.13.0 will not have the fix. Expect it in
> later stable kernels (because vacations).
Thnx. Why will 4.13.0 NOT have the fix?

Thnx.

Ciao,
Gerhard
