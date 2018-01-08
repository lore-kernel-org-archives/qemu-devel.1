Received: from eggs.gnu.org ([2001:4830:134:3::10]:50567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbl2-00053U-4L
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbl1-0006DX-CW
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:48 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbl1-0006Cw-8F
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:47 -0500
Received: by mail-qk0-x243.google.com with SMTP id j137so15247088qke.10
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:02:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 15:02:27 -0300
Message-Id: <20180108180231.21122-4-f4bug@amsat.org>
In-Reply-To: <20180108180231.21122-1-f4bug@amsat.org>
References: <20180108180231.21122-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/7] net/rocker: use QEMU_PACKED and
 QEMU_ALIGNED() macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/rocker/rocker_hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/rocker/rocker_hw.h b/hw/net/rocker/rocker_hw.h
index 1786323fa4..8b4ce250d5 100644
--- a/hw/net/rocker/rocker_hw.h
+++ b/hw/net/rocker/rocker_hw.h
@@ -130,7 +130,7 @@ typedef struct rocker_desc {
     __le16 tlv_size;
     __le16 rsvd[5];   /* pad to 32 bytes */
     __le16 comp_err;
-} __attribute__((packed, aligned(8))) RockerDesc;
+} QEMU_PACKED QEMU_ALIGNED(8) RockerDesc;
 
 /*
  * Rocker TLV type fields
@@ -140,7 +140,7 @@ typedef struct rocker_tlv {
     __le32 type;
     __le16 len;
     __le16 rsvd;
-} __attribute__((packed, aligned(8))) RockerTlv;
+} QEMU_PACKED QEMU_ALIGNED(8) RockerTlv;
 
 /* cmd msg */
 enum {
-- 
2.15.1
