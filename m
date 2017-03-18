Received: from eggs.gnu.org ([2001:4830:134:3::10]:40254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arvolkov@inbox.ru>) id 1cpItL-0002em-De
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 14:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arvolkov@inbox.ru>) id 1cpItI-0003hf-8c
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 14:15:51 -0400
Received: from smtp53.i.mail.ru ([94.100.177.113]:37522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arvolkov@inbox.ru>) id 1cpItH-0003eX-To
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 14:15:48 -0400
Received: from [81.25.53.169] (port=57173 helo=lexabiton1.ultra.net.ru)
	by smtp53.i.mail.ru with esmtpa (envelope-from <arvolkov@inbox.ru>)
	id 1cpItE-0006Ci-7f
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 21:15:44 +0300
From: Anton Volkov <arvolkov@inbox.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Message-Id: <5909E3D6-85D8-4B21-9442-CCD312A4717B@inbox.ru>
Date: Sat, 18 Mar 2017 21:15:42 +0300
Subject: [Qemu-devel] Error checking and qemu_thread_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello.

I want to make qemu_thread_create return a flag as described here =
(http://wiki.qemu-project.org/BiteSizedTasks), but I=E2=80=99m not sure =
how callers should behave if it fails.
I could make it so they would call something like error_report() and =
then call abort(), but then it is almost a copy of existing behavior.
Would the described behavior be acceptable? Or it should be different?

Best regards,
Anton Volkov
