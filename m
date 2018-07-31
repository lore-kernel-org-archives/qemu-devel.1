Received: from eggs.gnu.org ([2001:4830:134:3::10]:53868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkIwf-0007RE-PH
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 20:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkIwb-0005Iw-Tp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 20:55:25 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:40693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fkIwb-0005IW-CK
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 20:55:21 -0400
Received: by mail-io0-x243.google.com with SMTP id l14-v6so11505001iob.7
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 17:55:21 -0700 (PDT)
Received: from [192.168.0.4] ([69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	132-v6sm482203ita.37.2018.07.30.17.55.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 30 Jul 2018 17:55:19 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <6D6F6554-BC5B-40CB-80C7-7245AF3F08E4@gmail.com>
References: <20180730212249.16418-1-programmingkidx@gmail.com>
Date: Mon, 30 Jul 2018 20:55:18 -0400
Subject: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between commands
 in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

When the user uses the --help option in qemu-img, the output for the =
commands is very hard to read due to being so close to each other. With =
this patch the help for the commands is double spaced making things =
easier to read.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
qemu-img.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9b7506b8ae..6a7e63435e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -120,7 +120,7 @@ static void QEMU_NORETURN help(void)
           "\n"
           "Command syntax:\n"
#define DEF(option, callback, arg_string)        \
-           "  " arg_string "\n"
+           "  " arg_string "\n\n"
#include "qemu-img-cmds.h"
#undef DEF
           "\n"
--=20
2.14.3 (Apple Git-98)
