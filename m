Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnMX-0004vc-54
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnMS-0006ES-Ti
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:06:33 -0500
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-2-mark.cave-ayland@ilande.co.uk>
	<20181210051730.GQ4261@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <58984381-675f-8fee-802d-dba90653cf24@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:06:20 +0000
MIME-Version: 1.0
In-Reply-To: <20181210051730.GQ4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] target/ppc: introduce get_fpr()
 and set_fpr() helpers for FP register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 10/12/2018 05:17, David Gibson wrote:

> On Fri, Dec 07, 2018 at 08:56:30AM +0000, Mark Cave-Ayland wrote:
>> These helpers allow us to move FP register values to/from the specified TCGv_i64
>> argument.
>>
>> To prevent FP helpers accessing the cpu_fpr array directly, add extra TCG
>> temporaries as required.
> 
> It's not obvious to me why that's a desirable thing.  I'm assuming
> it's somehow necessary for the stuff later in the series, but I think
> we need a brief rationale here to explain why this isn't just adding
> extra reg copies for the sake of it.

Ah okay. It's because the VSX registers extend the set of VMX and FPR registers (see
the cpu_vsrh() and cpu_vsrl() helpers at the top of
target/ppc/translate/vsx-impl.inc.c). So in order to remove the static TCGv_i64
arrays then these helpers must also be converted.


ATB,

Mark.
