Received: from eggs.gnu.org ([209.51.188.92]:55450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqg2e-0002u5-WA
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqftW-0005tb-60
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:10:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqftT-0005rz-Sd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:10:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0310389AD5
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 15:10:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb3e0855-a729-9a3d-e6ef-bfebea17b2cb@redhat.com>
Date: Mon, 4 Feb 2019 16:10:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] SeaBIOS regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>


 Hi Gerd,

I noticed that certain FreeDOS images are not working correctly anymore
with the current version of QEMU, for example
http://www.qemu-advent-calendar.org/2016/download/day10.tar.xz ... It
aborts with:

 Error reading from drive C: DOS area: write-protection violation attempt=
ed

I've bisected the issue, and it has apparently been introduced with:

 cd1bfd5ef336166b275a09dc9842542bf5e63ae3
 seabios: update bios and vgabios binaries

Any idea what might be going wrong here?

 Thomas
