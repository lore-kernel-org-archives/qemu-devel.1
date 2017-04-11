Received: from eggs.gnu.org ([2001:4830:134:3::10]:44136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cxpo8-0000tQ-I8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cxpo7-0002s1-HK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:01:44 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:33678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cxpo7-0002rl-Bf
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:01:43 -0400
Received: by mail-qk0-x231.google.com with SMTP id h67so132490204qke.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 00:01:41 -0700 (PDT)
MIME-Version: 1.0
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Tue, 11 Apr 2017 09:01:40 +0200
Message-ID: <CAJy91CZHb_aJncY1KSqTorZF3Gex=4_xd9=FmS5_QGzkXDNwGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] guest host time synchronization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Dear QEMU developers,

I made a test to check the time difference of QEMU emulated ARM-based Linux
guest and the Windows host. The result is, the guest time is around 0.2
second faster than the host. I used the "-rtc base" option.

So can I say that, the time precision of QEMU emulation is in seconds? Is
it possible to make it more precise? because I need to test the latency of
my guest/host communication with high time resolution, at least in
miliseconds.

Please let me know if you have any method  for the communication
performance testing. Thank you very much.

Best regards,
Jiahuan
