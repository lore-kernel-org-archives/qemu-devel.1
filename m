Received: from eggs.gnu.org ([209.51.188.92]:33784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1h2IsE-0001Hj-JR
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1h2Is6-00039M-E7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:01:27 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:55910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1h2Is0-00034L-Mk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:01:17 -0500
References: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
	<1550029560-30530-3-git-send-email-sandra@codesourcery.com>
	<CAFEAcA-Ocow8GzPCPO=346hnc4CZ6M02TwVp-e6G2EjY5-FESQ@mail.gmail.com>
	<7d4097aa-4888-82f6-3e4e-eeeb8de9f55b@codesourcery.com>
	<CAFEAcA92mHFcPoNtsHJqUTzfjxvXh4CpjEy_=irMYu9gEpg=2Q@mail.gmail.com>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <bca405b0-1d08-5787-ddcc-d9205021689e@codesourcery.com>
Date: Fri, 8 Mar 2019 10:01:05 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92mHFcPoNtsHJqUTzfjxvXh4CpjEy_=irMYu9gEpg=2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>

On 3/8/19 9:04 AM, Peter Maydell wrote:
> On Fri, 8 Mar 2019 at 03:13, Sandra Loosemore <sandra@codesourcery.com> wrote:
>>
>> On 3/7/19 7:58 AM, Peter Maydell wrote:
>>> On Wed, 13 Feb 2019 at 04:02, Sandra Loosemore <sandra@codesourcery.com> wrote:
>>>>
>>>> This patch adds support for libgloss semihosting to Nios II bare-metal
>>>> emulation.
>>>>
>>>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
>>>> Signed-off-by: Julian Brown <julian@codesourcery.com>
>>>
>>> Do you have a link to the spec that defines this semihosting
>>> ABI, please ?
>>
>> Well, I just wrote some derived from the comments in the libgloss
>> sources; see the attachment.  :-)
> 
> Thanks. So who "owns" this ABI (ie has the authority to change
> it and should be the end documenting it)? How many projects or
> bits of software are implementing either end of it?

Going back in ancient history, I implemented the m68k version in 
libgloss in 2006 to support a hardware debug stub that CodeSourcery was 
also providing at that time.  We later moved the runtime side of it into 
target-agnostic code in an internal library, so when it came time to do 
a similar JTAG debug stub for bare-metal Nios II hardware testing in 
2012, we re-used our existing code for both library and debug stub. 
Later Altera implemented the same protocol in some proprietary 
simulators they provided to us, and more recently we wrote these patches 
to add it to QEMU.  We've shifted away from hardware testing and no 
longer use the original debug stub now.

> If we decide that QEMU owns the spec we can put the documentation
> into docs/specs/.

Making QEMU the "owner" of the ABI seems a little peculiar to me since 
it is only one client among several, and is a latecomer too.  I think 
libgloss would make a little more sense.  OTOH, I have no problem with 
making the documentation part of QEMU.

-Sandra
