Received: from eggs.gnu.org ([2001:4830:134:3::10]:42192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI3-0004hE-T6
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI2-0007uf-NW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:27 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZI2-0007uE-Ha
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:26 -0500
Received: by mail-wr0-x242.google.com with SMTP id k9so4585906wre.9
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:52 +0100
Message-Id: <1518523252-49106-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 48/48] travis: use libgcc-4.8-dev (libgcc-6-dev
 is not available on Ubuntu 14.04)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Travis image is based on Ubuntu Trusty (14.04), since d83414e1fd1 we get:

  $ sudo -E \
    apt-get -yq --no-install-suggests --no-install-recommends --force-yes \
      install \
        libaio-dev libattr1-dev libbrlapi-dev libcap-ng-dev libgcc-6-dev \
        libgnutls-dev libgtk-3-dev libiscsi-dev liblttng-ust-dev \
        libncurses5-dev libnfs-dev libnss3-dev libpixman-1-dev libpng12-dev \
        librados-dev libsdl1.2-dev libseccomp-dev libspice-protocol-dev \
        libspice-server-dev libssh2-1-dev liburcu-dev libusb-1.0-0-dev \
        libvte-2.90-dev sparse uuid-dev
  Reading package lists...
  Building dependency tree...
  Reading state information...
  E: Unable to locate package libgcc-6-dev

Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 0dd5020..79377c8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -13,7 +13,7 @@ addons:
       - libattr1-dev
       - libbrlapi-dev
       - libcap-ng-dev
-      - libgcc-6-dev
+      - libgcc-4.8-dev
       - libgnutls-dev
       - libgtk-3-dev
       - libiscsi-dev
-- 
1.8.3.1
