Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB2C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 14:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CF520714
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 14:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CF520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unixzen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEvlL-0002hR-O6
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 10:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kallisti5@unixzen.com>)
 id 1kEvko-0002Ex-GU
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 10:34:50 -0400
Received: from mx.dal1.terarocket.io ([108.61.222.170]:37578)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kallisti5@unixzen.com>) id 1kEvkm-0002rj-G8
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 10:34:50 -0400
Received: from eris.discord.local (cpe-70-112-18-26.austin.res.rr.com
 [70.112.18.26])
 by mx.dal1.terarocket.io (Postfix) with ESMTPSA id D38DF5E765;
 Sun,  6 Sep 2020 14:34:44 +0000 (UTC)
From: Alexander von Gluck IV <kallisti5@unixzen.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/vm: Add Haiku test based on their vagrant images
Date: Sun,  6 Sep 2020 09:34:39 -0500
Message-Id: <20200906143439.1924930-1-kallisti5@unixzen.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=108.61.222.170;
 envelope-from=kallisti5@unixzen.com; helo=mx.dal1.terarocket.io
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 10:34:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, PDS_BTC_ID=0.499,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexander von Gluck IV <kallisti5@unixzen.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander von Gluck IV <kallisti5@unixzen.com>
---
 tests/keys/vagrant     |  27 +++++++++
 tests/keys/vagrant.pub |   1 +
 tests/vm/basevm.py     |   5 +-
 tests/vm/haiku.x86_64  | 121 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 2 deletions(-)
 create mode 100644 tests/keys/vagrant
 create mode 100644 tests/keys/vagrant.pub
 create mode 100755 tests/vm/haiku.x86_64

diff --git a/tests/keys/vagrant b/tests/keys/vagrant
new file mode 100644
index 0000000000..7d6a083909
--- /dev/null
+++ b/tests/keys/vagrant
@@ -0,0 +1,27 @@
+-----BEGIN RSA PRIVATE KEY-----
+MIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzI
+w+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoP
+kcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2
+hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NO
+Td0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW
+yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQIBIwKCAQEA4iqWPJXtzZA68mKd
+ELs4jJsdyky+ewdZeNds5tjcnHU5zUYE25K+ffJED9qUWICcLZDc81TGWjHyAqD1
+Bw7XpgUwFgeUJwUlzQurAv+/ySnxiwuaGJfhFM1CaQHzfXphgVml+fZUvnJUTvzf
+TK2Lg6EdbUE9TarUlBf/xPfuEhMSlIE5keb/Zz3/LUlRg8yDqz5w+QWVJ4utnKnK
+iqwZN0mwpwU7YSyJhlT4YV1F3n4YjLswM5wJs2oqm0jssQu/BT0tyEXNDYBLEF4A
+sClaWuSJ2kjq7KhrrYXzagqhnSei9ODYFShJu8UWVec3Ihb5ZXlzO6vdNQ1J9Xsf
+4m+2ywKBgQD6qFxx/Rv9CNN96l/4rb14HKirC2o/orApiHmHDsURs5rUKDx0f9iP
+cXN7S1uePXuJRK/5hsubaOCx3Owd2u9gD6Oq0CsMkE4CUSiJcYrMANtx54cGH7Rk
+EjFZxK8xAv1ldELEyxrFqkbE4BKd8QOt414qjvTGyAK+OLD3M2QdCQKBgQDtx8pN
+CAxR7yhHbIWT1AH66+XWN8bXq7l3RO/ukeaci98JfkbkxURZhtxV/HHuvUhnPLdX
+3TwygPBYZFNo4pzVEhzWoTtnEtrFueKxyc3+LjZpuo+mBlQ6ORtfgkr9gBVphXZG
+YEzkCD3lVdl8L4cw9BVpKrJCs1c5taGjDgdInQKBgHm/fVvv96bJxc9x1tffXAcj
+3OVdUN0UgXNCSaf/3A/phbeBQe9xS+3mpc4r6qvx+iy69mNBeNZ0xOitIjpjBo2+
+dBEjSBwLk5q5tJqHmy/jKMJL4n9ROlx93XS+njxgibTvU6Fp9w+NOFD/HvxB3Tcz
+6+jJF85D5BNAG3DBMKBjAoGBAOAxZvgsKN+JuENXsST7F89Tck2iTcQIT8g5rwWC
+P9Vt74yboe2kDT531w8+egz7nAmRBKNM751U/95P9t88EDacDI/Z2OwnuFQHCPDF
+llYOUI+SpLJ6/vURRbHSnnn8a/XG+nzedGH5JGqEJNQsz+xT2axM0/W/CRknmGaJ
+kda/AoGANWrLCz708y7VYgAtW2Uf1DPOIYMdvo6fxIB5i9ZfISgcJ/bbCUkFrhoH
++vq/5CIWxCPp0f85R4qxxQ5ihxJ0YDQT9Jpx4TMss4PSavPaBH3RXow5Ohe+bYoQ
+NE5OgEXk2wVfZczCZpigBKbKZHNYcelXtTt/nP3rsCuGcM4h53s=
+-----END RSA PRIVATE KEY-----
diff --git a/tests/keys/vagrant.pub b/tests/keys/vagrant.pub
new file mode 100644
index 0000000000..18a9c00fd5
--- /dev/null
+++ b/tests/keys/vagrant.pub
@@ -0,0 +1 @@
+ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3fac20e929..00f1d5ca8d 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -44,6 +44,7 @@ DEFAULT_CONFIG = {
     'machine'         : 'pc',
     'guest_user'      : "qemu",
     'guest_pass'      : "qemupass",
+    'root_user'       : "root",
     'root_pass'       : "qemupass",
     'ssh_key_file'    : SSH_KEY_FILE,
     'ssh_pub_key_file': SSH_PUB_KEY_FILE,
@@ -245,13 +246,13 @@ class BaseVM(object):
         return self._ssh_do(self._config["guest_user"], cmd, False)
 
     def ssh_root(self, *cmd):
-        return self._ssh_do("root", cmd, False)
+        return self._ssh_do(self._config["root_user"], cmd, False)
 
     def ssh_check(self, *cmd):
         self._ssh_do(self._config["guest_user"], cmd, True)
 
     def ssh_root_check(self, *cmd):
-        self._ssh_do("root", cmd, True)
+        self._ssh_do(self._config["root_user"], cmd, True)
 
     def build_image(self, img):
         raise NotImplementedError
diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
new file mode 100755
index 0000000000..9777722f51
--- /dev/null
+++ b/tests/vm/haiku.x86_64
@@ -0,0 +1,121 @@
+#!/usr/bin/env python3
+#
+# Haiku VM image
+#
+# Copyright 2020 Haiku, Inc.
+#
+# Authors:
+#  Alexander von Gluck IV <kallisti5@unixzen.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import re
+import sys
+import time
+import socket
+import subprocess
+import basevm
+
+VAGRANT_KEY_FILE = os.path.join(os.path.dirname(__file__),
+    "..", "keys", "vagrant")
+
+VAGRANT_PUB_KEY_FILE = os.path.join(os.path.dirname(__file__),
+    "..", "keys", "vagrant.pub")
+
+HAIKU_CONFIG = {
+    'cpu'             : "max",
+    'machine'         : 'pc',
+    'guest_user'      : "vagrant",
+    'guest_pass'      : "",
+    'root_user'       : "vagrant",
+    'root_pass'       : "",
+    'ssh_key_file'    : VAGRANT_KEY_FILE,
+    'ssh_pub_key_file': VAGRANT_PUB_KEY_FILE,
+    'memory'          : "4G",
+    'extra_args'      : [],
+    'qemu_args'       : "-device VGA",
+    'dns'             : "",
+    'ssh_port'        : 0,
+    'install_cmds'    : "",
+    'boot_dev_type'   : "block",
+    'ssh_timeout'     : 1,
+}
+
+class HaikuVM(basevm.BaseVM):
+    name = "haiku"
+    arch = "x86_64"
+
+    link = "https://app.vagrantup.com/haiku-os/boxes/r1beta2-x86_64/versions/20200702/providers/libvirt.box"
+    csum = "41c38b316e0cbdbc66b5dbaf3612b866700a4f35807cb1eb266a5bf83e9e68d5"
+
+    poweroff = "shutdown"
+
+    requirements = [
+        "devel:libbz2",
+        "devel:libcapstone",
+        "devel:libcurl",
+        "devel:libfdt",
+        "devel:libgcrypt",
+        "devel:libgl",
+        "devel:libglib_2.0",
+        "devel:libgnutls",
+        "devel:libgpg_error",
+        "devel:libintl",
+        "devel:libjpeg",
+        "devel:liblzo2",
+        "devel:libncursesw",
+        "devel:libnettle",
+        "devel:libpixman_1",
+        "devel:libpng16",
+        "devel:libsdl2_2.0",
+        "devel:libsnappy",
+        "devel:libssh2",
+        "devel:libtasn1",
+        "devel:libusb_1.0",
+        "devel:libz",
+        "setuptools_python3"
+    ]
+
+    # https://dev.haiku-os.org/ticket/16512 virtio disk1 shows up as 0 (reversed order)
+    BUILD_SCRIPT = """
+        set -e;
+        rm -rf /tmp/qemu-test.*
+        cd $(mktemp -d /tmp/qemu-test.XXXXXX);
+        mkdir src build; cd src;
+        tar -xf /dev/disk/virtual/virtio_block/0/raw;
+        cd ../build
+        ../src/configure --python=python3 {configure_opts};
+        make --output-sync -j{jobs} {target} {verbose};
+    """
+
+    def build_image(self, img):
+        self.print_step("Downloading disk image")
+        cvg = self._download_with_cache(self.link, sha256sum=self.csum)
+        cgz = cvg + ".tar.gz"
+        img_tmp = "./box.img"
+
+        self.print_step("Preparing disk image")
+
+        subprocess.check_call(["cp", "-f", cvg, cgz])
+        subprocess.check_call(["tar", "xvzf", cgz, img_tmp])
+        subprocess.check_call(["chmod", "666", img_tmp])
+
+        self.boot(img_tmp)
+
+        # Wait for ssh to be available.
+        self.wait_ssh(wait_root=True, cmd="exit 0")
+
+        # Install packages
+        self.ssh_root("pkgman install -y %s" % " ".join(self.requirements))
+        self.graceful_shutdown()
+
+        if os.path.exists(cgz):
+            os.remove(cgz)
+        subprocess.check_call(["mv", img_tmp, img])
+        self.print_step("All done")
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(HaikuVM, config=HAIKU_CONFIG))
-- 
2.26.2


