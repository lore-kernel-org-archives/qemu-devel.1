Received: from eggs.gnu.org ([209.51.188.92]:44837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTo6-0003fD-9y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTo5-00014P-Cy
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:29:10 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwTo3-00012u-AX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:29:09 -0500
Received: by mail-ot1-x342.google.com with SMTP id m1so40791131otf.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:29:04 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 20 Feb 2019 07:59:40 -0600
Message-Id: <20190220135956.22589-4-minyard@acm.org>
In-Reply-To: <20190220135956.22589-1-minyard@acm.org>
References: <20190220135956.22589-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/19] arm:i2c: Don't mask return from
 i2c_recv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

It can't fail, and now that it returns a uint8_t a 0xff mask
is unnecessary.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 442529cc65..7b45fe3ccf 100644
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
