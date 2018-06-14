Received: from eggs.gnu.org ([2001:4830:134:3::10]:44092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTajV-0005gg-GA
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTajS-0003vX-Cx
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:28:45 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35558
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fTajS-0003ux-4W
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:28:42 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 14 Jun 2018 23:28:29 +0100
Message-Id: <20180614222830.19725-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH v3 0/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com, richard.henderson@linaro.org, cota@braap.org

This is a patch I've had in an earlier form for a while but never really developed
due to experiencing random hangs when writing to the SPARC64 CPU timers.

Fortunately it seems the recent icount timer fixes have resolved the underlying
issues and with this patch I am able to boot all my qemu-system-sparc64 OpenBIOS
test images.

I've marked this as an RFC for two reasons: firstly I'm not sure I've fully covered
all the cases where we need to exit the TB in order to allow the timer interrupt to
fire, and secondly I do occasionally see messages booting Milax in the form of
"WARNING: Time of Day clock error: reason [Jumped by 0x134]".

Hopefully more sets of eyes will be able to point me in the right direction related
to the Time of Day (m48t59) error and the TB exits in order to get this ready for
commit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v3:
- Implement feedback from Richard: use tb_cflags() for icount flag access,
  unconditionally exit the TB when setting the timer registers, introduce DISAS_EXIT
  to avoid repeating TB exit code pattern

v2:
- Rebase onto master


Mark Cave-Ayland (1):
  SPARC64: add icount support

 target/sparc/translate.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

-- 
2.11.0
