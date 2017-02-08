Received: from eggs.gnu.org ([2001:4830:134:3::10]:44583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbW9w-00028X-LJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbW9r-0005kE-J8
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:36:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbW9r-0005je-DJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:35:55 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFF13C05AA56
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 17:35:54 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed,  8 Feb 2017 18:35:29 +0100
Message-Id: <1486575331-14455-1-git-send-email-abologna@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/2] docs: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com, lersek@redhat.com

The previous version of this series, that only included
the first of the two patches, has already been reviewed
by Gerd, but since it's not been pushed yet I figured I
would post this as a full new series instead of an
incremental improvement over the previous one.

The big difference compared to the previous version is
that sample configuration files are now provided for the
mach-virt machine type.

There are some small improvements to the q35 sample
configuration files as well, which are documented fully
in the relevant patch.

I'm adding Laszlo to CC:, so he can point out any
inaccurate statement I might have made about AAVMF.

Andrea Bolognani (2):
  q35: Improve sample configuration files
  mach-virt: Provide sample configuration files

 docs/mach-virt-graphical.cfg  | 245 ++++++++++++++++++++++++++++++++++++++
 docs/mach-virt-serial.cfg     | 234 +++++++++++++++++++++++++++++++++++++
 docs/q35-chipset.cfg          | 152 ------------------------
 docs/q35-emulated.cfg         | 265 ++++++++++++++++++++++++++++++++++++++++++
 docs/q35-virtio-graphical.cfg | 229 ++++++++++++++++++++++++++++++++++++
 docs/q35-virtio-serial.cfg    | 201 ++++++++++++++++++++++++++++++++
 6 files changed, 1174 insertions(+), 152 deletions(-)
 create mode 100644 docs/mach-virt-graphical.cfg
 create mode 100644 docs/mach-virt-serial.cfg
 delete mode 100644 docs/q35-chipset.cfg
 create mode 100644 docs/q35-emulated.cfg
 create mode 100644 docs/q35-virtio-graphical.cfg
 create mode 100644 docs/q35-virtio-serial.cfg

-- 
2.7.4
