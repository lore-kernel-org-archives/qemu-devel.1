Received: from eggs.gnu.org ([2001:4830:134:3::10]:58236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVm1d-0004pM-TF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVm1Z-0006yO-Ul
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:19:41 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cVm1Z-0006yJ-Oj
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:19:37 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so29470457wme.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 13:19:37 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 23 Jan 2017 22:19:17 +0100
Message-Id: <1485206359-32337-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] niagara fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, Artyom Tarasenko <atar4qemu@gmail.com>

Niagara bugfixes

Artyom Tarasenko (2):
  niagara: fail if a firmware file is missing
  niagara: check if a serial port is available

 hw/sparc64/niagara.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.7.2
