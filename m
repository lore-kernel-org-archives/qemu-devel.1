Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqMiG-0000B0-Fc
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqMiF-0004Dr-FB
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:32:48 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:35371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cqMiF-0004De-Aa
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:32:47 -0400
Received: by mail-qt0-x233.google.com with SMTP id x35so134883709qtc.2
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:32:46 -0700 (PDT)
MIME-Version: 1.0
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Tue, 21 Mar 2017 17:32:45 +0100
Message-ID: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Guest application reading from pl011 without device
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear QEMU developers,

I am trying to read streaming data from a serial device by pointing to the
data register. The input data for the serial device is a string, whose
length is larger than the receiving fifo (I am using pl011). Ths input is
done by ReadFile() since my host is Win 7;

Now the guest application is able to receive the data, if the data size is
smaller than the fifo size, 16 bytes. But the communication fails when
receiving larger data.

I found the serial device is always trying to receive all the data when
ReadFile() is running, then start reading. Even if the fifo is full, the
_can_receive function still keeps polling if the data is larger than 16
bytes.

I try to write the interrupt in the guest application to force the serial
device to start reading right after the fifo is not empty. However, my
programming is too poor to work.

Am I on the right way to figure it out?
Looking forwards to your suggestion.

Best,
Huan
