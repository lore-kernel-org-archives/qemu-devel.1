Received: from eggs.gnu.org ([2001:4830:134:3::10]:35421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBj-0006rH-Oo
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBg-0001in-HG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsBg-0001iN-CP
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EFDDC047B67
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:23 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:09 +0800
Message-Id: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] buildsys: Move ui/usb library cflags/libs
 to per object
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

Hi Gerd,

This is part two of the QEMU_CFLAGS and libs_softmmu cleanup series, including
ui/, audio/ and hw/usb/. Please review.

Fam Zheng (9):
  buildsys: Move gtk/vte cflags/libs to per object
  buildsys: Move sdl cflags/libs to per object
  buildsys: Move vnc cflags/libs to per object
  buildsys: Move audio libs to per object
  buildsys: Move curese cflags/libs to per object
  buildsys: Move opengl cflags to per object
  buildsys: Move libcacard cflags/libs to per object
  buildsys: Move libusb cflags/libs to per object
  buildsys: Move usb redir cflags/libs to per object

 audio/Makefile.objs  |  6 ++++++
 configure            | 54 ++++++++++++++++++++++++++++++----------------------
 hw/usb/Makefile.objs | 13 +++++++++++--
 ui/Makefile.objs     | 37 ++++++++++++++++++++++-------------
 4 files changed, 72 insertions(+), 38 deletions(-)

-- 
2.13.5
