Received: from eggs.gnu.org ([209.51.188.92]:38253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1h3MXR-0005Og-Dw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1h3MXQ-0007W3-Of
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55544 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1h3MXQ-0006ld-Fw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:24 -0400
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Date: Mon, 11 Mar 2019 16:07:09 +0100
Message-Id: <1552316831-14098-1-git-send-email-stefan.brankovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/2] Add support for some comparison
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, cota@braap.org

Implement emulation of TILE-Gx instructions V1CMPLEU, V1CMPLTU,
V2CMPLEU, and V2CMPLTU.

Stefan Brankovic (2):
  target/tilegx: Implement emulation of TILEGX instructions V1CMPLEU and
    V1CMPLTU
  target/tilegx: Implement emulation of TILEGX instructions V2CMPLEU and
    V2CMPLTU

 target/tilegx/translate.c | 124 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 8 deletions(-)

-- 
2.7.4
