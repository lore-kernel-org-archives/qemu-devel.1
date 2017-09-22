Received: from eggs.gnu.org ([2001:4830:134:3::10]:51144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abhijit.ray.chaudhury@gmail.com>) id 1dvPc1-0001e3-An
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abhijit.ray.chaudhury@gmail.com>) id 1dvPc0-0004n3-1J
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:11:29 -0400
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:46727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <abhijit.ray.chaudhury@gmail.com>)
	id 1dvPbz-0004mk-RQ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:11:27 -0400
Received: by mail-it0-x233.google.com with SMTP id d192so1661145itd.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:11:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_T+w4msJSKi2=zo899+uA5sRGVjiR-aoKXwCg5odp9qw@mail.gmail.com>
References: <CAACKNgWgNbvH_UV-nLUrcrN7F1jh9G2-ZAScm=Xv2OKhc6WyLQ@mail.gmail.com>
	<CAFEAcA_T+w4msJSKi2=zo899+uA5sRGVjiR-aoKXwCg5odp9qw@mail.gmail.com>
From: Abhijit Ray Chaudhury <abhijit.ray.chaudhury@gmail.com>
Date: Fri, 22 Sep 2017 20:41:26 +0530
Message-ID: <CAACKNgWbTjtFqV_Qv5aqWaVDxiu-D1Vf7+NvkBLrMzpQsz-BfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Support for ARM CP15 registers via GDB interface
 of qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

Thanks for your prompt response. I have gone through target
description xml format for gdb
(https://sourceware.org/gdb//onlinedocs/gdb/ARM-Features.html#ARM-Features)
. I could not find a feature description matching cp15 registers.So
even if I implement some subset of it would gdb understand it ? Can I
randomly name SCTLR TTBR0 etc and gdb understand it ?

Thanking You,
-Abhijit

On Fri, Sep 22, 2017 at 4:23 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 September 2017 at 11:39, Abhijit Ray Chaudhury
> <abhijit.ray.chaudhury@gmail.com> wrote:
>> I want to view ARM CP15 register sets via gdb when I am emulating arm.
>> However I only see ARM Core Register Sets and NEON registers through
>> gdb interface.
>>
>> Can you please let me know how to add cp15 register set support using
>> gdb interface in qemu.
>
> This isn't currently implemented in QEMU, though it would be a
> nice idea. We have wishlist bug https://bugs.launchpad.net/qemu/+bug/741115
> about this, though that was filed in 2011 which will give you an
> idea of how likely it is to be implemented.
>
> The implementation would be moderately but not insanely complex:
> we would need to generate XML in the gdbstub that describes the
> registers by enumerating them in the cpreg hashtable. Hopefully
> gdb would then be able to handle the registers we describe to
> it that way. Likely pitfalls along the way:
>  * our gdbstub currently breaks if the XML fragment is too large,
>    so that bug would need to be fixed first
>  * The coprocessor register descriptions currently assume things
>    like the register name string are for debug purposes only,
>    so there are probably duplicate names or otherwise unhelpful
>    things in there -- these would need to be located and fixed
>
> I thought I remembered somebody talking about having a go at
> implementing this, but I can't find anything with a search through
> the qemu-devel mail archive, so I guess I'm mistaken.
>
> thanks
> -- PMM
