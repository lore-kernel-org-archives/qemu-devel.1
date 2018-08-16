Received: from eggs.gnu.org ([2001:4830:134:3::10]:45069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLyi-00014a-BU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLyd-0001zf-E2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:22:32 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqLyd-0001zG-7k
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:22:27 -0400
Received: by mail-pg1-x541.google.com with SMTP id f14-v6so2346155pgv.13
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 10:22:27 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-41-git-send-email-aleksandar.markovic@rt-rk.com>
	<97501a9d-c00f-7aba-1af2-256629f9abf5@linaro.org>
	<BN7PR08MB486867F6E966AB071EAC4ADBC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <444c2388-6f96-71ae-db7c-38a1d72c8954@linaro.org>
Date: Thu, 16 Aug 2018 10:22:23 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB486867F6E966AB071EAC4ADBC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 40/84] target/mips: Fix pre-nanoMIPS MT
 ASE instructions availability control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 08/16/2018 10:06 AM, Aleksandar Markovic wrote:
> I think some of the previously-implemented similar cases involving read-only bits were handled the same way, and we just built on that. What would you suggest as a more appropriate solution in such cases (of accessing "preset by hardware" bits)?

Well, ctx->insn_flags and ctx->CP0_Config1 are good examples.
These are 100% read-only and fixed at cpu instantiation.

I see that CP0_Config3 has one writable bit for micromips, but
is fully readonly for nanomips.  Therefore XNP and MT need not
be copied to hflags because they will never vary.

I'd suggest copying CP0_Config3 to ctx as with Config1.


r~
