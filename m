Received: from eggs.gnu.org ([2001:4830:134:3::10]:59864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaAj-00057Q-M3
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaAf-0000DA-LD
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:19:05 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaAf-0000Cq-G3
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:19:01 -0400
Received: by mail-ua0-x244.google.com with SMTP id r10-v6so11043392uao.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:19:01 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-50-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d976385b-45d7-df12-d965-dc7a4241bb0e@linaro.org>
Date: Tue, 31 Jul 2018 15:18:54 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-50-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 49/76] target/mips: Adjust
 exception_resume_pc() for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> -    isa_mode = !!(env->hflags & MIPS_HFLAG_M16);
> +    isa_mode = env->hflags & MIPS_HFLAG_M16 &&
> +                !(env->insn_flags & ISA_NANOMIPS32);

Likewise re nanomips not setting M16.


r~
