Received: from eggs.gnu.org ([2001:4830:134:3::10]:53708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN81-0001lI-D5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN7w-0001Jl-A0
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:09 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRN7u-0001Gk-Cb
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so17865205otk.8
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:04:53 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 26 Nov 2018 14:04:22 -0600
Message-Id: <20181126200435.23408-4-minyard@acm.org>
In-Reply-To: <20181126200435.23408-1-minyard@acm.org>
References: <20181126200435.23408-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v3 03/16] arm:i2c: Don't mask return from
 i2c_recv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

It can't fail, and now that it returns a uint8_t a 0xff mask
is unnecessary.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 6c69ce79b2..638b649911 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -811,7 +811,7 @@ static void stellaris_i2c_write(void *opaque, hwaddr offset,
             /* TODO: Handle errors.  */
             if (s->msa & 1) {
                 /* Recv */
-                s->mdr = i2c_recv(s->bus) & 0xff;
+                s->mdr = i2c_recv(s->bus);
             } else {
                 /* Send */
                 i2c_send(s->bus, s->mdr);
-- 
2.17.1
