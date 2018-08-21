Received: from eggs.gnu.org ([2001:4830:134:3::10]:39755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fs1LA-000126-1K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fs1L9-0002Nq-A1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:44:35 -0400
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:32827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fs1L9-0002NN-0i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:44:35 -0400
Received: by mail-vk0-x22e.google.com with SMTP id w187-v6so2790720vkw.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 00:44:34 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Tue, 21 Aug 2018 15:44:32 +0800
Message-ID: <CAB3eZfu33DhKCvPBhd6CKb7XVRG9XnxDoOSXGTwQqnORCu06ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] What does VM SIZE means when entering qemu-img info
 xx.qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I have an qcow2 image and I mount it to /dev/nbd then write somethin.

Then I take internal snapshot in the qcow2.

I enter the command qemu-img info qcow2
It shows:
image: qcow2
file format: qcow2
virtual size: 30G
disk size:4M
xxxxx
Snapshot list:
ID, TAG, VM SIZE, DATE, VM CLOCK
1, snap1, 0, xxxx-xx-xx, 00:00:00

The field of "VM SIZE" is zero in my host machine.
What does it mean and why is it an zero?
