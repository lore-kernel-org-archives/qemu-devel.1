Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkrad-0000Gs-B5
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkraZ-0002cu-By
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:54:59 -0400
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:33235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkraZ-0002cC-5w
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:54:55 -0400
Received: by mail-vk0-x229.google.com with SMTP id y70-v6so9323176vkc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 06:54:54 -0700 (PDT)
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
Date: Wed, 1 Aug 2018 09:54:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180801133922.GC2371@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] target/mips: Initial support for MIPS R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On 08/01/2018 09:39 AM, Fredrik Noring wrote:
>  Can QEMU be instructed to emulate
> the FPU only for Linux user space programs as opposed to hardware emulation?

Yes, that can be done.  I would suggest something like

/*
 * Hardware traps to the operating system for emulation.
 * For user-only, qemu is the operating system, so we
 * emulate the trap and emulate by simply emulating the
 * instruction directly.
 */
#ifdef CONFIG_USER_ONLY
# define CP0C1_FP_USER_ONLY  (1 << CP0C1_FP)
#else
# define CP0C1_FP_USER_ONLY  0
#endif

and include that in your initialization of CP0_Config1.


r~
