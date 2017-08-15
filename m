Received: from eggs.gnu.org ([2001:4830:134:3::10]:38663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dherS-0007fW-R1
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dherP-0002CU-Ld
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:38:34 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50127
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dherP-0002CA-FN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:38:31 -0400
Received: from host86-189-213-185.range86-189.btcentralplus.com
	([86.189.213.185] helo=[192.168.1.65])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dherO-0001ZH-BW
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 17:38:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ea7e7a76-09ac-b8b2-a480-6c7d341c6881@ilande.co.uk>
Date: Tue, 15 Aug 2017 17:38:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] How to implement different endian accesses per MMU
 page?
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

Working through an incorrect endian issue on qemu-system-sparc64, it has
become apparent that at least one OS makes use of the IE (Invert Endian)
bit in the SPARCv9 MMU TTE to map PCI memory space without the
programmer having to manually endian-swap accesses.

In other words, to quote the UltraSPARC specification: "if this bit is
set, accesses to the associated page are processed with inverse
endianness from what is specified by the instruction (big-for-little and
little-for-big)".

Looking through various bits of code, I'm trying to get a feel for the
best way to implement this in an efficient manner. From what I can see
this could be solved using an additional MMU index, however I'm not
overly familiar with the memory and softmmu subsystems.

Can anyone point me in the right direction as to what would be the best
way to implement this feature within QEMU?


Many thanks,

Mark.
