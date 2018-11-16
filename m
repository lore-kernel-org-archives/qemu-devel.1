Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gNaMh-0007Cf-7M
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gNaMb-0002cW-62
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gNaMa-0002bt-Rk
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:33 -0500
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f0875422-2f51-e136-47af-e52947b4b405@redhat.com>
Date: Fri, 16 Nov 2018 10:24:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU crash with sun4v machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


 Hi Artyom,

I noticed that QEMU aborts the hard way when it is simply started like this:

$ sparc64-softmmu/qemu-system-sparc64 -M sun4v 
qemu: fatal: Trap 0x0010 while trap level (6) >= MAXTL (6), Error state
pc: 0000000000000200  npc: 0000000000000204
%g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
%g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
%o0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
%o4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
%l0-3: 0000000007f00000 000001ff00000000 000001fff0080000 0000000000000000 
%l4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
%i0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
%i4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
%f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
pstate: 00000014 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0 gl: 8
tbr: 0000000000000000 hpstate: 0000000000000004 htba: 0000000000000000
cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000

Aborted (core dumped)

That's ugly - QEMU should never simply abort unless we hit a
programming error. Do you see a good way to ease this situation, e.g.
by printing a more friendly error message if both, kernel and bios
could not be loaded?

 Thomas
