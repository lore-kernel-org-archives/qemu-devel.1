Received: from eggs.gnu.org ([2001:4830:134:3::10]:47737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5taj-0006bv-S5
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5tai-0007MG-Tr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:45:45 -0400
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<cbad2760-7a64-7602-5734-eea0747c620f@mail.uni-paderborn.de>
	<20180409161101.GB18168@flamenco>
	<565df28d-2f24-1065-c00a-4cceaf5428b4@linaro.org>
	<20180410130318.GB22304@flamenco>
	<17f92de0-f659-7770-8d78-92535cadb232@mail.uni-paderborn.de>
	<20180410134004.GC22304@flamenco>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <09bfd09a-ae09-5f2e-6159-eb2c269c5f0d@mail.uni-paderborn.de>
Date: Tue, 10 Apr 2018 15:45:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180410134004.GC22304@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/17] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc/riscv targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Michael Clark <mjc@sifive.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 04/10/2018 03:40 PM, Emilio G. Cota wrote:
> On Tue, Apr 10, 2018 at 15:16:19 +0200, Bastian Koppelmann wrote:
>> On 04/10/2018 03:03 PM, Emilio G. Cota wrote:
>>> On Tue, Apr 10, 2018 at 14:24:23 +1000, Richard Henderson wrote:
>>>> On 04/10/2018 02:11 AM, Emilio G. Cota wrote:
>>>>> On Mon, Apr 09, 2018 at 16:01:36 +0200, Bastian Koppelmann wrote:
>>>>>> Thanks for doing this grunt work. Me and a colleague were planning to do
>>>>>> this as well after converting the RISC-V frontend to decodetree. Do you
>>>>>> have any plans to do this for the TriCore frontend as well? I have the
>>>>>> same plan for Tricore: Convert it to decodetree, then to translation loop.
>>>>>
>>>>> I won't do any further conversions in the near future, so please go
>>>>> ahead with your plans :-)
>>>>
>>>> In which case I won't review Emilio's final two patches for risc-v.
>>
>> I'm confused as well :). I don't understand why Richard is not reviewing
>> the last two patch. Maybe you can clarify as well, Richard.
> 
> I think he understood you already had patches (not yet on-list) to do the
> trloop conversion for riscv, and therefore my patches should be discarded.

No, I don't have patches.

> [...]
> 
> Note that the first patch in this series does change the TranslatorOps
> interface, that's why I think the whole series should go
> through the same tree (Richard's TCG tree, I presume).

Works for me.

Cheers,
Bastian
