Received: from eggs.gnu.org ([2001:4830:134:3::10]:47018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqM2m-0004TC-CC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqM2g-00048w-63
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:26:43 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:43210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqM2c-000465-QX
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:26:36 -0400
Received: by mail-pl0-x230.google.com with SMTP id x6-v6so2405893plv.10
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 10:26:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-46-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <a9e4794e-ed53-f9d8-8809-3e61215bbd37@linaro.org>
Date: Thu, 16 Aug 2018 10:26:30 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-46-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v9 45/84] target/mips: Add emulation of DSP ASE
 for nanoMIPS - part 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> +    switch (opc) {
> +    case NM_POOL32AXF_2_0_7:
> +        switch (extract32(ctx->opcode, 9, 3)) {

For future cleanup, I can't help but thinking you'd be better served by
extracting a different set of opcode bits and having a single switch.

That said, it all appears to all be correct, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
