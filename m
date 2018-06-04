Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrY4-00007R-8T
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrY1-00065m-Lw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:37:32 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrY1-00065c-DY
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:37:29 -0400
Received: by mail-qt0-x244.google.com with SMTP id x34-v6so27648227qtk.5
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:37:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  4 Jun 2018 12:37:20 -0300
Message-Id: <20180604153722.24956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RESEND v2 0/2] linux-user: fix bugs reported by
 Clang Static Analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

This is a resend of v1 resend ... not sure what happened previously, MTA sent:

  550 8-bit characters not allowed in subject (see RFC 2822, sections 3.6.5, 2.2.1)

v1 here:
  http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07453.html

Philippe Mathieu-Daudé (2):
  linux-user: Export use is_error(), use it to avoid warnings
  linux-user: Use is_error() to avoid warnings and make the code clearer

 linux-user/qemu.h     |  5 +++++
 linux-user/flatload.c | 15 +++++++++------
 linux-user/syscall.c  |  5 -----
 3 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.17.1
