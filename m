Received: from eggs.gnu.org ([2001:4830:134:3::10]:48075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSEK7-0005FX-LK
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gSEK4-0007L3-CN
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:53:11 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gSEK4-0007KI-1n
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:53:08 -0500
Received: by mail-pf1-x443.google.com with SMTP id b85so413701pfc.3
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:53:07 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 28 Nov 2018 20:52:10 -0800
Message-Id: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v3 0/2] hw: vmmouse: use link property instead
 of DEFINE_PROP_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: darren.kenny@oracle.com, armbru@redhat.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

According https://wiki.qemu.org/Contribute/BiteSizedTasks
the 'DEFINE_PROP_PTR' should be replaced by QOM link property.
The first patch replace constant strings with TYPE_XXXX and move some
definition to pc.h header file so that the second patch can work.

Change since v2: detail commit message
Change since v1: fix some issues per Markus' review

Li Qiang (2):
  hw: pc: use TYPE_XXX instead of constant strings
  hw: vmmouse: Use link instead of pointer property

 hw/i386/pc.c         |  9 +++++----
 hw/i386/vmmouse.c    | 18 +++++++++++-------
 include/hw/i386/pc.h |  3 +++
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.11.0
