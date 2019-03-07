Received: from eggs.gnu.org ([209.51.188.92]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20UM-00027k-Mg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20UL-0004f4-Q0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:23:38 -0500
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-4-mark.cave-ayland@ilande.co.uk>
	<8497b2bc-8789-1e0c-dcdc-06e34fa92275@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e9bd4ba0-921a-edab-b790-a99486b3b4a4@ilande.co.uk>
Date: Thu, 7 Mar 2019 21:23:18 +0000
MIME-Version: 1.0
In-Reply-To: <8497b2bc-8789-1e0c-dcdc-06e34fa92275@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] target/ppc: move Vsr* macros from
 internal.h to cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 07/03/2019 18:23, Richard Henderson wrote:

> On 3/7/19 10:05 AM, Mark Cave-Ayland wrote:
>> It isn't possible to include internal.h from cpu.h so move the Vsr* macros
>> into cpu.h alongside the other VMX/VSX register access functions.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/cpu.h      | 20 ++++++++++++++++++++
>>  target/ppc/internal.h | 19 -------------------
>>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> Although to some extent I think we should be minimizing the amount
> of code within cpu.h, to avoid rebuilding the world.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Yeah - I did notice that quite a bit during testing, but when looking at cpu.h after
the final patch was reasonably convinced that these shouldn't need to be changed again...


ATB,

Mark.
