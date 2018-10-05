Received: from eggs.gnu.org ([2001:4830:134:3::10]:41357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8PkH-0003Ag-Le
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8Pk1-0008KV-0N
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g8Pk0-0008Jf-Mo
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:00 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  5 Oct 2018 15:01:46 +0200
Message-Id: <1538744508-17108-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Use target_words_bigendian() for
 generic-loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>

Provide a proper prototype for target_words_bigendian(), and use
this function in the generic-loader to be able to move it to common-obj.

v2:
 - Split up the single patch into two
 - Add a proper comment in front of the prototype in the header

Thomas Huth (2):
  cpu: Provide a proper prototype for target_words_bigendian() in a
    header
  hw/core/generic-loader: Compile only once, not for each target

 exec.c                   |  5 -----
 hw/core/Makefile.objs    |  2 +-
 hw/core/generic-loader.c |  6 +-----
 hw/virtio/virtio.c       |  1 -
 include/qom/cpu.h        | 11 +++++++++++
 qom/cpu.c                |  1 -
 6 files changed, 13 insertions(+), 13 deletions(-)

-- 
1.8.3.1
