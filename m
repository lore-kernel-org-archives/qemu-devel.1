Received: from eggs.gnu.org ([2001:4830:134:3::10]:42165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enxe9-0007np-1K
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 21:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enxe4-0000GC-1j
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 21:27:08 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1enxe3-0000Fl-Qb
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 21:27:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 19 Feb 2018 21:26:54 -0500
Message-Id: <1519093616-10563-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCHv2 0/2] target/sh4: translator loop conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

Changes since v1:

- Instead of passing max_insns to tb_start, merge max_insns into base,
  as suggested by Richard.
  Note that I'm using an int, which is what all the callers were using
  and is what the "bound" variables use too.

- Added rth's R-b tag to patch 2

I left out the suggestion of handling the gusa sequence in
translate_insn; I'm not very familiar with this code and don't have
a superh user-mode workload to test on.

Thanks,

		Emilio
