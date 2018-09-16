Received: from eggs.gnu.org ([2001:4830:134:3::10]:43837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <narutonguyen2018@gmail.com>) id 1g1Sw6-0000XN-F6
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 05:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <narutonguyen2018@gmail.com>) id 1g1Sw5-0002hh-O0
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 05:01:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <narutonguyen2018@gmail.com>)
	id 1g1Sw5-0002hS-Gf
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 05:01:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id a108-v6so14293341wrc.13
	for <qemu-devel@nongnu.org>; Sun, 16 Sep 2018 02:01:45 -0700 (PDT)
MIME-Version: 1.0
From: Naruto Nguyen <narutonguyen2018@gmail.com>
Date: Sun, 16 Sep 2018 16:01:30 +0700
Message-ID: <CANpxKHHOS4YUXv2--4nt1P0wrogzmvOZu0dhDqsu0dit=2QYFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Qemu shutdown VMs with the error in transmitting
 console data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello everyone,

Recently when I reboot my guest installed kernel 4.4.114, qemu-kvm
throws the error

qemu-kvm: hw/char/serial.c:232: serial_xmit: Assertion `!(s->lsr &
0x40)' failed.
shutting down

then qemu-kvm powers off the VM, I can meet the issue after a lot of
time to reboot the VM. The issue looks like to be reproduced more
easily by increasing the loglevel to make kernel throws more log to
the console. It seems I did not meet the issue with guest installed
kernel 3.0. There is another thread of Redhat about this bug but looks
like they cannot reproduce the issue and just provide the potential
fix https://bugzilla.redhat.com/show_bug.cgi?id=1481701.

I used the same qemu version with Redhat thread, qemu 2.6
qemu-kvm-rhev-2.6.0-28.el7_3.9.x86_64. My guest xml setup is to
redirect the console to file. I used the same config between guest
kernel 3.0 and 4.4. Could you please help me to understand more about
this issue:

- In what conditions can make qemu-kvm trigger this issue like: guest
console hangs or guest output to console too much?
- Why I just see the issue on guest installed kernel 4.4, not on kernel 3.0?

Thanks a lot,
Brs,
Naruto
