Received: from eggs.gnu.org ([209.51.188.92]:58463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gofwC-0001LF-Q7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gofwA-00078U-RL
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:49:16 -0500
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:45153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gofw8-000777-P7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:49:13 -0500
Received: by mail-vs1-xe43.google.com with SMTP id x28so13341081vsh.12
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 18:49:11 -0800 (PST)
MIME-Version: 1.0
From: Jim Wilson <jimw@sifive.com>
Date: Tue, 29 Jan 2019 18:49:00 -0800
Message-ID: <CAFyWVaZ5tQq4eGaZiPBq7172PB_x3JCqV6c2xo=wSJdgbJakKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH 0/5 v3] RISC-V: Add gdb xml files and gdbstub
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Jim Wilson <jimw@sifive.com>

This is the 3rd version of the patch set, updated as per the review
from Richard and Alistair, and updated for current top of tree.  Parts
1 and 2 are the same.  Part 3 is smaller because some of it was moved
to part 5.  Part 5 is bigger because it received part of part 3.
Parts 4 and 5 have changed because the csr support was rewritten.  The
illegal instruction traps are no longer inside the csr support code,
but it still has mode checks that I need to disable, so I still need a
debugger mode, but it doesn't do as much as before.  Also, what was
one function is now about one hundred functions, so rather than add a
debugger parameter to lots of functions that don't need it, I put it
in the CPURISCVState struct.  This also helps fix a bug, because
debugger mode is only appropriate for system qemu, and should not be
enabled for user qemu.  The new patch set gets this right.  As a
result of this, part 4 also ends up smaller, and part 5 is rewritten a
bit to use the new interface to the csr support.  Otherwise it is
effectively the same code as before.

Jim
