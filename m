Received: from eggs.gnu.org ([2001:4830:134:3::10]:33465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNEU-0002NB-1z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNEO-0000bA-8k
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:03:50 -0400
Date: Thu, 14 Jun 2018 10:03:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180614013612.GF3042@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806141001260.19899@zero.eik.bme.hu>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<79692361d82a4d0b1f9c36b0d988369062351f00.1528935420.git.balaton@eik.bme.hu>
	<20180614013612.GF3042@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v3 9/9] target/ppc: Add missing opcode for
 icbt on PPC440
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Thu, 14 Jun 2018, David Gibson wrote:
> On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:

Maybe amend commit message like this:

According to PPC440 User Manual
>> PPC440 has two opcodes for icbt, add the missing one.

If you can do this when committing then please feel free to adjust this 
commit message as necessary, otherwise I'll change it in next iteration.

Regards,
BALATON Zoltan

> A document reference to confim this would be nice.
>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/translate.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 5fe1ba6..3a215a1 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -6707,6 +6707,8 @@ GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
>>  GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
>>  GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
>>                 PPC_BOOKE, PPC2_BOOKE206),
>> +GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
>> +               PPC_440_SPEC),
>>  GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
>>  GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
>>  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
>
>
