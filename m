Received: from eggs.gnu.org ([2001:4830:134:3::10]:50996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Hk7-0000q7-Ce
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Hk2-0003YE-By
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:09:27 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Hk2-0003Xw-7N
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:09:22 -0400
Received: by mail-qk0-x243.google.com with SMTP id a202so7019056qkg.3
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:09:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 19:09:12 -0300
Message-Id: <20180419220914.959-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] hw/superio: Fix inconsistent use of
 Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

My commit cd9526ab7c0 break something in the chardev frontend (serial).
Also 4c3119a6e3e does the same with the parallel device.

Fix the broken code and restore Marc-André patch which fixes the ctrl-a+b.
Tested with my usual setup.

Philippe Mathieu-Daudé (2):
  hw/isa/superio: Fix inconsistent use of Chardev->be
  Revert "Revert "mux: fix ctrl-a b again"" again

 chardev/char-mux.c   | 1 +
 hw/isa/isa-superio.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.0
