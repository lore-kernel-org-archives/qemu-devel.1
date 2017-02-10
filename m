Received: from eggs.gnu.org ([2001:4830:134:3::10]:55498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccBaJ-0002Wf-FV
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccBaG-0003sp-FF
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:49:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ccBaG-0003sO-97
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:49:56 -0500
From: Thomas Huth <thuth@redhat.com>
Message-ID: <10f23e13-dfdc-bbb1-2b31-e698d722a984@redhat.com>
Date: Fri, 10 Feb 2017 14:49:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Sparc sun4v machine currently broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

 Hi,

is it just me, or could it be that the sun4v machine is currently broken?
I get the following error when I try to run QEMU with this machine:

qemu-system-sparc64 -nographic -M sun4v
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


It works for when I use an older version of QEMU (version 2.7)...

 Thomas
