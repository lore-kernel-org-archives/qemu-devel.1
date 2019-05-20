Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B56C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BAA20856
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BAA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35325 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShwB-0005vA-Ct
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:02:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShhi-0002Tx-37
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShhg-0006Cd-2B
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hShhd-0005wC-UQ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6402307D868;
	Mon, 20 May 2019 12:47:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 366A86085B;
	Mon, 20 May 2019 12:47:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 4D6F3A205; Mon, 20 May 2019 14:47:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 14:47:13 +0200
Message-Id: <20190520124716.30472-12-kraxel@redhat.com>
In-Reply-To: <20190520124716.30472-1-kraxel@redhat.com>
References: <20190520124716.30472-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 20 May 2019 12:47:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 11/14] tests/vm: freebsd autoinstall,
 using serial console
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of fetching the prebuilt image from patchew download the install
iso and prepare the image locally.  Install to disk, using the serial
console.  Create qemu user, configure ssh login.  Install packages
needed for qemu builds.

Note that freebsd package downloads are delivered as non-cachable
content, so I had to configure squid with "ignore-no-store
ignore-private ignore-reload" for pkgmir.geo.freebsd.org to make the
caching actually work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/freebsd | 179 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 10 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b0066017a617..eb029bdfede9 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -2,43 +2,202 @@
 #
 # FreeBSD VM image
 #
-# Copyright 2017 Red Hat Inc.
+# Copyright 2017-2019 Red Hat Inc.
 #
 # Authors:
 #  Fam Zheng <famz@redhat.com>
+#  Gerd Hoffmann <kraxel@redhat.com>
 #
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
 #
=20
 import os
+import re
 import sys
+import time
+import socket
 import subprocess
 import basevm
=20
 class FreeBSDVM(basevm.BaseVM):
     name =3D "freebsd"
     arch =3D "x86_64"
+
+    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/=
FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
+    csum =3D "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485=
fb99db"
+    size =3D "20G"
+    pkgs =3D [
+        # build tools
+        "git",
+        "pkgconf",
+        "bzip2",
+
+        # gnu tools
+        "bash",
+        "gmake",
+        "gsed",
+        "flex", "bison",
+
+        # libs: crypto
+        "gnutls",
+
+        # libs: images
+        "jpeg-turbo",
+        "png",
+
+        # libs: ui
+        "sdl2",
+        "gtk3",
+        "libxkbcommon",
+
+        # libs: opengl
+        "libepoxy",
+        "mesa-libs",
+    ]
+
     BUILD_SCRIPT =3D """
         set -e;
-        rm -rf /var/tmp/qemu-test.*
-        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        rm -rf /home/qemu/qemu-test.*
+        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
+        mkdir src build; cd src;
         tar -xf /dev/vtbd1;
-        ./configure {configure_opts};
+        cd ../build
+        ../src/configure --python=3Dpython3.6 {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
=20
+    def console_boot_serial(self):
+        self.console_wait_send("Autoboot", "3")
+        self.console_wait_send("OK", "set console=3Dcomconsole\n")
+        self.console_wait_send("OK", "boot\n")
+
     def build_image(self, img):
-        cimg =3D self._download_with_cache("http://download.patchew.org/=
freebsd-11.1-amd64.img.xz",
-                sha256sum=3D'adcb771549b37bc63826c501f05121a206ed3d9f55f=
49145908f7e1432d65891')
-        img_tmp_xz =3D img + ".tmp.xz"
+        self.print_step("Downloading install iso")
+        cimg =3D self._download_with_cache(self.link, sha256sum=3Dself.c=
sum)
         img_tmp =3D img + ".tmp"
-        sys.stderr.write("Extracting the image...\n")
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
+        iso =3D img + ".install.iso"
+        iso_xz =3D iso + ".xz"
+
+        self.print_step("Preparing iso and disk image")
+        subprocess.check_call(["cp", "-f", cimg, iso_xz])
+        subprocess.check_call(["xz", "-dvf", iso_xz])
+        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
+                               img_tmp, self.size])
+
+        self.print_step("Booting installer")
+        self.boot(img_tmp, extra_args =3D [
+            "-machine", "graphics=3Doff",
+            "-cdrom", iso
+        ])
+        self.console_init()
+        self.console_boot_serial()
+        self.console_wait_send("Console type",          "xterm\n")
+
+        # pre-install configuration
+        self.console_wait_send("Welcome",               "\n")
+        self.console_wait_send("Keymap Selection",      "\n")
+        self.console_wait_send("Set Hostname",          "freebsd\n")
+        self.console_wait_send("Distribution Select",   "\n")
+        self.console_wait_send("Partitioning",          "\n")
+        self.console_wait_send("Partition",             "\n")
+        self.console_wait_send("Scheme",                "\n")
+        self.console_wait_send("Editor",                "f")
+        self.console_wait_send("Confirmation",          "c")
+
+        self.print_step("Installation started now, this will take a whil=
e")
+
+        # post-install configuration
+        self.console_wait("New Password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+        self.console_wait("Retype New Password:")
+        self.console_send("%s\n" % self.ROOT_PASS)
+
+        self.console_wait_send("Network Configuration", "\n")
+        self.console_wait_send("IPv4",                  "y")
+        self.console_wait_send("DHCP",                  "y")
+        self.console_wait_send("IPv6",                  "n")
+        self.console_wait_send("Resolver",              "\n")
+
+        self.console_wait_send("Time Zone Selector",    "a\n")
+        self.console_wait_send("Confirmation",          "y")
+        self.console_wait_send("Time & Date",           "\n")
+        self.console_wait_send("Time & Date",           "\n")
+
+        self.console_wait_send("System Configuration",  "\n")
+        self.console_wait_send("System Hardening",      "\n")
+
+        # qemu user
+        self.console_wait_send("Add User Accounts", "y")
+        self.console_wait("Username")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait("Full name")
+        self.console_send("%s\n" % self.GUEST_USER)
+        self.console_wait_send("Uid",                   "\n")
+        self.console_wait_send("Login group",           "\n")
+        self.console_wait_send("Login group",           "\n")
+        self.console_wait_send("Login class",           "\n")
+        self.console_wait_send("Shell",                 "\n")
+        self.console_wait_send("Home directory",        "\n")
+        self.console_wait_send("Home directory perm",   "\n")
+        self.console_wait_send("Use password",          "\n")
+        self.console_wait_send("Use an empty password", "\n")
+        self.console_wait_send("Use a random password", "\n")
+        self.console_wait("Enter password:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait("Enter password again:")
+        self.console_send("%s\n" % self.GUEST_PASS)
+        self.console_wait_send("Lock out",              "\n")
+        self.console_wait_send("OK",                    "yes\n")
+        self.console_wait_send("Add another user",      "no\n")
+
+        self.console_wait_send("Final Configuration",   "\n")
+        self.console_wait_send("Manual Configuration",  "\n")
+        self.console_wait_send("Complete",              "\n")
+
+        self.print_step("Installation finished, rebooting")
+        self.console_boot_serial()
+
+        # setup qemu user
+        prompt =3D "$"
+        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
+        self.console_wait_send(prompt, "exit\n")
+
+        # setup root user
+        prompt =3D "root@freebsd:~ #"
+        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
+        self.console_sshd_config(prompt)
+
+        # setup serial console
+        self.console_wait(prompt)
+        self.console_send("echo 'console=3Dcomconsole' >> /boot/loader.c=
onf\n")
+
+        # setup boot delay
+        self.console_wait(prompt)
+        self.console_send("echo 'autoboot_delay=3D1' >> /boot/loader.con=
f\n")
+
+        # setup virtio-blk #1 (tarfile)
+        self.console_wait(prompt)
+        self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\=
n")
+
+        self.print_step("Configuration finished, rebooting")
+        self.console_wait_send(prompt, "reboot\n")
+        self.console_wait("login:")
+        self.wait_ssh()
+
+        self.print_step("Installing packages")
+        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
+
+        # shutdown
+        self.ssh_root(self.poweroff)
+        self.console_wait("Uptime:")
+        self.wait()
+
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
+        os.remove(iso)
+        self.print_step("All done")
=20
 if __name__ =3D=3D "__main__":
     sys.exit(basevm.main(FreeBSDVM))
--=20
2.18.1


