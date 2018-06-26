Received: from eggs.gnu.org ([2001:4830:134:3::10]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fXfWj-0008T8-Q7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fXfWg-0002UI-ME
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:24:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fXfWg-0002To-Ew
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:24:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id w137-v6so199959wmw.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 21:24:22 -0700 (PDT)
Date: Tue, 26 Jun 2018 06:24:19 +0200
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20180626062419.66ef898e@thl530.multi.box>
In-Reply-To: <20180625203559.21370-2-laurent@vivier.eu>
References: <20180625203559.21370-1-laurent@vivier.eu>
	<20180625203559.21370-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] target/m68k: correctly disassemble
 move16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

Am Mon, 25 Jun 2018 22:35:59 +0200
schrieb Laurent Vivier <laurent@vivier.eu>:

> "move16 %a0@+,%a1@" and "fmovel (cpid=3) %a0@-,%fpcr"
> share the same opcode.
> 
> To fix that, backport the fix from binutils:
> 
>   2005-11-10  Andreas Schwab  <schwab@suse.de>
> 
>      * m68k-dis.c (print_insn_m68k): Only match FPU insns with
>      coprocessor ID 1.
> 
> Reported-by: Thomas Huth <huth@tuxfamily.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  disas/m68k.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Thank you very much, Laurent, this indeed fixes the problem for me!

Tested-by: Thomas Huth <huth@tuxfamily.org>
