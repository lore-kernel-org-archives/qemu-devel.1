Received: from eggs.gnu.org ([209.51.188.92]:37318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz2B-0005Ws-RC
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz29-0006CS-M5
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz29-0006Am-Cg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:41 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 23 Apr 2019 19:15:17 +0200
Message-Id: <20190423171520.4511-10-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/12] pc-bios: document the edk2 firmware
 images; add firmware descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

Update the README file with information on the images added previously,
and provide firmware descriptor documents that conform to
"docs/interop/firmware.json".

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Phil's R-b
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - refer to "edk2-*.fd.bz2" rather than "edk2-*.fd.xz" in the README
      [Peter]
   =20
    - pick up Igor's T-b still
   =20
    v2:
   =20
    - refer to "edk2-*.fd.xz" rather than "edk2-*.fd" in the README hunk
      [Dan, Michael, Phil]
   =20
    - pick up Michal's and Michael's R-b's

 pc-bios/descriptors/50-edk2-i386-secure.json   | 34 +++++++++++++++++++
 pc-bios/descriptors/50-edk2-x86_64-secure.json | 35 ++++++++++++++++++++
 pc-bios/descriptors/60-edk2-aarch64.json       | 31 +++++++++++++++++
 pc-bios/descriptors/60-edk2-arm.json           | 31 +++++++++++++++++
 pc-bios/descriptors/60-edk2-i386.json          | 33 ++++++++++++++++++
 pc-bios/descriptors/60-edk2-x86_64.json        | 34 +++++++++++++++++++
 pc-bios/README                                 | 11 ++++++
 7 files changed, 209 insertions(+)

diff --git a/pc-bios/descriptors/50-edk2-i386-secure.json b/pc-bios/descr=
iptors/50-edk2-i386-secure.json
new file mode 100644
index 000000000000..d7108c1da05a
--- /dev/null
+++ b/pc-bios/descriptors/50-edk2-i386-secure.json
@@ -0,0 +1,34 @@
+{
+    "description": "UEFI firmware for i386, with Secure Boot and SMM",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-i386-secure-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-i386-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "i386",
+            "machines": [
+                "pc-q35-*"
+            ]
+        }
+    ],
+    "features": [
+        "acpi-s3",
+        "requires-smm",
+        "secure-boot",
+        "verbose-dynamic"
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/50-edk2-x86_64-secure.json b/pc-bios/des=
criptors/50-edk2-x86_64-secure.json
new file mode 100644
index 000000000000..387eb356236b
--- /dev/null
+++ b/pc-bios/descriptors/50-edk2-x86_64-secure.json
@@ -0,0 +1,35 @@
+{
+    "description": "UEFI firmware for x86_64, with Secure Boot and SMM",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-x86_64-secure-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-i386-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "x86_64",
+            "machines": [
+                "pc-q35-*"
+            ]
+        }
+    ],
+    "features": [
+        "acpi-s3",
+        "amd-sev",
+        "requires-smm",
+        "secure-boot",
+        "verbose-dynamic"
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/60-edk2-aarch64.json b/pc-bios/descripto=
rs/60-edk2-aarch64.json
new file mode 100644
index 000000000000..800a21bda691
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-aarch64.json
@@ -0,0 +1,31 @@
+{
+    "description": "UEFI firmware for aarch64",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-aarch64-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-arm-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "aarch64",
+            "machines": [
+                "virt-*"
+            ]
+        }
+    ],
+    "features": [
+        "verbose-static"
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/60-edk2-arm.json b/pc-bios/descriptors/6=
0-edk2-arm.json
new file mode 100644
index 000000000000..d5f1bba6cc82
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-arm.json
@@ -0,0 +1,31 @@
+{
+    "description": "UEFI firmware for arm",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-arm-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-arm-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "arm",
+            "machines": [
+                "virt-*"
+            ]
+        }
+    ],
+    "features": [
+        "verbose-static"
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/60-edk2-i386.json b/pc-bios/descriptors/=
60-edk2-i386.json
new file mode 100644
index 000000000000..2f8dec74fecb
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-i386.json
@@ -0,0 +1,33 @@
+{
+    "description": "UEFI firmware for i386",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-i386-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-i386-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "i386",
+            "machines": [
+                "pc-i440fx-*",
+                "pc-q35-*"
+            ]
+        }
+    ],
+    "features": [
+        "acpi-s3",
+        "verbose-dynamic"
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/60-edk2-x86_64.json b/pc-bios/descriptor=
s/60-edk2-x86_64.json
new file mode 100644
index 000000000000..968cb65cf973
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-x86_64.json
@@ -0,0 +1,34 @@
+{
+    "description": "UEFI firmware for x86_64",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-x86_64-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-i386-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "x86_64",
+            "machines": [
+                "pc-i440fx-*",
+                "pc-q35-*"
+            ]
+        }
+    ],
+    "features": [
+        "acpi-s3",
+        "amd-sev",
+        "verbose-dynamic"
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/README b/pc-bios/README
index d421cb3f1f97..807d95dd5418 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -50,3 +50,14 @@
=20
 - QemuMacDrivers (https://github.com/ozbenh/QemuMacDrivers) is a project=
 to
   provide virtualised drivers for PPC MacOS guests.
+
+- The "edk2-*.fd.bz2" images are platform firmware binaries and matching=
 UEFI
+  variable store templates built from the TianoCore community's EFI Deve=
lopment
+  Kit II project
+  <https://github.com/tianocore/tianocore.github.io/wiki/EDK-II>. The im=
ages
+  were built at git tag "edk2-stable201903". The firmware binaries bundl=
e parts
+  of the OpenSSL project, at git tag "OpenSSL_1_1_0j" (the OpenSSL tag i=
s a
+  function of the edk2 tag). Licensing information is given in
+  "edk2-licenses.txt". The image files are described by the JSON documen=
ts in
+  the "pc-bios/descriptors" directory, which conform to the
+  "docs/interop/firmware.json" schema.
--=20
2.19.1.3.g30247aa5d201
