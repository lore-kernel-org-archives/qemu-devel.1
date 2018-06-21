Received: from eggs.gnu.org ([2001:4830:134:3::10]:60527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fVxKp-0007MG-Gb
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fVxKj-0005ZZ-Sj
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:01:03 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fVxKj-0005ZK-Lw
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:00:57 -0400
Received: by mail-pg0-x241.google.com with SMTP id e11-v6so1275195pgq.0
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 04:00:57 -0700 (PDT)
Date: Thu, 21 Jun 2018 20:00:53 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180621110053.GD24595@lianli.shorne-pla.net>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/22] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Jun 18, 2018 at 08:40:24AM -1000, Richard Henderson wrote:
> This is almost a grab-bag of little improvements to the port.
> 
> patches 1-3:
>   Fix singlestepping for gdbstub.  This has apparently never
>   worked, as the first commit has the same bug of not advancing
>   the pc when stepping.
> 
> patches 4:
>   Link more TBs.
> 
> patches 5-6:
>   Exit the TB after l.mtspr insns.  In particular, storing to
>   SR changes exception state so we want to return to the main
>   loop to recognize any pending interrupts immediately.
> 
> patches 8-18:
>   Reorganize TLB handling.  There is a fundamental bug that is
>   fixed in patch 13.  However the bug has been hidden by extra
>   TLB flushing elsewhere in the port.  I remove some unnecessary
>   indirection that the port inherited from somewhere -- probably
>   the MIPS port.  Finally, I present the QEMU TLB a unified view
>   of the OpenRISC split I/D TLB.
> 
> patch 19:
>   Split out disassembly from translation.
> 
> patch 20:
>   Add qemu-or1k to qemu-binfmt-conf.sh.
> 
> patches 21-22:
>   Implement signal handling for linux-user.

Hi Richard,

Thanks for these, I think there are a few white space issues throughout.  Do you
mind if I take these and clean them up (indent with space) and work on the DSX
and Interrupt issue I mentioned earlier?

I can submit all during the next merge window.

Let me know if you have other plans or you think they can go right away.

-Stafford
