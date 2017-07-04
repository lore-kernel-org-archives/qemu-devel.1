Received: from eggs.gnu.org ([2001:4830:134:3::10]:58753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dSSWJ-0003QD-RW
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dSSWG-0002le-LG
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:25:55 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47428
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dSSWG-0002kQ-E3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:25:52 -0400
Received: from host86-191-132-89.range86-191.btcentralplus.com
	([86.191.132.89] helo=[192.168.1.65])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dSSWC-0008JR-06
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 19:25:48 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
Date: Tue, 4 Jul 2017 19:25:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Managing architectural restrictions with -device and
 libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi all,

I've been working on a patchset that brings the sun4u machine on
qemu-system-sparc64 much closer to a real Ultra 5, however due to
various design restrictions I need to be able to restrict how devices
are added to the machine with -device.

On a real Ultra 5, the root PCI bus (sabre) has 2 PCI bridges (simba A
and simba B) with the onboard devices attached to simba A with 2 free
slots, and an initially empty simba B.

Firstly, is it possible to restrict the machine so that devices cannot
be directly plugged into the root PCI bus, but only behind one of the
PCI bridges? There is also an additional restriction in that slot 0
behind simba A must be left empty to ensure that the ebus (containing
the onboard devices) is the first device allocated.

Secondly, how does libvirt handle these type of restrictions? Is it able
to get the information from QEMU or is there some kind of libvirt
profile that needs to be updated? And do newer versions of libvirt have
the ability to attach devices behind PCI bridges using a GUI such as
virt-manager, or is that only something that can only be done by
directly editing the domain XML?


ATB,

Mark.
