Received: from eggs.gnu.org ([2001:4830:134:3::10]:48936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM63B-0003bJ-Jn
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM63A-0002zT-LY
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:18:05 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:42305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fM63A-0002z1-DG
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:18:04 -0400
Received: by mail-oi0-x229.google.com with SMTP id t27-v6so3625290oij.9
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 23:18:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <78dbf5ad-a067-0e0e-a073-1b854109df7e@twiddle.net>
References: <78dbf5ad-a067-0e0e-a073-1b854109df7e@twiddle.net>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 25 May 2018 18:18:03 +1200
Message-ID: <CAHNT7Nvoz0z_vDGLhSmHahjFQqQTwDq3h8ay5qvUsT1mujuOjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RISC-V] Coverity 1390849, Logically dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, May 25, 2018 at 9:54 AM, Richard Henderson <rth@twiddle.net> wrote:

> In the latest Coverity scan, it reports
>
> 405    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
> 406        return 0;
> 407    }
> 408#if defined(TARGET_RISCV32)
> 409    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
>
> CID 1390849 (#1 of 1): Logically dead code (DEADCODE)
> dead_error_line: Execution cannot reach this statement: return 0U;.
>
> 410        return 0;
> 411    }
> 412#endif
>
>
> I believe the condition at op_helper.c:409 should be testing
> CSR_MHPMCOUNTER3H
> and CSR_MHPMCOUNTER31H.  Must run now, otherwise I'd also send the trivial
> patch.


Thanks! Yes indeed they should be the H versions.

I will send the trivial patch...
