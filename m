Received: from eggs.gnu.org ([2001:4830:134:3::10]:58731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxK-00082Z-2Z
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxG-0000s7-Tc
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:18 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:49296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e6jxG-0000rk-NJ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:14 -0400
Received: by mail-wr0-x232.google.com with SMTP id g90so18710824wrd.6
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:08:14 -0700 (PDT)
Received: from localhost.localdomain (ip-89-177-122-165.net.upcbroadband.cz.
	[89.177.122.165])
	by smtp.gmail.com with ESMTPSA id 25sm7199893wrv.8.2017.10.23.14.08.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 23 Oct 2017 14:08:12 -0700 (PDT)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Mon, 23 Oct 2017 23:07:56 +0200
Message-Id: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I am sending a couple of patches I needed to apply to make the
SDL2 GUI work reasonably on Debian Sid, which recently switched
from SDL1.

The main issue is that the QEMU window stops updating when it is
minimized, or after a virtual desktop switch. Then, there are
some regressions due to recently added terminals in multiple
windows, and some issues with fullscreen mode and window scaling.

I am using MATE desktop 1.18 and SDL 2.0.6.

Regards,
--
Jindrich Makovicka
