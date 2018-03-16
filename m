Received: from eggs.gnu.org ([2001:4830:134:3::10]:36835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewjNM-0002kT-Gw
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewjNJ-0006rg-FR
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:02:04 -0400
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:51446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewjNJ-0006rY-92
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:02:01 -0400
Received: by mail-it0-x22c.google.com with SMTP id g7-v6so899530itf.1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 00:02:00 -0700 (PDT)
References: <871sgwmcc3.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<b8642b07-307a-6109-6350-e7830a1b7842@linaro.org>
	<87bmfor7bl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <941d7e1b-b6c2-59bd-90dc-4b19903d2a84@linaro.org>
Date: Fri, 16 Mar 2018 15:01:45 +0800
MIME-Version: 1.0
In-Reply-To: <87bmfor7bl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Using new TCG Vector infrastructure in PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 03/16/2018 12:08 PM, Nikunj A Dadhania wrote:
> @@ -1078,8 +1079,8 @@ struct CPUPPCState {
>      /* Altivec registers */
>      ppc_avr_t avr[32];
>      uint32_t vscr;
> -    /* VSX registers */
> -    uint64_t vsr[32];
> +    /* 32 (128bit)- VSX registers */
> +    ppc_avr_t vsr[32];

Another thing that needs to happen is to make ppc_avr_t to be 16-byte aligned
(this is documented in tcg-gvec-op.h, I believe).

This is easily accomplished by adding QEMU_ALIGNED(16) to the first union
member.  And then you'd like to put vsr adjacent to avr so that you're not
adding another alignment hole.


r~
