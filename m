Received: from eggs.gnu.org ([2001:4830:134:3::10]:41856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAeHY-0007H2-6F
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAeHU-0000p8-VE
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:25:36 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAeHU-0000ov-Ph
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:25:32 -0400
Received: by mail-qt0-x242.google.com with SMTP id f16-v6so14562221qth.0
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:25:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 23 Apr 2018 13:25:21 -0300
Message-Id: <20180423162523.6392-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/2] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This series fixes an unaligned of a 64-bit FDT property in the FIT loader.

Since v2:
- Use the ldst API
- Let ldl_he_p() returns unsigned
- Use the same API for handling 32/64-bit FDT properties

Philippe Mathieu-Daudé (2):
  bswap.h: Fix ldl_he_p() signedness
  loader: Fix 64-bit misaligned member access

 include/qemu/bswap.h | 4 ++--
 hw/core/loader-fit.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.0
