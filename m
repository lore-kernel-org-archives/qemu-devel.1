Received: from eggs.gnu.org ([209.51.188.92]:40915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN9-0002f7-96
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN7-0008NT-Uu
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBN7-0008JQ-Ln
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:01 -0500
Received: by mail-wr1-x42e.google.com with SMTP id p4so19160244wrt.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:10:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:29 +0000
Message-Id: <20190128181047.20781-9-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/26] MAINTAINERS: update microbit ARM board
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

New source files were added without corresponding ./MAINTAINERS file
entries.  Let's get things up to date.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190123183352.11025-1-stefanha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59e1f24d680..b334b539797 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -829,9 +829,11 @@ M: Joel Stanley <joel@jms.id.au>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-F: hw/arm/nrf51_soc.c
-F: hw/arm/microbit.c
-F: include/hw/arm/nrf51_soc.h
+F: hw/*/nrf51*.c
+F: hw/*/microbit*.c
+F: include/hw/*/nrf51*.h
+F: include/hw/*/microbit*.h
+F: tests/microbit-test.c
 
 CRIS Machines
 -------------
-- 
2.20.1
