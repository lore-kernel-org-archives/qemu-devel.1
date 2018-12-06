Received: from eggs.gnu.org ([2001:4830:134:3::10]:47437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gUvX8-0006Fz-Pz
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gUvLR-0001r5-QK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:13:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  6 Dec 2018 16:13:03 +0100
Message-Id: <20181206151304.8388-4-kwolf@redhat.com>
In-Reply-To: <20181206151304.8388-1-kwolf@redhat.com>
References: <20181206151304.8388-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/4] iotests: Filter cid numbers in VMDK
 extent info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.filter | 1 +
 tests/qemu-iotests/iotests.py    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 2031e353a5..1aa7d57140 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -165,6 +165,7 @@ _filter_img_info()
         -e "/table_size: [0-9]\\+/d" \
         -e "/compat: '[^']*'/d" \
         -e "/compat6: \\(on\\|off\\)/d" \
+        -e "s/cid: [0-9]\+/cid: XXXXXXXXXX/" \
         -e "/static: \\(on\\|off\\)/d" \
         -e "/zeroed_grain: \\(on\\|off\\)/d" \
         -e "/subformat: '[^']*'/d" \
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index d537538ba0..4142937239 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -248,6 +248,7 @@ def filter_img_info(output, filename):
                    .replace(imgfmt, 'IMGFMT')
         line =3D re.sub('iters: [0-9]+', 'iters: XXX', line)
         line =3D re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-XX=
XX-XXXXXXXXXXXX', line)
+        line =3D re.sub('cid: [0-9]+', 'cid: XXXXXXXXXX', line)
         lines.append(line)
     return '\n'.join(lines)
=20
--=20
2.19.2
