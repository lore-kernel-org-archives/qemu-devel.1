Received: from eggs.gnu.org ([2001:4830:134:3::10]:45887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPiY0-0002xQ-7b
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPiXv-0001UD-85
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:08 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPiXu-0001Ma-WE
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 01:33:03 -0500
Received: by mail-pl1-x643.google.com with SMTP id x21-v6so8769703pln.9
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 22:33:02 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 21 Nov 2018 22:32:50 -0800
Message-Id: <1542868372-2602-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] hw: vmmouse: use link property instead of
 DEFINE_PROP_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

According https://wiki.qemu.org/Contribute/BiteSizedTasks
the 'DEFINE_PROP_PTR' should be replaced by QOM link property.
The first patch replace constant strings with TYPE_XXXX and move some
definition to pc.h header file so that the second patch can work.

Li Qiang (2):
  hw: pc: use TYPE_XXX instead of constant strings
  hw: vmmouse: drop DEFINE_PROP_PTR()

 hw/i386/pc.c         | 11 ++++-------
 hw/i386/vmmouse.c    | 17 +++++++++++------
 hw/sparc64/sun4u.c   |  2 +-
 include/hw/i386/pc.h |  7 +++++++
 4 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.11.0
