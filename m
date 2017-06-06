Received: from eggs.gnu.org ([2001:4830:134:3::10]:41403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI90F-0007ey-Uk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI90F-0001Rt-4u
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dI90E-0001RY-VI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B8E83DBE1
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 07:34:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A0E917B65
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 07:34:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Jun 2017 09:34:04 +0200
Message-Id: <1496734448-19256-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Miscellaneous patches for 2017-06-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 199e19ee538eb61fd08b1c1ee5aa838ebdcc968e:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-06-05 15:28:12 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2017-06-06

for you to fetch changes up to c645d5acee0ae022534cb609184277ec2b4a8577:

  monitor: fix object_del for command-line-created objects (2017-06-06 09:29:46 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2017-06-06

----------------------------------------------------------------
Markus Armbruster (2):
      block: Clarify documentation of BlockInfo member io-status
      virtio-scsi-test: Use scsi-hd instead of legacy scsi-disk

Michael Roth (2):
      tests: check-qom-proplist: add checks for cmdline-created objects
      monitor: fix object_del for command-line-created objects

 qapi/block-core.json       |  3 ++-
 qom/object_interfaces.c    |  9 ++++++++
 tests/check-qom-proplist.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/virtio-scsi-test.c   |  2 +-
 4 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.7.5
