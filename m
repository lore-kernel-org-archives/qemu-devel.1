Received: from eggs.gnu.org ([2001:4830:134:3::10]:52140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXs-0002qY-9Y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXk-0008DS-EM
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:56 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXk-0008DG-8D
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:48 -0500
Received: by mail-qk0-x243.google.com with SMTP id o126so3243274qke.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:25 -0300
Message-Id: <20180103212436.15762-15-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 14/25] sdcard: add missing command CMD55
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

we don't implement it, but can see firmwares using it via UNIMP logs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7e9d7366fe..2b4254802f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1438,6 +1438,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
         }
         break;
 
+    case 55:    /* Not exist */
+        break;
+
     default:
         /* Fall back to standard commands.  */
         return sd_normal_command(sd, req);
-- 
2.15.1
