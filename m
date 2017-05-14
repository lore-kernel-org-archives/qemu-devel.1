Received: from eggs.gnu.org ([2001:4830:134:3::10]:48886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gceq-qemu-devel@m.gmane.org>) id 1dA37V-0004up-Q8
	for qemu-devel@nongnu.org; Sun, 14 May 2017 19:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gceq-qemu-devel@m.gmane.org>) id 1dA37S-0008R0-O2
	for qemu-devel@nongnu.org; Sun, 14 May 2017 19:40:13 -0400
Received: from [195.159.176.226] (port=56788 helo=blaine.gmane.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gceq-qemu-devel@m.gmane.org>)
	id 1dA37S-0008Mc-HH
	for qemu-devel@nongnu.org; Sun, 14 May 2017 19:40:10 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
	(envelope-from <gceq-qemu-devel@m.gmane.org>) id 1dA37I-0008DI-Ep
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:40:00 +0200
From: jenia.ivlev@gmail.com (jenia.ivlev)
Date: Sun, 14 May 2017 19:39:56 -0400
Message-ID: <87efvrovn7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] QEMU, increase graphics memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


I wanted to get more graphics memory on my QEMU Windows client.

I decided to install **Virtio** drivers for QEMU to achieve that purpose.

I create an *imagine_file* like this:


    qemu-img create -f raw image_file 4G


Also, I ran the windows-install like this:


    qemu-system-x86_64 -enable-kvm -m 4G -cdrom "OS.iso" -boot order=c -drive file=image_file,if=virtio


But when Windows ran, it didn't find any hard-drive (the *image_file*
basically). It asked for some drivers instead. I think it wanted drivers
to communicate with the hard-drive (*image_file*).

Running the install without Virtio works though:


    qemu-system-x86_64 -enable-kvm -m 4G -cdrom "OS.iso" -boot order=d -drive file=image_file,format=raw


The difference betweeen the two commands is:


    order=c vs order=d


and


    if=virtio vs format=raw


How do I install windows with Virtio in QEMU?

My original goal is to get 512 MB of graphics memory on Windows (running
as a guest in QEMU). Unfortunately, by default  (no Virtio) I get 8MB of
video memory which is not enough for my purposes


Thanks

P.S. My OS is Arch-Linux
