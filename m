Received: from eggs.gnu.org ([2001:4830:134:3::10]:36416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJz2-0003HJ-Ix
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJyx-00006o-Sj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:16 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ehJyx-00005r-NY
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:11 -0500
Received: by mail-ot0-x243.google.com with SMTP id x15so17898983ote.1
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:53:11 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  1 Feb 2018 12:52:55 -0600
Message-Id: <1517511182-9944-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PULL 0/7] Small IPMI fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The following changes since commit 6521130b0a7f699fdb82446d57df5627bfa7ed3c:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-01-26-2' into staging (2018-01-30 15:20:01 +0000)

are available in the git repository at:

  https://github.com/cminyard/qemu.git tags/for-release-20180201

for you to fetch changes up to 20b233641d76cc1812064304798ffeb530dc112d:

  ipmi: Allow BMC device properties to be set (2018-01-30 15:52:53 -0600)

----------------------------------------------------------------
Lots of litte miscellaneous fixes for the IPMI code, plus
add me as the IPMI maintainer.

----------------------------------------------------------------
Corey Minyard (7):
      Add maintainer for the IPMI code
      ipmi: Fix SEL get/set time commands
      ipmi: Don't set the timestamp on add events that don't have it
      ipmi: Add the platform event message command
      ipmi: Fix macro issues
      ipmi: disable IRQ and ATN on an external disconnect
      ipmi: Allow BMC device properties to be set

 MAINTAINERS               |  9 ++++++++
 hw/ipmi/ipmi_bmc_extern.c |  5 ++++
 hw/ipmi/ipmi_bmc_sim.c    | 58 ++++++++++++++++++++++++++++++++++++++---------
 hw/ipmi/isa_ipmi_bt.c     | 12 +++++-----
 4 files changed, 67 insertions(+), 17 deletions(-)
