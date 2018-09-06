Received: from eggs.gnu.org ([2001:4830:134:3::10]:59274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxn8I-00087v-JP
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxn5B-0007Kx-Mo
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:44:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fxn5B-0007FE-HH
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:43:57 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  6 Sep 2018 13:43:36 +0800
Message-Id: <20180906054340.28988-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] tests: VM build in OpenBSD 6.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Brad Smith <brad@comstyle.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

In this new version:

    - Include the virtio fix by Paolo so that it's easier to test this series.
    - Improve the slirp patch on input validation and buffer overflow. [Thomas]
    - Use OpenBSD 6.3 image; Use guestfwd and tftp-server-name.

Thanks to the loose dependency, the three parts (patch 1; patches 2+3; patch 4)
can go to individual maintainers if desired.

Fam Zheng (3):
  slirp: Add sanity check for str option length
  slirp: Implement RFC2132 TFTP server name
  tests: vm: auto_install OpenBSD

Paolo Bonzini (1):
  virtio: update MemoryRegionCaches when guest negotiates features

 hw/virtio/virtio.c | 15 +++++++--
 net/slirp.c        | 21 ++++++++++--
 qapi/net.json      |  5 ++-
 qemu-options.hx    |  7 +++-
 slirp/bootp.c      | 45 ++++++++++++++++++++------
 slirp/bootp.h      |  1 +
 slirp/libslirp.h   |  1 +
 slirp/slirp.c      |  2 ++
 slirp/slirp.h      |  1 +
 tests/vm/basevm.py |  6 ++--
 tests/vm/openbsd   | 81 ++++++++++++++++++++++++++++++++++++++++------
 11 files changed, 156 insertions(+), 29 deletions(-)

-- 
2.17.1
