Received: from eggs.gnu.org ([2001:4830:134:3::10]:45821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYJge-0001nR-U4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYJgb-0002CE-MA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:17:20 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fYJgb-0002AH-GO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:17:17 -0400
Received: by mail-pl0-x242.google.com with SMTP id 6-v6so1768116plb.0
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 16:17:17 -0700 (PDT)
Date: Thu, 28 Jun 2018 08:17:14 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180627231714.GM24595@lianli.shorne-pla.net>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-20-richard.henderson@linaro.org>
	<66ecea9b-bc0b-371a-b834-0a9c0a4685ad@amsat.org>
	<86822f08-52fb-7912-874b-b2f04d1d79b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86822f08-52fb-7912-874b-b2f04d1d79b4@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 19/22] target/openrisc: Add
 print_insn_or1k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 09:15:09AM -0700, Richard Henderson wrote:
> On 06/27/2018 09:03 AM, Philippe Mathieu-Daudé wrote:
> >> +INSN(nop,    "")
> > 
> > The nop previously displayed 'k', I suppose a left-over from sys/trap.
> 
> Yes, real nop has no argument.

Just for some history here, in case others are interested.  The nop in openrisc
does have an argument, but it is not used in real hardware.  It is a
hack/shortcut used by the old simulator to trigger debugging operations.  Its
used a lot in a few tests and even in the kernel, but I dont think we want to
carry it in QEMU.  I am happy to get rid of it.

 https://github.com/openrisc/or1ksim/blob/f75787f390cbd543b8ae49a2670ff338d6e9326a/cpu/or32/insnset.c#L766-L825

Also in: cpu/or1k/spr-defs.h

    #define NOP_NOP          0x0000      /* Normal nop instruction */
    #define NOP_EXIT         0x0001      /* End of simulation */
    #define NOP_REPORT       0x0002      /* Simple report */
    /*#define NOP_PRINTF       0x0003       Simprintf instruction (obsolete)*/
    #define NOP_PUTC         0x0004      /* JPB: Simputc instruction */
    #define NOP_CNT_RESET    0x0005	     /* Reset statistics counters */
    ...

-Stafford
