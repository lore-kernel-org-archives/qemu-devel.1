Received: from eggs.gnu.org ([2001:4830:134:3::10]:52573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkueU-0007gJ-SO
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 13:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkueP-000232-UA
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 13:11:10 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:43734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkueP-00022u-Lj
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 13:11:05 -0400
Received: by mail-ua0-x244.google.com with SMTP id x24-v6so13167839ual.10
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 10:11:05 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-20-git-send-email-aleksandar.markovic@rt-rk.com>
	<3cc80633-3b9f-07a4-1600-ca367dc6f5ba@linaro.org>
	<BN7PR08MB4868954A9B34D08D2DA861F1C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <012d1b4a-86eb-d87b-324f-1d200bb107b9@linaro.org>
Date: Wed, 1 Aug 2018 13:11:00 -0400
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868954A9B34D08D2DA861F1C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 19/76] target/mips: Add emulation of
 nanoMIPS 16-bit arithmetic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 08/01/2018 12:02 PM, Aleksandar Markovic wrote:
>> I suggest a "target_long imm;" at the top of the function to handle all such
>> that will be required when this function is filled out.
> 
> gen_arith_imm() and similar functions have "int" as the type of offset/imm parameter (in this case the last parameter) - shouldn't "int" be more appropriate type for local variable than "target_long"?
Fair enough.  It certainly fits all of the immediates that nanomips can generate.

If you eventually split up gen_arith_imm etc as previously suggested, I suggest
changing to target_long though.  That would allow e.g. the decode for the
MIPS64R6 DATI and DAHI instructions to use the basic gen_daddiu expander with
the immediate already shifted into place in the high 32 bits.


r~
