Received: from eggs.gnu.org ([209.51.188.92]:37209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz27-0005Rh-9n
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz24-00064W-TQ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz1z-00060x-Uf
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:36 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 23 Apr 2019 19:15:16 +0200
Message-Id: <20190423171520.4511-9-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/12] pc-bios: add edk2 firmware binaries and
 variable store templates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

Add the files built by the last patch: (compressed) binaries, and the
cumulative license text that covers them.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Phil's T-b
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Michal's R-b
   =20
    - pick up Phil's R-b
   =20
    - pick up Michael's R-b
   =20
    - Compress FD files with bzip2 rather than xz, so that decompression =
at
      "make install" time succeed on older build OSes too. The total size
      grows from 9,394,072 bytes to 9,492,846. [Peter]
   =20
    - do not pick up Igor's T-b therefore
   =20
    v2:
   =20
    - capture the compressed build outputs of the last patch; slightly
      update the commit message [Dan, Michael, Phil]
   =20
    - consequently, do not pick up Michal's and Michael's R-b's

 pc-bios/edk2-licenses.txt              | 209 ++++++++++++++++++++
 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 0 -> 1177603 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 0 -> 1173662 bytes
 pc-bios/edk2-arm-vars.fd.bz2           | Bin 0 -> 263 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 0 -> 1688659 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 0 -> 1881979 bytes
 pc-bios/edk2-i386-vars.fd.bz2          | Bin 0 -> 190 bytes
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 0 -> 1669280 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 0 -> 1901210 bytes
 9 files changed, 209 insertions(+)

diff --git a/pc-bios/edk2-licenses.txt b/pc-bios/edk2-licenses.txt
new file mode 100644
index 000000000000..8bdb1abc993e
--- /dev/null
+++ b/pc-bios/edk2-licenses.txt
@@ -0,0 +1,209 @@
+=3D=3D> edk2/License.txt <=3D=3D
+Copyright (c) 2004 - 2016, Intel Corporation. All rights reserved.
+Copyright (c) 2008 - 2010, Apple Inc. All rights reserved.
+Copyright (c) 2011 - 2015, ARM Limited. All rights reserved.
+Copyright (c) 2014 - 2015, Linaro Limited. All rights reserved.
+Copyright (c) 2013 - 2015, Red Hat, Inc.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+
+* Redistributions of source code must retain the above copyright
+  notice, this list of conditions and the following disclaimer.
+* Redistributions in binary form must reproduce the above copyright
+  notice, this list of conditions and the following disclaimer in
+  the documentation and/or other materials provided with the
+  distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
+ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGE.
+
+=3D=3D> edk2/OvmfPkg/License.txt <=3D=3D
+Copyright (c) 2012, Intel Corporation. All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+
+* Redistributions of source code must retain the above copyright
+  notice, this list of conditions and the following disclaimer.
+* Redistributions in binary form must reproduce the above copyright
+  notice, this list of conditions and the following disclaimer in
+  the documentation and/or other materials provided with the
+  distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
+ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGE.
+
+
+Some files are subject to the following license, the MIT license. Those =
files
+are located in:
+- OvmfPkg/Include/IndustryStandard/Xen/
+- OvmfPkg/XenBusDxe/
+- OvmfPkg/XenPvBlkDxe/
+
+Permission is hereby granted, free of charge, to any person obtaining a =
copy
+of this software and associated documentation files (the "Software"), to=
 deal
+in the Software without restriction, including without limitation the ri=
ghts
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sel=
l
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included =
in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL =
THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING =
FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS I=
N
+THE SOFTWARE.
+
+=3D=3D> edk2/CryptoPkg/Library/OpensslLib/openssl/LICENSE <=3D=3D
+
+  LICENSE ISSUES
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+  The OpenSSL toolkit stays under a double license, i.e. both the condit=
ions of
+  the OpenSSL License and the original SSLeay license apply to the toolk=
it.
+  See below for the actual license texts.
+
+  OpenSSL License
+  ---------------
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Copyright (c) 1998-2018 The OpenSSL Project.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.=20
+ *
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * 3. All advertising materials mentioning features or use of this
+ *    software must display the following acknowledgment:
+ *    "This product includes software developed by the OpenSSL Project
+ *    for use in the OpenSSL Toolkit. (http://www.openssl.org/)"
+ *
+ * 4. The names "OpenSSL Toolkit" and "OpenSSL Project" must not be used=
 to
+ *    endorse or promote products derived from this software without
+ *    prior written permission. For written permission, please contact
+ *    openssl-core@openssl.org.
+ *
+ * 5. Products derived from this software may not be called "OpenSSL"
+ *    nor may "OpenSSL" appear in their names without prior written
+ *    permission of the OpenSSL Project.
+ *
+ * 6. Redistributions of any form whatsoever must retain the following
+ *    acknowledgment:
+ *    "This product includes software developed by the OpenSSL Project
+ *    for use in the OpenSSL Toolkit (http://www.openssl.org/)"
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY
+ * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE OpenSSL PROJECT OR
+ * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ * This product includes cryptographic software written by Eric Young
+ * (eay@cryptsoft.com).  This product includes software written by Tim
+ * Hudson (tjh@cryptsoft.com).
+ *
+ */
+
+ Original SSLeay License
+ -----------------------
+
+/* Copyright (C) 1995-1998 Eric Young (eay@cryptsoft.com)
+ * All rights reserved.
+ *
+ * This package is an SSL implementation written
+ * by Eric Young (eay@cryptsoft.com).
+ * The implementation was written so as to conform with Netscapes SSL.
+ *=20
+ * This library is free for commercial and non-commercial use as long as
+ * the following conditions are aheared to.  The following conditions
+ * apply to all code found in this distribution, be it the RC4, RSA,
+ * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
+ * included with this distribution is covered by the same copyright term=
s
+ * except that the holder is Tim Hudson (tjh@cryptsoft.com).
+ *=20
+ * Copyright remains Eric Young's, and as such any Copyright notices in
+ * the code are not to be removed.
+ * If this package is used in a product, Eric Young should be given attr=
ibution
+ * as the author of the parts of the library used.
+ * This can be in the form of a textual message at program startup or
+ * in documentation (online or textual) provided with the package.
+ *=20
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ * 3. All advertising materials mentioning features or use of this softw=
are
+ *    must display the following acknowledgement:
+ *    "This product includes cryptographic software written by
+ *     Eric Young (eay@cryptsoft.com)"
+ *    The word 'cryptographic' can be left out if the rouines from the l=
ibrary
+ *    being used are not cryptographic related :-).
+ * 4. If you include any Windows specific code (or a derivative thereof)=
 from=20
+ *    the apps directory (application code) you must include an acknowle=
dgement:
+ *    "This product includes software written by Tim Hudson (tjh@cryptso=
ft.com)"
+ *=20
+ * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIAB=
LE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUE=
NTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
+ * SUCH DAMAGE.
+ *=20
+ * The licence and distribution terms for any publically available versi=
on or
+ * derivative of this code cannot be changed.  i.e. this code cannot sim=
ply be
+ * copied and put under another distribution licence
+ * [including the GNU Public Licence.]
+ */
+
diff --git a/pc-bios/edk2-aarch64-code.fd.bz2 b/pc-bios/edk2-aarch64-code=
.fd.bz2
new file mode 100644
index 000000000000..b213334d9553
Binary files /dev/null and b/pc-bios/edk2-aarch64-code.fd.bz2 differ
diff --git a/pc-bios/edk2-arm-code.fd.bz2 b/pc-bios/edk2-arm-code.fd.bz2
new file mode 100644
index 000000000000..a494a8391eed
Binary files /dev/null and b/pc-bios/edk2-arm-code.fd.bz2 differ
diff --git a/pc-bios/edk2-arm-vars.fd.bz2 b/pc-bios/edk2-arm-vars.fd.bz2
new file mode 100644
index 000000000000..2a5a9af31a6c
Binary files /dev/null and b/pc-bios/edk2-arm-vars.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-code.fd.bz2 b/pc-bios/edk2-i386-code.fd.bz=
2
new file mode 100644
index 000000000000..5440ca856db6
Binary files /dev/null and b/pc-bios/edk2-i386-code.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-secure-code.fd.bz2 b/pc-bios/edk2-i386-sec=
ure-code.fd.bz2
new file mode 100644
index 000000000000..24ae88ac3e40
Binary files /dev/null and b/pc-bios/edk2-i386-secure-code.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-vars.fd.bz2 b/pc-bios/edk2-i386-vars.fd.bz=
2
new file mode 100644
index 000000000000..4a1bc4523880
Binary files /dev/null and b/pc-bios/edk2-i386-vars.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-code.fd.bz2 b/pc-bios/edk2-x86_64-code.f=
d.bz2
new file mode 100644
index 000000000000..6a0b1f983199
Binary files /dev/null and b/pc-bios/edk2-x86_64-code.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-secure-code.fd.bz2 b/pc-bios/edk2-x86_64=
-secure-code.fd.bz2
new file mode 100644
index 000000000000..3ef6452c0375
Binary files /dev/null and b/pc-bios/edk2-x86_64-secure-code.fd.bz2 diffe=
r
--=20
2.19.1.3.g30247aa5d201
