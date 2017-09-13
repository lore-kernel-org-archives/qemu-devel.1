Received: from eggs.gnu.org ([2001:4830:134:3::10]:53895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds6UG-0002yv-J1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds6UC-0000UM-VT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:09:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds6UC-0000Tv-Pd
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:09:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0F447E434
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 12:09:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 14:09:35 +0200
Message-Id: <20170913120937.5645-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Add --firmwarepath to configure
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

Patch #1 is a cleanup to factor out code and simplify patch #2 a bit.
Patch #2 is the actual change, see patch commit log for details.

Gerd Hoffmann (2):
  add qemu_add_data_dir()
  Add --firmwarepath to configure

 configure             |  6 ++++++
 vl.c                  | 44 +++++++++++++++++++++++++++++++-------------
 scripts/create_config |  2 +-
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.9.3
