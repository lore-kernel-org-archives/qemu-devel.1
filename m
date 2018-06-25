Received: from eggs.gnu.org ([2001:4830:134:3::10]:53763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXPL4-0006Wn-Ii
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXPL0-0003Pt-DY
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:07:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fXPL0-0003Pj-66
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:07:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id z137-v6so3790295wmc.0
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:07:13 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 25 Jun 2018 14:07:04 +0300
Message-Id: <20180625110706.23332-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC v2 0/2] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Amnon Ilan <ailan@redhat.com>

From: Sameeh Jubran <sjubran@redhat.com>

The Berkeley Packet Filter has been in the kernel for a while now and I
think it is time that it is introduced to Qemu. This patch is an
infrastructure for any future usage of the BPF in Qemu.

It is important to note that the tun driver had started supporting using
BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
My plan is to use the bpf support from within virtio-net in order to set
a bpf steering program to the tun device which would allow virtio-net to
support RSS feature https://lists.oasis-open.org/archives/virtio-dev/201805/msg00024.html

Difference from v1:
* Used libbpf library provided by linux
* Added a configure option
* Added a sample patch with demonstrates how to use the libbpf library
  from within virtio-net. This patch should not be applied! It is for
  demonstration purposes only

The libbpf can be manually installed from the Linux source tree by running make
tools/bpf and make tools/bpf_install from the top level directory.

Please share your thoughts :)

v1 - https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05307.html

Sameeh Jubran (2):
  Add bpf support to qemu
  virtio-net: Example Patch for using BPF

 MAINTAINERS                             |    6 +
 configure                               |   46 +
 hw/net/Makefile.objs                    |    4 +
 hw/net/virtio-net.c                     |    4 +
 include/standard-headers/linux/libbpf.h |  284 ++++
 linux-headers/linux/bpf.h               | 2669 +++++++++++++++++++++++++++++++
 scripts/update-linux-headers.sh         |   11 +-
 7 files changed, 3021 insertions(+), 3 deletions(-)
 create mode 100644 include/standard-headers/linux/libbpf.h
 create mode 100644 linux-headers/linux/bpf.h

-- 
2.13.6
