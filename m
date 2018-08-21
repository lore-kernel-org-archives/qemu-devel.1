Received: from eggs.gnu.org ([2001:4830:134:3::10]:33049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1fs6jd-0007hZ-HK
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1fs6jX-00056e-Qn
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:30:13 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930]:40776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mkschreder.uk@googlemail.com>)
	id 1fs6jX-00056E-LM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:30:07 -0400
Received: by mail-ua1-x930.google.com with SMTP id m13-v6so11793934uaq.7
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:30:07 -0700 (PDT)
MIME-Version: 1.0
From: Martin Schroeder <mkschreder.uk@googlemail.com>
Date: Tue, 21 Aug 2018 15:29:55 +0200
Message-ID: <CAGmj6quRd4KaYJL2vqohFHuNDim+aB5OqoCAcK0HbFx7t+bfjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Modeling a device controlled by combination of GPIO
 and UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'd like to add a virtual device that is controlled by a couple of
GPIO pins on my controller (cortex-m4) and a serial port. I suppose I
can derive it from SSISlaveClass to make the new device a serial
slave.

But how do I connect GPIOs?

I want the slave device to be notified when guest firmware toggles a
gpio pin through the gpio driver which is an mmio device mapped into
the gpio memory area. So the GPIO driver currently keeps the state of
the pins internal to the driver. What I would like to do is somehow,
without requiring that the GPIO driver knows about the connected slave
device, deliver the notification of a gpio pin being toggled to the
slave device.

How does qemu implement this kind of thing?
