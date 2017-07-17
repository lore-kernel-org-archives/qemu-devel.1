Received: from eggs.gnu.org ([2001:4830:134:3::10]:55418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cuiyudaniu@gmail.com>) id 1dX2o9-0002an-Pe
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cuiyudaniu@gmail.com>) id 1dX2o9-0006Bg-23
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:59:17 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:36203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cuiyudaniu@gmail.com>)
	id 1dX2o8-00069O-NU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:59:17 -0400
Received: by mail-lf0-x22c.google.com with SMTP id h22so82177764lfk.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 02:59:14 -0700 (PDT)
MIME-Version: 1.0
From: yu cui <cuiyudaniu@gmail.com>
Date: Mon, 17 Jul 2017 17:59:13 +0800
Message-ID: <CAPyyD3-X4XzHNDs2DD=hNR2y8eM9GkwfH3qqgzLZp+25D=82FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] CR3 difference by virsh and c program in Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I tried virsh command, it seems CR3 value returns by qemu and dmesg by a c
program in Guest is not same ?
The command is :
virsh -c qemu:///system qemu-monitor-command instance-0000009d

When Guest is 4GB,  CR3 in guest is like "cr3 = 0x39a54000", while qemu
returns "cr3 = 0x0000000139a54000", with a gap of 4GB(0x0000000100000000).
When Guest is 8GB,  CR3 in guest is like "cr3 = 0x39a54000", while qemu
returns "cr3 = 0x0000000239a54000", with a gap of 8GB(0x0000000200000000).

So, it seems that CR3qemu = PysicalMem + CR3guest. Is it a bug?
