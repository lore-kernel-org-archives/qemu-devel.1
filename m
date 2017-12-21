Received: from eggs.gnu.org ([2001:4830:134:3::10]:56784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eS96S-0003E3-N4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eS96N-0000od-Pd
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:14:12 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:37112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1eS96N-0000ng-GD
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:14:07 -0500
Received: by mail-it0-x22e.google.com with SMTP id d137so12520920itc.2
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:14:05 -0800 (PST)
MIME-Version: 1.0
Sender: vase@selfip.ru
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Fri, 22 Dec 2017 01:13:44 +0300
Message-ID: <CACaajQsL3e+XWR0hBDLThmG_fd=ih-n+HJVz++XcnwLhhVstgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu 2.9.0 qcow2 file failed to open after hard server
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi! Today my server have forced reboot and one of my vm can't start
with message:
qcow2: Marking image as corrupt: L2 table offset 0x3f786d6c207600
unaligned (L1 index: 0); further corruption events will be suppressed

i'm use debian jessie with hand builded qemu 2.9.0, i'm try to
qemu-img check but it not helps. How can i recover data inside qcow2
file? (i'm not use compression or encryption inside it).

-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
