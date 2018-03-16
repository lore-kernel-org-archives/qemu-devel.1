Received: from eggs.gnu.org ([2001:4830:134:3::10]:38263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewoQn-0006ih-U6
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewoQn-0008N0-73
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewoQn-0008Mo-39
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:57 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Mar 2018 13:25:38 +0100
Message-Id: <20180316122540.28409-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] docker: update package list for fedora
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, berrange@redhat.com, f4bug@amsat.org

The first patch modernizes and completes the list of packages installed
in the Fedora docker image.  Both MinGW cross and native compilation are
switched to SDL 2.0 and GTK+ 3.0.

Paolo

Paolo Bonzini (2):
  docker: test-mingw: use SDL2 and GTK+3
  docker: fedora: include more build dependencies

 tests/docker/dockerfiles/fedora.docker | 67 ++++++++++++++++++++++++++++------
 tests/docker/test-mingw                |  4 +-
 2 files changed, 57 insertions(+), 14 deletions(-)

-- 
2.16.2
