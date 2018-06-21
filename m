Received: from eggs.gnu.org ([2001:4830:134:3::10]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k8-0003yK-Sq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k5-0003d9-QL
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2k5-0003cr-Li
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:29 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:18 +0100
Message-Id: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, sjitindarsingh@gmail.com, walling@linux.ibm.com
Cc: armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20180621

for you to fetch changes up to 13163a93b729b9ec4b49501d03d3f50af4b05758:

  hmp: Allow HMP in preconfig state again (2018-06-21 13:18:11 +0100)

----------------------------------------------------------------
HMP pull 2018-06-21

Minor fixes and reenable preconfig

----------------------------------------------------------------
Collin Walling (1):
      monitor: report entirety of hmp command on error

Dr. David Alan Gilbert (6):
      hmp: Add flag for preconfig commands
      hmp: Allow help on preconfig commands
      hmp: Restrict auto-complete in preconfig
      hmp: Add commands for preconfig
      hmp: add exit_preconfig
      hmp: Allow HMP in preconfig state again

Igor Mammedov (1):
      qmp: Enable a few commands in preconfig state

Suraj Jitindar Singh (1):
      hmp-commands: use long for begin and length in dump-guest-memory

 hmp-commands-info.hx | 10 ++++++++++
 hmp-commands.hx      | 25 ++++++++++++++++++++++++-
 hmp.c                |  8 ++++++++
 hmp.h                |  1 +
 monitor.c            | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 qapi/char.json       |  3 ++-
 qapi/misc.json       | 27 +++++++++++++++++----------
 7 files changed, 102 insertions(+), 23 deletions(-)
