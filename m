Received: from eggs.gnu.org ([2001:4830:134:3::10]:40806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9qO-0000Dy-Mi
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9qF-0000w1-PQ
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:34:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ca9qF-0000vE-JB
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:34:03 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  4 Feb 2017 23:08:32 +0000
Message-Id: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] slirp: fix 3 easy coverity warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

This patchset fixes three easy-to-fix coverity warnings in the slirp
code (there are another 5 or so which are not quite so simple).

As usual, the preexisting tab-indent style for a lot of the slirp
code is well out of line with the QEMU/checkpatch preferences.
I opted to generally use QEMU style for the new lines but this
does look a bit of a mess in some ways; happy to adjust per
slirp maintainer preferences.

thanks
-- PMM

Peter Maydell (3):
  slirp: Check qemu_socket() return value in udp_listen()
  slirp: Convert mbufs to use g_malloc() and g_free()
  slirp: tcp_listen(): Don't try to close() an fd we never opened

 slirp/mbuf.c   | 30 ++++++++++++++----------------
 slirp/socket.c |  4 +++-
 slirp/udp.c    |  4 ++++
 3 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.1.4
