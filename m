Received: from eggs.gnu.org ([2001:4830:134:3::10]:34408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dxLEn-0006ha-C7
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dxLEk-0005SE-1t
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:55:29 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:44356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dxLEj-0005Rt-Qg
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:55:25 -0400
Received: by mail-io0-x236.google.com with SMTP id v36so87893ioi.1
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:55:24 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <455D51CC-104C-494B-B08E-7A1FCD0CDB8E@gmail.com>
Date: Wed, 27 Sep 2017 18:55:22 -0400
Subject: [Qemu-devel] Ping: [PATCH 0/2] ui/cocoa.m: enable guest to see
 control-alt key combinations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Currently if the user needs to send a control-alt key combination, he or =
she was either out of luck or had to rely on the monitor's sendkey =
command to do so. With this patch the user can now directly send =
control-alt key combinations. This is great for Windows guest that may =
need the control-alt-delete key combination.=20

John Arbuckle (2):
  move ungrab to ctrl-alt-g
  send ctrl-alt key combinations to guest if not used by QEMU

 ui/cocoa.m | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--=20
2.11.0 (Apple Git-81)
