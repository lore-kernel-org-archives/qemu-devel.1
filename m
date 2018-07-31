Received: from eggs.gnu.org ([2001:4830:134:3::10]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkVDp-0003Ju-VI
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkVDk-0006GH-Ao
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:01:58 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:46749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkVDk-0006G5-3j
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:01:52 -0400
Received: by mail-ua0-x244.google.com with SMTP id u11-v6so5619066uan.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 07:01:51 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-31-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5149c2da-e9d4-f7bc-8324-3d367beb91d1@linaro.org>
Date: Tue, 31 Jul 2018 10:01:47 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-31-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 30/76] target/mips: Add emulation of
 misc nanoMIPS instructions (pool32a0)
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
> +    case NM_SOV:
> +        {
> +            TCGv t0 = tcg_temp_local_new();

tcg_temp_new.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
