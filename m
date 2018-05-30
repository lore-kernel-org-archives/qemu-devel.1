Received: from eggs.gnu.org ([2001:4830:134:3::10]:47691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAH2-0001ri-Dd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAGx-0003Dd-BQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:12:56 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fOAGx-0003DF-43
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:12:51 -0400
Received: by mail-pg0-x244.google.com with SMTP id w12-v6so7593495pgc.6
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:12:50 -0700 (PDT)
Date: Thu, 31 May 2018 08:12:47 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180530231247.GS3652@lianli.shorne-pla.net>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527141324.11937-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/20] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, davidsondfgl@gmail.com

On Sun, May 27, 2018 at 09:13:04AM -0500, Richard Henderson wrote:
> This is almost a grab-bag of little improvements to the port.
> 
> patches 1-3:
>   Fix singlestepping for gdbstub.  This has apparently never
>   worked, as the first commit has the same bug of not advancing
>   the pc when stepping.

This is a big cleanup, thanks.

> patches 4-5:
>   Exit the TB after l.mtspr insns.  In particular, storing to
>   SR changes exception state so we want to return to the main
>   loop to recognize any pending interrupts immediately.

CC'ing Davidson

This might explain part of the problem he was seeing with setting PICMR.

> patches 6-19:
>   Reorganize TLB handling.  There is a fundamental bug that is
>   fixed in patch 13.  However the bug has been hidden by extra
>   TLB flushing elsewhere in the port.  I remove some unnecessary
>   indirection that the port inherited from somewhere -- probably
>   the MIPS port.  Finally, I present the QEMU TLB a unified view
>   of the OpenRISC split I/D TLB.
> 
> patch 20:
>   Split out disassembly from translation.
> 
> patch 21:
>   Add qemu-or1k to qemu-binfmt-conf.sh.

Again, I have nothing in my queue if you can send the pull request it would be
appreciated, if not let me know.

I will reply on the individual patches too, Give me some time, I reviewed on my
phone.

Thanks,

-Stafford
