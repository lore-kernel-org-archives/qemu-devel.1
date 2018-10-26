Received: from eggs.gnu.org ([2001:4830:134:3::10]:36033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3Y3-0004K1-0c
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3Xz-0004u8-Qw
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:57:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3Xz-0004tn-Dd
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:57:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id i8-v6so1802442wmg.0
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:57:11 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-7-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f4742208-3a3c-8ffb-66ab-b0cab8958011@linaro.org>
Date: Fri, 26 Oct 2018 15:57:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-7-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 07/71] tcg-runtime: define
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> +void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
> +{
> +    CPUState *cpu = ENV_GET_CPU(env);
> +
> +    cpu->halted = val;
> +}

I suppose this is fine as a first step.  I'd like to clean up all of the
targets to also use a helper like this to also raise EXCP_HALTED.  They all
perform the same actions, even though this isn't obvious (many of them
reuse helpers that also raise target-specific exceptions).

That said,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
