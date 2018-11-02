Received: from eggs.gnu.org ([2001:4830:134:3::10]:34840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gINKU-000636-Hc
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gINKP-0003hh-HA
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:28:50 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:43291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gINKP-0003gq-0N
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:28:45 -0400
Received: by mail-lj1-x241.google.com with SMTP id g26-v6so220633lja.10
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 17:28:44 -0700 (PDT)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Fri,  2 Nov 2018 03:28:16 +0300
Message-Id: <20181102002818.8568-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH 0/2] contrib/elf2dmp: elf2dmp for Windows hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

In most cases, it is more convenient to convert a dump on the same machine
on which the analysis is performed. Because of WinDbg, the analysis of guest
Windows problems needs Windows host anyway, so it is useful to have dump
convertion tool near the debugger.
After these patches elf2dmp can be built both for Linux and Windows hosts.

Viktor Prutyanov (2):
  contrib/elf2dmp: use GLib file mapping
  contrib/elf2dmp: elf2dmp for Windows hosts

 Makefile                      |  4 ++--
 contrib/elf2dmp/Makefile.objs |  2 +-
 contrib/elf2dmp/addrspace.c   |  7 ++++---
 contrib/elf2dmp/file_map.c    | 30 ++++++++++++++++++++++++++++++
 contrib/elf2dmp/file_map.h    | 21 +++++++++++++++++++++
 contrib/elf2dmp/kdbg.h        | 12 ++++++++----
 contrib/elf2dmp/main.c        | 27 +++++++++++++++------------
 contrib/elf2dmp/pdb.c         | 32 ++++++++------------------------
 contrib/elf2dmp/pdb.h         |  7 +++++--
 contrib/elf2dmp/pe.h          |  6 ++++--
 contrib/elf2dmp/qemu_elf.c    | 34 ++++++++++++----------------------
 contrib/elf2dmp/qemu_elf.h    | 15 ++++++++-------
 12 files changed, 118 insertions(+), 79 deletions(-)
 create mode 100644 contrib/elf2dmp/file_map.c
 create mode 100644 contrib/elf2dmp/file_map.h

-- 
2.17.2
