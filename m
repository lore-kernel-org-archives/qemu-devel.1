Received: from eggs.gnu.org ([2001:4830:134:3::10]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXZMW-0006iM-Sv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXZMN-0005tn-IC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:21:40 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXZMM-0005pF-RJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:21:35 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so3534813oth.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:21:34 -0800 (PST)
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <035046cb-7a0d-8049-a102-103e0a8758ed@linaro.org>
Date: Thu, 13 Dec 2018 16:21:30 -0600
MIME-Version: 1.0
In-Reply-To: <20181213115503.24188-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target/arm: kvm64 make guest debug
 AA32 break point aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: mark.rutland@arm.com, Peter Maydell <peter.maydell@linaro.org>, Omair Javaid <omair.javaid@linaro.org>, ard.biesheuvel@linaro.org, qemu-arm@nongnu.org

On 12/13/18 5:55 AM, Alex Bennée wrote:
>  int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>  {
> +    CPUARMState *env = &ARM_CPU(cs)->env;
> +    int el = arm_current_el(env);
> +    bool is_aa64 = arm_el_is_aa64(env, el);

This will assert for el == 0; for that you need is_a64(env).


r~
