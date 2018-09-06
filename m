Received: from eggs.gnu.org ([2001:4830:134:3::10]:60120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxwSJ-0002r1-Ea
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxwSH-0007YU-CW
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:44:27 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxwSF-0007Ti-IP
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:44:23 -0400
Received: by mail-oi0-x244.google.com with SMTP id p84-v6so21412263oic.4
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 08:44:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f741c912-c37b-34a6-89a3-96577d186adc@eagerm.com>
References: <f38111ad-3fbb-210e-e7ec-49ae675ea65e@eagerm.com>
	<a57fdd27-7a86-3f31-341c-e98101d17b9a@eagerm.com>
	<61c2239b-f8db-6648-ba1b-203309d876eb@eagerm.com>
	<f741c912-c37b-34a6-89a3-96577d186adc@eagerm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Sep 2018 16:44:00 +0100
Message-ID: <CAFEAcA-8fF1F6A64Yv5G0LB9T4mBRvSSqi8oe3kENxSOGc982Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] RISC-V - Dynamic parameterization of
 RISC-V memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Eager <eager@eagerm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 6 September 2018 at 16:07, Michael Eager <eager@eagerm.com> wrote:
> Any comments?

I'd quite like to hear from somebody more familiar with the
readconfig/writeconfig stuff than me about whether this
very riscv-centric approach makes sense and fits with how
the config file is used by other parts of QEMU.

I'm not sure who would be best to do that review, though. Paolo,
any suggestions for who knows that bit of the code?

thanks
-- PMM

> On 08/30/2018 09:22 AM, Michael Eager wrote:
>>
>> Corrected patch attached.
>>
>> On 08/29/2018 05:48 PM, Michael Eager wrote:
>>>
>>> Whoops.  I just noticed that this patch is against the riscv-qemu
>>> repo on github, not the qemu.org repo.  I will rework it for the qemu.org
>>> repo.  Meanwhile, I welcome any comments.
>>>
>>> On 08/29/2018 05:21 PM, Michael Eager wrote:
>>>>
>>>> Memory parameters for RISC-V boards can be read from a configuration
>>>> file using the -readconfig command line option.  The configuration file
>>>> should have a section for the board and memory.  The configuration for
>>>> the VirtIO board has the following configuration variables:
>>>> [riscv-virt-mem]
>>>>    debug-base   = "0x0"
>>>>    debug-size   = "0x100"
>>>>    mrom-base    = "0x1000"
>>>>    mrom-size    = "0x11000"
>>>>    test-base    = "0x100000"
>>>>    test-size    = "0x1000"
>>>>    clint-base   = "0x2000000"
>>>>    clint-size   = "0x10000"
>>>>    plic-base    = "0xc000000"
>>>>    plic-size    = "0x4000000"
>>>>    uart0-base   = "0x10000000"
>>>>    uart0-size   = "0x100"
>>>>    virtio-base  = "0x10001000"
>>>>    virtio-size  = "0x1000"
>>>>    dram-base    = "0x80000000"
>>>>    dram-size    = "0x0"
>>>>
>>>> Values must be enclosed within quotes.
>>>>
>>>> Signed-off-by: Michael Eager <eager@eagercon.com>
>>>>
>>>
>>
>
> --
> Michael Eager    eager@eagerm.com
> 1960 Park Blvd., Palo Alto, CA 94306
>
