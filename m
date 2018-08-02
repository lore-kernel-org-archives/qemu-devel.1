Received: from eggs.gnu.org ([2001:4830:134:3::10]:57037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flHP6-0000KX-Fi
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flHP2-00050O-Iv
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:28:48 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:43702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1flHP2-0004y8-81
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:28:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id j26-v6so1692959pfi.10
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 10:28:43 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-46-git-send-email-aleksandar.markovic@rt-rk.com>
	<599465e2-9620-61a4-9a73-a8464c06cbab@linaro.org>
	<BN7PR08MB48688BC84CBE8C74D095A46AC62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec7bec8f-800b-6840-a6e7-c07e4d667f34@linaro.org>
Date: Thu, 2 Aug 2018 13:28:31 -0400
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB48688BC84CBE8C74D095A46AC62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 45/76] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 08/02/2018 08:29 AM, Aleksandar Markovic wrote:
> Hi, Richard,
> 
> We are going to remove obsoleted helpers, that was just an honest mistake made in a rush.
> 
> For unprotected access to gpr, we are going to insert if(reg1 != 0) in two places.

Be careful that you do not eliminate side effects in the process.  This
includes things like check_dspr2, and any helper that sets overflow_flag or
carry_flag.

I cannot see how you will avoid that when adding only two if statements.


> However, it looks there is a bigger problem now in SCWP. QEMU crashes with this message:
> 
> /qemu/tcg/tcg.c:2862: tcg fatal error
> 
> This happens in user mode only, system mode case runs fine.
> 
> the problem seems to appear as a consequence of using tcg_gen_brcond_*(().
> 
> Do you have any idea what are we doing wrong here?

If you send me a binary that triggers this error, I'll look at it.


r~
