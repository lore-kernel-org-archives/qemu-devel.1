Received: from eggs.gnu.org ([208.118.235.92]:48330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gd0U7-0004zz-Sn
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gd0Gf-00056h-Cl
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:06:10 -0500
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:40852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gd0Ge-00056K-VX
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:06:09 -0500
Received: by mail-vs1-xe44.google.com with SMTP id z3so13702652vsf.7
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 14:06:08 -0800 (PST)
MIME-Version: 1.0
From: Jim Wilson <jimw@sifive.com>
Date: Fri, 28 Dec 2018 14:05:57 -0800
Message-ID: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH 0/5 v2] RISC-V: Add gdb xml files and gdbstub
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

This is the second version of the patch set.  I haven't gotten any bug
reports for the patches in the several weeks that they have been
available, and no review yet, so the only significant difference from
the first version is that I ran them through checkpatch to fix style
issues, and I sent them to the right mailing list this time.

With these patches, I can run system qemu with -s -S, connect to it
with gdb, and then print any integer, FP, or CSR register.  This
support is currently broken.

The first two patches in the series are just dropping in xml files
from gdb unchanged, with configure support to point at them.  The next
two patches are the inconvenient stuff.  The gdb CSR files are in
documentation order not numerical order, so I need an array to map the
gdb numbers to the actual hardware numbers.  The gdb files should
probably be improved, but I don't know when that will happen.  That is
the third patch.  The fourth patch is to disable all of the illegal
instruction checks when accessing CSRs from the debugger, as it needs
to be able to access them without traps.  The last patch adds the
gdbstub support to use the new xml files which is pretty simple,
though there is an unanswered question in there about what to do with
the FP registers.  Should we try to configure them based on the
target?  Right now I just always enable them which is the simple
solution.  I'm not sure if enabling them based on the target will even
work with gdb or not.

Jim
