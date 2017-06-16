Received: from eggs.gnu.org ([2001:4830:134:3::10]:34863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1dLtAw-0001AS-17
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1dLtAs-0006pz-4O
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:28:42 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:45363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1dLtAr-0006oK-Ps
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:28:38 -0400
References: <1701daf4-b2de-a9fb-7337-7aa791676516@lauterbach.com>
	<CAFEAcA_+rS8gjjU+g1e71vBBioxaWX94+SvMqVh=Ta37ZhYGjA@mail.gmail.com>
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <5f1df0fb-6c63-a0db-90fc-1e6c455ce2bd@lauterbach.com>
Date: Fri, 16 Jun 2017 16:28:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_+rS8gjjU+g1e71vBBioxaWX94+SvMqVh=Ta37ZhYGjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] target-arm: Bug fix in filling the cp_regs
 hashtable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

Oh, I see!
Thanks for the details!

Regards,
Abdallah

Le 6/16/2017 à 3:51 PM, Peter Maydell a écrit :
> On 16 June 2017 at 15:42, Abdallah Bouassida
> <abdallah.bouassida@lauterbach.com> wrote:
>> Check if the CPU supports AARCH64 before adding  the 64bit view of
>> the coprocessor's register to the cp_regs hashtable.
>>
>> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
>> ---
>> Bug description: if a register has the .state = ARM_CP_STATE_BOTH, its 64bit
>> view will be added to the hashtable even if the CPU is not 64bit.
> This is deliberate and required. Where the AArch64 and AArch32
> states both have a register which shares underlying architectural
> state, QEMU chooses to implement migration of that state usually
> via the AArch64 version's ARMCPRegInfo struct. If the AArch64
> version is not included in the hashtable for an AArch32-only
> CPU then the state of the 32-bit register won't be migrated.
> The AArch64 register is of course invisible to the guest because
> it is only accessible via 64-bit instructions, but it's used
> during migration.
>
> thanks
> -- PMM
