Received: from eggs.gnu.org ([2001:4830:134:3::10]:60372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f940b-0003tt-8M
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f940X-0007ER-8j
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:29:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f940X-0007EG-3n
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:29:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 19 Apr 2018 09:29:11 +0200
Message-ID: <87lgdjvem0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] configure --help lacks explanation of
 xen-pci-passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

$ ./configure --help | grep -C 3 xen-pci-passthrough
  virtfs          VirtFS
  mpath           Multipath persistent reservation passthrough
  xen             xen backend driver support
  xen-pci-passthrough
  brlapi          BrlAPI (Braile)
  curl            curl connectivity
  membarrier      membarrier system call (for Linux 4.14+ or Windows)

This is the only --enable thing without an explanation.  Okay, many of
the explanations suck, but that's no excuse.  Xen guys, please provide
one.
