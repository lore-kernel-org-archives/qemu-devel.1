Received: from eggs.gnu.org ([2001:4830:134:3::10]:44727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vicviq@gmail.com>) id 1g9wyH-00082V-Sr
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vicviq@gmail.com>) id 1g9wyF-0002pK-MU
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:43:05 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:35960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vicviq@gmail.com>) id 1g9wyF-0002X1-Dn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:43:03 -0400
Received: by mail-ot1-x335.google.com with SMTP id x4so1335012otg.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 11:42:52 -0700 (PDT)
MIME-Version: 1.0
From: viq <vicviq@gmail.com>
Date: Tue, 9 Oct 2018 20:42:39 +0200
Message-ID: <CALF8MVHZSWutrbc-X04OMLQA1WZ1rSznbrxS68Z7eRRxL8YPqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] OpenBSD with VirtIO networking causes QEMU to crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

(please CC me as I'm not subscribed to the list)
I verified the behaviour on two different machines, both running archlinux
with QEMU 3.0.0 and reported it on https://bugs.archlinux.org/task/60141
where it was suggested I bring it to the list.

So what happens: if you try to run OpenBSD with VirtIO networking enabled,
the moment OpenBSD brings up network the QEMU process crashes. Easiest
steps to reproduce:
Download for example
https://ftp.halifax.rwth-aachen.de/pub/OpenBSD/6.3/amd64/install63.iso
Create new VM under libvirt as OpenBSD 6.3, create disk, "change options
before installation", change disk and network types to virtio
Proceed with installation (basically enter-enter-enter-...)
Observe qemu crash when network is brought up.

Sorry, I don't really know how to proceed further with that.
-- 
viq
