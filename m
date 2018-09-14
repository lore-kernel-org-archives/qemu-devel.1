Received: from eggs.gnu.org ([2001:4830:134:3::10]:57987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1g0jNR-0005XL-JW
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1g0jNH-00061m-Fl
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:22:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45838
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1g0jNH-0005vK-70
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:22:47 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 14 Sep 2018 09:22:27 +0100
Message-Id: <20180914082229.5352-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 0/2] qemu-sparc.for-upstream queue 20180914
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, atar4qemu@gmail.com, qemu-devel@nongnu.org

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-sparc.for-upstream-20180914

for you to fetch changes up to 0a1d5c4596b2fcd3accfe2556e7fade8787ce6b6:

  sun4u: implement custom FWPathProvider (2018-09-14 09:18:11 +0100)

----------------------------------------------------------------
qemu-sparc.for-upstream queue

----------------------------------------------------------------
Mark Cave-Ayland (2):
      sabre: generate correct fw path for sabre PCI host bridge
      sun4u: implement custom FWPathProvider

 hw/pci-host/sabre.c | 12 +++++++++++
 hw/sparc64/sun4u.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
