Received: from eggs.gnu.org ([2001:4830:134:3::10]:56987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZvX-0006zE-VG
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZvS-00071a-VK
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:03:24 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:41371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkZvS-00070Y-OM
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:03:18 -0400
Received: by mail-ua0-x244.google.com with SMTP id h1-v6so8694341uao.8
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:03:18 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-45-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0540b76e-e7c3-be32-8d82-f1030f1ef04a@linaro.org>
Date: Tue, 31 Jul 2018 15:03:13 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-45-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 44/76] target/mips: Add handling of
 branch delay slots for nanoMIPS
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
> -        int lowbit = !!(ctx->hflags & MIPS_HFLAG_M16);
> +        int lowbit = ctx->has_isa_mode && !!(ctx->hflags & MIPS_HFLAG_M16);

I believe I asked why M16 is set for nanoMIPS at all.

You go out of your way to ignore it in lots of places,
and avoid it being cleared in others.  And I noted some
places where it seemed to have been forgotten to be ignored.


r~
