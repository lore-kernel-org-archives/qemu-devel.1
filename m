Received: from eggs.gnu.org ([2001:4830:134:3::10]:37189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <okilic1@binghamton.edu>) id 1cO9D4-0004rO-6O
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <okilic1@binghamton.edu>) id 1cO9D1-0005S6-2a
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:27:58 -0500
Received: from mail-wj0-x236.google.com ([2a00:1450:400c:c01::236]:36665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <okilic1@binghamton.edu>)
	id 1cO9D0-0005Rg-Pw
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:27:54 -0500
Received: by mail-wj0-x236.google.com with SMTP id c11so226324899wjx.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jan 2017 12:27:53 -0800 (PST)
From: Ozgur O Kilic <okilic1@binghamton.edu>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Mon, 2 Jan 2017 23:27:50 +0300
Message-Id: <4D4A9683-A287-48CD-9D76-41850225B34C@binghamton.edu>
Subject: [Qemu-devel] QEMU online/offline cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org

Hi

I am trying to understand how QEMU threads respond to set a vCPU online or o=
ffline.=20

Specifically, what happens to QEMU thread if in the guest, we execute:

echo 0 > /sys/devices/system/cpu/cpu1/online

Is the corresponding QEMU thread paused?

Thank you
Ozgur Ozan Kilic=
