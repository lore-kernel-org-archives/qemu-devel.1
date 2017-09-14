Received: from eggs.gnu.org ([2001:4830:134:3::10]:55434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsSXd-00089k-GP
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsSXZ-0005XA-7y
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dsSXZ-0005VL-2H
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:42:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E312881DFC
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:42:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Sep 2017 13:42:34 +0200
Message-Id: <20170914114236.25343-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Add --firmwarepath to configure
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

v2: use G_SEARCHPATH_SEPARATOR_S (paolo)

Gerd Hoffmann (2):
  add qemu_add_data_dir()
  Add --firmwarepath to configure

 configure             |  6 ++++++
 vl.c                  | 44 +++++++++++++++++++++++++++++++-------------
 scripts/create_config |  2 +-
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.9.3
