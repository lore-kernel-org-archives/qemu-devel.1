Received: from eggs.gnu.org ([2001:4830:134:3::10]:40102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYwZW-0004B8-07
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYwZR-0006h0-HQ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:20:49 -0500
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<20181217122405.18732-2-mark.cave-ayland@ilande.co.uk>
	<06de2004-b85c-bf5d-844c-c15fe78efe63@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <df2daaff-04fe-e16c-1612-83e6dfbec43e@ilande.co.uk>
Date: Mon, 17 Dec 2018 17:20:15 +0000
MIME-Version: 1.0
In-Reply-To: <06de2004-b85c-bf5d-844c-c15fe78efe63@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/9] target/ppc: introduce get_fpr()
 and set_fpr() helpers for FP register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 17/12/2018 16:40, Richard Henderson wrote:

> On 12/17/18 4:23 AM, Mark Cave-Ayland wrote:
>> These helpers allow us to move FP register values to/from the specified TCGv_i64
>> argument in the VSR helpers to be introduced shortly.
>>
>> To prevent FP helpers accessing the cpu_fpr array directly, add extra TCG
>> temporaries as required.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/translate.c             |  10 +
>>  target/ppc/translate/fp-impl.inc.c | 490 ++++++++++++++++++++++++++++---------
>>  2 files changed, 390 insertions(+), 110 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Howard has notified me off-list of a regression he noticed in OS X, which I've traced
down to an erroneous extra get_fpr() in the GEN_FLOAT_* macro changes in this patch.

I've pushed the fixed version of this patchset to
https://github.com/mcayland/qemu/tree/ppc-altivec for those who wish to experiment
before I send out a v3 later in the week (I feel reasonably confident now to drop the
RFC for the next iteration).


ATB,

Mark.
