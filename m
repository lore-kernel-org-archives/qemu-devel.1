Received: from eggs.gnu.org ([2001:4830:134:3::10]:55990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cuiyudaniu@gmail.com>) id 1dX2qV-0003El-OF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cuiyudaniu@gmail.com>) id 1dX2qT-0007jk-R8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:01:42 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:33046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cuiyudaniu@gmail.com>)
	id 1dX2qT-0007iv-Fm
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:01:41 -0400
Received: by mail-lf0-x22d.google.com with SMTP id z78so82555108lff.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:01:41 -0700 (PDT)
MIME-Version: 1.0
From: yu cui <cuiyudaniu@gmail.com>
Date: Mon, 17 Jul 2017 18:01:39 +0800
Message-ID: <CAPyyD3-+LjCUD5TOp56LUut7yc9+tLiW=GgOBLK96XYjcCo5fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] CR3 difference by virsh and c program in Guest(update)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I tried virsh command, it seems CR3 value returns by qemu and dmesg by a c
program in Guest is not same ?
The command is :
virsh -c qemu:///system qemu-monitor-command instance-0000009d '{"execute":
"human-monitor-command", "arguments": {"command-line": "info registers"}}'

When Guest is 4GB,  CR3 in guest is like "cr3 = 0x39a54000", while qemu
returns "cr3 = 0x0000000139a54000", with a gap of 4GB(0x0000000100000000).
When Guest is 8GB,  CR3 in guest is like "cr3 = 0x39a54000", while qemu
returns "cr3 = 0x0000000239a54000", with a gap of 8GB(0x0000000200000000).

So, it seems that CR3qemu = PysicalMem + CR3guest. Is it a bug?
