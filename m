Received: from eggs.gnu.org ([2001:4830:134:3::10]:50467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMUAw-0006Ck-OJ
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 01:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMUAt-0005mU-Kr
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 01:26:54 -0500
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Dec 2016 01:26:46 -0500
Message-Id: <A7AC9346-B5B0-44F1-9E24-54D14C6A5A55@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] Reducing guest cpu usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-discuss <qemu-discuss@nongnu.org>

There is a program that I run inside of QEMU that doesn't use the =
virtual CPU very efficiently. It causes QEMU to use 100% of the guest's =
CPU time. I was wondering if there were a way to reduce the amount of =
host CPU time that a guest CPU can use? This feature would help prevent =
laptops from heating up when running QEMU.=
