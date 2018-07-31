Received: from eggs.gnu.org ([2001:4830:134:3::10]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkVCe-0002mZ-SA
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkVCZ-0005qI-86
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:00:44 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:34327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkVCY-0005pf-So
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:00:39 -0400
Received: by mail-vk0-x241.google.com with SMTP id l143-v6so7542852vke.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 07:00:38 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-29-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62671280-8775-0fde-451f-951a589478e0@linaro.org>
Date: Tue, 31 Jul 2018 10:00:32 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-29-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 28/76] target/mips: Add emulation of
 nanoMIPS 48-bit instructions
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
>      case NM_P48I:
> -        return 6;
> +        {
> +            insn = cpu_lduw_code(env, ctx->base.pc_next + 4);
> +            uint32_t offset = extract32(ctx->opcode, 0, 16) | insn << 16;

This value is supposed to be signed.


r~
