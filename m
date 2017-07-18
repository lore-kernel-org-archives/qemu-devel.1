Received: from eggs.gnu.org ([2001:4830:134:3::10]:54076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dXJMB-0000zi-7X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dXJMA-0008Hh-D8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:31 -0400
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:36365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dXJMA-0008Gm-5b
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:30 -0400
Received: by mail-ua0-x231.google.com with SMTP id 35so9116438uax.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:39:28 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Date: Tue, 18 Jul 2017 11:39:27 +0800
Message-ID: <CAB3eZfuBCA+pbQxCAuyVrXBKdr==rUo2vww1+EJ5Y5XHSX4p4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Is compressed qcow2 better in read/write performance?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qcow2 support compress option to compress image file.

I try to read both files through API by libguestfs(such as pread_device)

I'm confused with the performance during read or write

I tried to compress A.qcow2 to A_compress.qcow2 and it changes from 16GB to
23MB

I tried read on A_compress.qcow2, it seems faster than A.qcow2

maybe something wrong happened?
