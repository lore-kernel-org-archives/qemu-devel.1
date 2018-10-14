Received: from eggs.gnu.org ([2001:4830:134:3::10]:44245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBj0H-0000L1-Qs
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBj0D-0005Pv-Bn
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:12:29 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBj0B-0005Nl-T1
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:12:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id l81-v6so8460205pfg.3
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 09:12:20 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e04a02e-164e-f457-4d86-864fee60f251@linaro.org>
Date: Sun, 14 Oct 2018 09:12:15 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] target/arm: Improve debug logging of
 AArch32 exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 10/12/18 7:42 AM, Peter Maydell wrote:
> For AArch32, exception return happens through certain kinds
> of CPSR write. We don't currently have any CPU_LOG_INT logging
> of these events (unlike AArch64, where we log in the ERET
> instruction). Add some suitable logging.
> 
> This will log exception returns like this:
> Exception return from AArch32 hyp to usr PC 0x80100374
> 
> paralleling the existing logging in the exception_return
> helper for AArch64 exception returns:
> Exception return from AArch64 EL2 to AArch64 EL0 PC 0x8003045c
> Exception return from AArch64 EL2 to AArch32 EL0 PC 0x8003045c
> 
> (Note that an AArch32 exception return can only be
> AArch32->AArch32, never to AArch64.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    static const char * const cpu_mode_names[16] = {
> +        "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
> +        "???", "???", "hyp", "und", "???", "???", "???", "sys"
> +    };

Nit: Better as static const char cpu_mode_names[16][4].

For tiny strings like this, the pointer to a separate string is larger than the
string itself.


r~
