Received: from eggs.gnu.org ([2001:4830:134:3::10]:46543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5S-0005lf-1N
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5M-0002p3-FQ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:16 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gZn5G-0002dq-DS
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:10 -0500
Received: by mail-lf1-x144.google.com with SMTP id l10so52147lfh.9
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:25:04 -0800 (PST)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Thu, 20 Dec 2018 04:24:35 +0300
Message-Id: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH v2 0/6] contrib/elf2dmp: elf2dmp for Windows
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

In most cases, it is more convenient to convert a dump on the same machine
on which the analysis is performed. Because of WinDbg, the analysis of guest
Windows problems needs Windows host anyway, so it is useful to have dump
convertion tool near the debugger.
After these patches elf2dmp can be built both for Linux and Windows (x86
and x86_64) hosts.

Viktor Prutyanov (6):
  contrib/elf2dmp: fix elf.h including
  contrib/elf2dmp: use GLib in ELF processing
  contrib/elf2dmp: use GLib in PDB processing
  contrib/elf2dmp: fix structures definitions
  contrib/elf2dmp: fix printf format
  configure: enable elf2dmp build for Windows hosts

 Makefile                   |  4 ++--
 configure                  |  4 ++--
 contrib/elf2dmp/kdbg.h     | 12 ++++++++----
 contrib/elf2dmp/main.c     | 27 +++++++++++++++------------
 contrib/elf2dmp/pdb.c      | 33 +++++++++++----------------------
 contrib/elf2dmp/pdb.h      |  4 +++-
 contrib/elf2dmp/pe.h       |  6 ++++--
 contrib/elf2dmp/qemu_elf.c | 27 ++++++++-------------------
 contrib/elf2dmp/qemu_elf.h | 10 +++++-----
 9 files changed, 58 insertions(+), 69 deletions(-)

-- 
2.17.2
