Received: from eggs.gnu.org ([2001:4830:134:3::10]:58431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e089k-0005tk-Es
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e089e-0001T2-Ps
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:33:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e089e-0001Sj-HP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9426620271
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 15:33:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Oct 2017 17:33:27 +0200
Message-Id: <20171005153330.19210-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] update keymaps
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

This is a major of the qemu reverse keymaps in pc-bios/keymaps.

First patch adds a new qemu-keymap tool which can generate these
maps from xkbcommon data.  That allows to stop the error-prone
manual maintainance of the reverse keymaps, and it allows to easily
update reverse keymaps on keymap changes.

Second patch adds a Makefile to pc-bios/keymaps, with the correct
qemu-keymap arguments for all keymaps where I could figure what they
are supposed to be.  Hints for the remaining ones are very welcome.

Third patch updates all the keymaps.  If you want test the new keymaps
it is enough to apply just that third patch.

If you want play with the new qemu-keymap tool you should apply this
series on top of daniel's keycodemapdb patch series.

cheers,
  Gerd

Gerd Hoffmann (3):
  tools: add qemu-keymap
  Add pc-bios/keymaps/Makefile
  pc-bios/keymaps: keymaps update

 configure                |   23 +
 Makefile                 |    5 +
 qemu-keymap.c            |  258 +++++++++++
 pc-bios/keymaps/Makefile |   56 +++
 pc-bios/keymaps/ar       |  819 ++++++++++++++++++++++++++++++----
 pc-bios/keymaps/bepo     | 1108 ++++++++++++++++++++++++++++++++--------------
 pc-bios/keymaps/cz       |  861 ++++++++++++++++++++++++++++++++---
 pc-bios/keymaps/da       |  732 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/de       |  767 +++++++++++++++++++++++++++++++-
 pc-bios/keymaps/de-ch    |  915 ++++++++++++++++++++++++++++++++------
 pc-bios/keymaps/en-gb    |  724 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/en-us    |  718 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/es       |  744 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/et       |  818 ++++++++++++++++++++++++++++++----
 pc-bios/keymaps/fi       |  814 +++++++++++++++++++++++++++++++---
 pc-bios/keymaps/fo       |  881 +++++++++++++++++++++++++++++++++---
 pc-bios/keymaps/fr       |  704 ++++++++++++++++++++++++++++-
 pc-bios/keymaps/fr-be    |  724 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/fr-ca    |  804 +++++++++++++++++++++++++++++++--
 pc-bios/keymaps/fr-ch    |  800 +++++++++++++++++++++++++++++++--
 pc-bios/keymaps/hr       |  752 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/hu       |  887 +++++++++++++++++++++++++++++++++----
 pc-bios/keymaps/is       |  802 ++++++++++++++++++++++++++++++---
 pc-bios/keymaps/it       |  757 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/ja       |  792 +++++++++++++++++++++++++++++----
 pc-bios/keymaps/lt       |  844 +++++++++++++++++++++++++++++++++--
 pc-bios/keymaps/lv       |  766 ++++++++++++++++++++++++++++++--
 pc-bios/keymaps/mk       |  814 ++++++++++++++++++++++++++++++----
 pc-bios/keymaps/nl       |  794 ++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/no       |  758 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/pl       |  789 +++++++++++++++++++++++++++++++--
 pc-bios/keymaps/pt       |  737 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/pt-br    |  775 +++++++++++++++++++++++++++++++-
 pc-bios/keymaps/ru       |  835 ++++++++++++++++++++++++++++++----
 pc-bios/keymaps/th       |  878 ++++++++++++++++++++++++++++++------
 pc-bios/keymaps/tr       |  819 +++++++++++++++++++++++++++++++---
 36 files changed, 24353 insertions(+), 1721 deletions(-)
 create mode 100644 qemu-keymap.c
 create mode 100644 pc-bios/keymaps/Makefile

-- 
2.9.3
