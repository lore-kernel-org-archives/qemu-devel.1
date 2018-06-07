Received: from eggs.gnu.org ([2001:4830:134:3::10]:54539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQy4Q-0008Vf-Nq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQy4P-00081p-Ra
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:47:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-2-f4bug@amsat.org>
	<CAFEAcA_EDXyOHpdamg05=p35jazqgZsLKP2O+G1tg6BoR4b28g@mail.gmail.com>
	<b5db1ee8-68b1-a41a-be34-eba99ef5565d@amsat.org>
Message-ID: <f52778c1-f556-22f2-635f-7b85e0eab39b@amsat.org>
Date: Thu, 7 Jun 2018 13:47:16 -0300
MIME-Version: 1.0
In-Reply-To: <b5db1ee8-68b1-a41a-be34-eba99ef5565d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] sdcard: Update the Configuration
 Register (SCR) to Spec Version 1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06/07/2018 12:14 PM, Philippe Mathieu-Daudé wrote:
> On 06/07/2018 08:00 AM, Peter Maydell wrote:
>> On 3 June 2018 at 01:08, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> This register now matches the description of the header:
>>>
>>>  * SD Memory Card emulation as defined in the "SD Memory Card Physical
>>>  * layer specification, Version 1.10."
>>
>> Can you provide a brief justification in the commit message
>> of why it makes more sense for us to advertise as 1.10, please?
>>
>> (eg a summary of the 1.01 to 1.10 differences and a note
>> that we already implement them)
> 
> The only differences I found are:

And I shamefully missed:

    4.3.10 Switch function command
           (This chapter is newly added in version 1.10)

    Switch function command (CMD6) 1 is used to switch or expand
    memory card functions. [...]

    This is a new feature, introduced in SD physical Layer
    Specification Version 1.10. Therefore, cards that are
    compatible with earlier versions of the spec do not support
    it. The host shall check the "SD_SPEC" field in the SCR
    register to recognize what version of the spec the card
    complies with before using CMD6. It is mandatory for SD
    memory card of Ver1.10 to support CMD6.

> 
>     4.3.11 High-Speed mode (25MB/sec interface speed)
>            (This chapter is newly added in version 1.10)
> 
>     Though the Rev 1.01 SD memory card supports up to 12.5MB/sec
>     interface speed, the speed of 25MB/sec is necessary to support
>     increasing performance needs of the host and because of memory
>     size which continues to grow.
>     To achieve 25MB/sec interface speed, clock rate is increased to
>     50MHz and CLK/CMD/DAT signal timing and circuit conditions are
>     reconsidered and changed from Physical Layer Specification
>     Version 1.01.
> 
>     4.3.12 Command system
>            (This chapter is newly added in version 1.10)
> 
>     SD commands CMD34-37, CMD50, CMD57 are reserved for SD command
>     system expansion via the switch command.
>     [These commands] will be considered as illegal commands (as
>     defined in revision 1.01 of the SD physical layer specification).
