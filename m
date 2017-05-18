Received: from eggs.gnu.org ([2001:4830:134:3::10]:60706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBNyV-0000yn-1s
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBNyQ-00041u-Jw
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:08:27 -0400
Received: from mail-yb0-x230.google.com ([2607:f8b0:4002:c09::230]:34342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1dBNyQ-00041f-E5
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:08:22 -0400
Received: by mail-yb0-x230.google.com with SMTP id 132so11731535ybq.1
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:08:22 -0700 (PDT)
From: Rob Landley <rob@landley.net>
Message-ID: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
Date: Thu, 18 May 2017 11:08:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Serial input hangs after the first character in the 4.11 kernel:

  http://www.spinics.net/lists/linux-sh/msg51183.html

Because they enabled support for a buffer size thing QEMU doesn't
emulate right:

  http://www.spinics.net/lists/linux-sh/msg51189.html

Rob
