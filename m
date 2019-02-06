Received: from eggs.gnu.org ([209.51.188.92]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1grQGb-0001Ub-L2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1grQGW-0004qg-KF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:41:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:18071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1grQGQ-0004ne-A3
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:41:30 -0500
Date: Wed, 6 Feb 2019 17:41:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1902061736310.58711@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] 07333e1ca (kbd-state: use state tracker for sdl2)
 breaks keyboard input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>

Hello,

The commit 07333e1ca breaks keyboard input in bios console with SDL2 UI. 
To reproduce: start qemu-system-i386 without any options, press Ctrl-B 
when prompted to get an IPXE command line and type. Key presses are 
doubled.

(Besides this the output window mixup when something is output to serial 
window I've reported earlier is still present. I'd appreciate if these 
could be fixed now that the working SDL1 alternative was completely 
removed.)

Thank you,
BALATON Zoltan
