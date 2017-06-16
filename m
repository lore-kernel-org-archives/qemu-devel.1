Received: from eggs.gnu.org ([2001:4830:134:3::10]:37454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtIs-00057z-A7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtIo-0001fh-AY
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:36:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1701daf4-b2de-a9fb-7337-7aa791676516@lauterbach.com>
	<CAFEAcA_+rS8gjjU+g1e71vBBioxaWX94+SvMqVh=Ta37ZhYGjA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <186f2e99-0e78-c3be-5453-c96252f1d4e6@amsat.org>
Date: Fri, 16 Jun 2017 12:36:45 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_+rS8gjjU+g1e71vBBioxaWX94+SvMqVh=Ta37ZhYGjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target-arm: Bug fix in filling
 the cp_regs hashtable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: Khaled Jmal <khaled.jmal@lauterbach.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/16/2017 11:51 AM, Peter Maydell wrote:
> On 16 June 2017 at 15:42, Abdallah Bouassida
> <abdallah.bouassida@lauterbach.com> wrote:
>> Check if the CPU supports AARCH64 before adding  the 64bit view of
>> the coprocessor's register to the cp_regs hashtable.
>>
>> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
>> ---
>> Bug description: if a register has the .state = ARM_CP_STATE_BOTH, its 64bit
>> view will be added to the hashtable even if the CPU is not 64bit.
>
> This is deliberate and required. Where the AArch64 and AArch32
> states both have a register which shares underlying architectural
> state, QEMU chooses to implement migration of that state usually
> via the AArch64 version's ARMCPRegInfo struct. If the AArch64
> version is not included in the hashtable for an AArch32-only
> CPU then the state of the 32-bit register won't be migrated.
> The AArch64 register is of course invisible to the guest because
> it is only accessible via 64-bit instructions, but it's used
> during migration.

explanation worth to go as comment in the source!
