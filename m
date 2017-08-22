Received: from eggs.gnu.org ([2001:4830:134:3::10]:35525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dk5t8-0005mA-0v
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dk5t6-0006NV-Gs
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:54:22 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:37633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dk5t6-0006Lk-BV
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:54:20 -0400
Received: by mail-qk0-x232.google.com with SMTP id z18so94512046qka.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 02:54:19 -0700 (PDT)
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Tue, 22 Aug 2017 17:54:17 +0800
Message-ID: <CAOE=1Z16-G8kCpDcUfun3EAXNXsJHDiHkJNRFmgxqjOyS14v=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Why I got "timeout" while using qga socket to connect
 VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I start VM using command like this:

-chardev socket,path=/home/gangyewei-3/kvm/qga.sock,server,nowait,id=qga0
> -device virtio-serial -device
> virtserialport,chardev=qga0,name=org.qemu.guest_agent.0


But When I use socat to send command (
https://wiki.qemu.org/Features/GuestAgent), it blocked. Why and how to fix
this? Thank you~
