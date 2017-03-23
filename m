Received: from eggs.gnu.org ([2001:4830:134:3::10]:53587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <igor.rubinov@gmail.com>) id 1cqxkx-0005jp-VM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <igor.rubinov@gmail.com>) id 1cqxkw-0003WY-Pg
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:06:03 -0400
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:36790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <igor.rubinov@gmail.com>)
	id 1cqxkw-0003VG-KZ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:06:02 -0400
Received: by mail-vk0-x22f.google.com with SMTP id j64so128126810vkg.3
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 01:06:02 -0700 (PDT)
MIME-Version: 1.0
Sender: igor.rubinov@gmail.com
From: Igor R <boost.lists@gmail.com>
Date: Thu, 23 Mar 2017 10:05:31 +0200
Message-ID: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hi,

I'm trying to use the deterministic record/replay feature, and I would
like to know which commit I should take to get it work.
In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f381dc, as
mentioned here:
http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg02657.html
with this patch:
http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01316.html
My command line is:
./qemu-system-i386 -net none  -icount
shift=7,rr=replay,rrfile=replay.bin -drive
file=MyFedora386.qcow,if=none,id=img-direct -drive
driver=blkreplay,if=none,image=img-direct,id=img-blkreplay -device
ide-hd,drive=img-blkreplay -monitor stdio

The replay advances for a while, but gets stuck in about 10-15 sec,
and it looks like it encounters deadlock trying to acquire rcu lock.

Is there a working commit of RR?


Thanks.
