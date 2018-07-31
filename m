Received: from eggs.gnu.org ([2001:4830:134:3::10]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkYJZ-0005Le-Pz
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkYJV-0007d6-II
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:20:05 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:35257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkYJV-0007cw-CW
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:20:01 -0400
Received: by mail-ua0-x244.google.com with SMTP id q12-v6so10805511ual.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 10:20:01 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-39-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62fc84c4-0c6e-7cc6-a474-4603f093e722@linaro.org>
Date: Tue, 31 Jul 2018 13:19:56 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-39-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 38/76] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 1
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
> +    case OPC_CMPGU_EQ_QB:
> +        check_dsp(ctx);
> +        gen_helper_cmpgu_eq_qb(cpu_gpr[ret], v1_t, v2_t);
> +        break;

Missing a test for ret == 0, here and many other places.
I believe some (many?) of these have side-effects, so you'll
probably want to store into e.g. v1_t and gen_store_gpr.


r~
