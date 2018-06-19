Received: from eggs.gnu.org ([2001:4830:134:3::10]:48407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVGaJ-0002Le-MM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVGaF-0005HI-GS
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:22:11 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fVGaF-0005G2-5S
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:22:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id l15-v6so18841516wmc.1
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:22:06 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 19 Jun 2018 16:21:59 +0300
Message-Id: <20180619132200.12320-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

The Berkeley Packet Filter has been in the kernel for a while now and I
think it is time that it is introduced to Qemu. This patch is an
infrastructure for any future usage of the BPF in Qemu.

It is important to note that the tun driver had started supporting using
BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).

At first, instead of adding the syscall wrappers, I wanted to integrate libbpf
library which resides in the Linux source tree under tools/lib/bpf. It appears
to be that by default it compiles to x64 on x64 arch - which can't be
integrated into Qemu  - and my attempts to compile the 32 bit versions have
failed. What's more interesting is that the vendors don't provide this library
in any package, which makes this library a nasty dependency.

Please share your thoughts :)

Sameeh Jubran (1):
  Add BPF support to qemu

 MAINTAINERS                     |   7 +
 bpf/Makefile.objs               |   1 +
 bpf/bpf_syscall.c               |  98 ++++++
 include/bpf/bpf_syscall.h       |  35 +++
 linux-headers/linux/bpf.h       | 673 ++++++++++++++++++++++++++++++++++++++++
 scripts/update-linux-headers.sh |   3 +-
 6 files changed, 816 insertions(+), 1 deletion(-)
 create mode 100644 bpf/Makefile.objs
 create mode 100644 bpf/bpf_syscall.c
 create mode 100644 include/bpf/bpf_syscall.h
 create mode 100644 linux-headers/linux/bpf.h

-- 
2.13.6
