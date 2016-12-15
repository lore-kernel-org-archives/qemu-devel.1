Received: from eggs.gnu.org ([2001:4830:134:3::10]:45406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHOQo-0004Fl-JZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHOQk-0001J1-Jn
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:18:14 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cHOQk-0001Il-E0
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:18:10 -0500
Received: by mail-qk0-f195.google.com with SMTP id t184so5422288qkd.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 21:18:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Thu, 15 Dec 2016 00:17:09 -0500
Message-ID: <CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

BTW, do we have an example to show users how to config following
virtio-blk dataplane commands into XML configuration file?

qemu -object iothread,id=iothread0 \
      -drive if=none,id=drive0,file=test.img,format=raw,cache=none \
      -device virtio-blk-pci,iothread=iothread0,drive=drive0


Thank you,
Weiwei Jia
