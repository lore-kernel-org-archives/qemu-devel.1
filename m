Received: from eggs.gnu.org ([2001:4830:134:3::10]:60016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaBX-0005jr-7H
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaBT-0000iO-69
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:19:55 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:44056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaBT-0000hv-0E
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:19:51 -0400
Received: by mail-ua0-x242.google.com with SMTP id k25-v6so11051739uao.11
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:19:50 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-51-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58672034-33ef-da97-3971-e3958ed09c91@linaro.org>
Date: Tue, 31 Jul 2018 15:19:44 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-51-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 50/76] target/mips: Adjust
 set_hflags_for_handler() for nanoMIPS
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
> From: James Hogan <james.hogan@mips.com>
> 
> We shouldn't clear M16 mode when entering an interrupt on nanoMIPS,
> otherwise we'll start interpreting the code as normal MIPS code.

Likewise re nanomips not setting M16.


r~
