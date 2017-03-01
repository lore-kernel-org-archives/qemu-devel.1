Received: from eggs.gnu.org ([2001:4830:134:3::10]:53030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cj4fU-00010k-24
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cj4fR-0003lP-0b
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:51:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cj4fQ-0003iK-Qd
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:51:44 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C13B4E4D2
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 13:51:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  1 Mar 2017 14:51:35 +0100
Message-Id: <1488376297-19711-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] docs: update sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

$subject says all.  Finally merging this.  Wasn't clear which
maintainer/tree this should though, so I guess everybody hoped for
someone else picking it up, causing the series lingering on the list
for quite a while ...

It's docs, so it'll hardly cause regressions, merging into 2.9 even
though freeze deadline was yesterday should be fine.

please pull,
  Gerd

The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:

  vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-docs-20170301-1

for you to fetch changes up to 166d434685ed6da5db88aca0c0599114e0c54462:

  mach-virt: Provide sample configuration files (2017-03-01 14:40:40 +0100)

----------------------------------------------------------------
docs: update sample configuration files

----------------------------------------------------------------
Andrea Bolognani (2):
      q35: Improve sample configuration files
      mach-virt: Provide sample configuration files

 docs/mach-virt-graphical.cfg  | 281 +++++++++++++++++++++++++++++++++++++++++
 docs/mach-virt-serial.cfg     | 243 +++++++++++++++++++++++++++++++++++
 docs/q35-chipset.cfg          | 152 ----------------------
 docs/q35-emulated.cfg         | 288 ++++++++++++++++++++++++++++++++++++++++++
 docs/q35-virtio-graphical.cfg | 248 ++++++++++++++++++++++++++++++++++++
 docs/q35-virtio-serial.cfg    | 193 ++++++++++++++++++++++++++++
 6 files changed, 1253 insertions(+), 152 deletions(-)
 create mode 100644 docs/mach-virt-graphical.cfg
 create mode 100644 docs/mach-virt-serial.cfg
 delete mode 100644 docs/q35-chipset.cfg
 create mode 100644 docs/q35-emulated.cfg
 create mode 100644 docs/q35-virtio-graphical.cfg
 create mode 100644 docs/q35-virtio-serial.cfg
