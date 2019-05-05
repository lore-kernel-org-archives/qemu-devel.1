Received: from eggs.gnu.org ([209.51.188.92]:38384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDZ7-0005px-Od
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDZ6-0001pi-LL
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:36:13 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-4-mark.cave-ayland@ilande.co.uk>
	<3df9625c-2d66-82f8-119f-61af3bfc1f86@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b758800d-d78f-f802-4c7d-21cc4f96cafd@ilande.co.uk>
Date: Sun, 5 May 2019 10:36:02 +0100
MIME-Version: 1.0
In-Reply-To: <3df9625c-2d66-82f8-119f-61af3bfc1f86@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/14] target/ppc: remove getVSR()/putVSR()
 from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 30/04/2019 17:32, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>>  void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
>>                          target_ulong xbn, uint32_t index)
>>  {
>> -    ppc_vsr_t xt, xb;
>> +    ppc_vsr_t *xt = &env->vsr[xtn];
>> +    ppc_vsr_t *xb = &env->vsr[xbn];
>>      size_t es = sizeof(uint32_t);
>>      uint32_t ext_index;
>>      int i;
>>  
>> -    getVSR(xbn, &xb, env);
>> -    memset(&xt, 0, sizeof(xt));
>> +    memset(xt, 0, sizeof(ppc_vsr_t));
> 
> This fails if xt == xb.
> 
> Similarly for xxinsertw.

Yeah. Again I can easily fix this up with a local variable.


ATB,

Mark.
