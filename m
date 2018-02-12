Received: from eggs.gnu.org ([2001:4830:134:3::10]:36670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elJ8C-0006ZR-Ef
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elJ89-00026X-Gn
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:47:12 -0500
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:45602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elJ89-00025h-8d
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:47:09 -0500
Received: by mail-vk0-x244.google.com with SMTP id j204so9391668vke.12
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 10:47:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Feb 2018 15:46:50 -0300
Message-Id: <20180212184650.24039-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] travis: use libgcc-4.8-dev (libgcc-6-dev is
 not available on Ubuntu 14.04)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since libgcc-dev is used, Travis jobs take much longer.

 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 0dd5020552..79377c8de0 100644
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
2.16.1
