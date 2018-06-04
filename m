Received: from eggs.gnu.org ([2001:4830:134:3::10]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fPkyb-0003p8-O7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fPkya-00018i-RG
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:36:29 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180604080448.GM4251@umbus>
References: <20180531130429.24911-1-joel@jms.id.au>
	<20180604080448.GM4251@umbus>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 4 Jun 2018 18:06:04 +0930
Message-ID: <CACPK8XfrL8U_DCu3Ek9e+Gvj9oSn2+c9JnUBf0i4+OTz96-JRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Allow privileged access to
 SPR_PCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>

On 4 June 2018 at 17:34, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Thu, May 31, 2018 at 10:34:29PM +0930, Joel Stanley wrote:
>> @@ -98,6 +99,15 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
>>          tlb_flush(CPU(cpu));
>>      }
>>  }
>> +
>> +void helper_store_pcr(CPUPPCState *env, target_ulong value)
>> +{
>> +    if (value != 0) {
>> +        error_report("Invalid PCR value 0x"TARGET_FMT_lx, value);
>> +        return;
>> +    }
>
> I don't see a lot of point to this check.  For now the only user just
> clears the PCR, but why limit yourself to that explicitly?

As we're not emulating the features of the register when the value is
non-zero, I thought it would make make sense to do something.

I'll drop it in v3.

>
>> +    env->spr[SPR_PCR] = value;
>
> You definitely should be masking against pcr_mask too.

Okay. Thanks for the review.

Cheers,

Joel
