Received: from eggs.gnu.org ([2001:4830:134:3::10]:57893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GL-0002dI-UZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GJ-0004zX-Uv
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:45 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GJ-0004yy-P3
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:43 -0400
Received: by mail-qt0-x242.google.com with SMTP id q6-v6so41446926qtn.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:10:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  8 May 2018 12:10:32 -0300
Message-Id: <20180508151035.16774-2-f4bug@amsat.org>
In-Reply-To: <20180508151035.16774-1-f4bug@amsat.org>
References: <20180508151035.16774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/4] typedefs: Remove PcGuestInfo from
 qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

It is long gone since e4e8ba04c2007 ...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/typedefs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index a46b0b347b..325c72de33 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -62,7 +62,6 @@ typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
 typedef struct NumaNodeMem NumaNodeMem;
-typedef struct PcGuestInfo PcGuestInfo;
 typedef struct PCIBridge PCIBridge;
 typedef struct PCIBus PCIBus;
 typedef struct PCIDevice PCIDevice;
-- 
2.17.0
