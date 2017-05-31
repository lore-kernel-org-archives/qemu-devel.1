Received: from eggs.gnu.org ([2001:4830:134:3::10]:57391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <malmeida@inf.ufsm.br>) id 1dG6vU-0000Fp-E4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <malmeida@inf.ufsm.br>) id 1dG6vT-0004MW-LG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:56:52 -0400
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <malmeida@inf.ufsm.br>)
	id 1dG6vT-0004KC-Er
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:56:51 -0400
Received: by mail-vk0-x231.google.com with SMTP id y190so11815770vkc.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:56:45 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Maur=C3=ADcio_Almeida?= <malmeida@inf.ufsm.br>
Date: Wed, 31 May 2017 13:56:44 -0300
Message-ID: <CAEB0U7P0Sk0cNQbPynrzJ5MMdQ5=zdMFnf5neWc6PjfQ1Z=Z2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Doubts about Kvm architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org

Hello Guys!
My name is Maur=C3=ADcio, we are making a study about Kvm Paravirtualized a=
nd
Full virtualized at our University, we are from University Federal of Santa
Maria.

Can you give us some papers about how the Kvm or Qemu executes the I/O Netw=
ork
with one emulated Device?

We executed some tests using Virtio Driver and e1000 emulated driver, the
network output of Virtio is normal and use four of the four Machine Cpu's,
but the output of e1000 Emulated driver was too low about Virtio and It
only used one of the four machine cpu's during the network test execution.

The Traffic of Virtio was 956 MB/s while e1000 Emulated Driver was 192
MB/s, both using Packet size of 1518 Bytes.

Why when it used e1000 Emulated Driver the traffic was to low and use only
one Cpu all the time?
Do Qemu or Kvm Guest need some specific configuration to use all CPU's?

Do you have any paper where we can find in details if Qemu is limited to
use one CPU when use Network Emulated Driver?

Thank you
Att Maur=C3=ADcio Almeida
