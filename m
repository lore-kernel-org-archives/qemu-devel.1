Received: from eggs.gnu.org ([2001:4830:134:3::10]:58707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaC9-0007jf-Jx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaC3-0007RU-S4
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:02:15 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gRaC3-0007RK-Kt
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:02:11 -0500
Received: by mail-pg1-x542.google.com with SMTP id 17so7639031pgg.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:02:11 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 02:02:01 -0800
Message-Id: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] hw: vmmouse: use link property instead
 of DEFINE_PROP_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, armbru@redhat.com, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

According https://wiki.qemu.org/Contribute/BiteSizedTasks
the 'DEFINE_PROP_PTR' should be replaced by QOM link property.
The first patch replace constant strings with TYPE_XXXX and move some
definition to pc.h header file so that the second patch can work.

Change since v1: fix some issues per Markus' review

Li Qiang (2):
  hw: pc: use TYPE_XXX instead of constant strings
  hw: vmmouse: drop DEFINE_PROP_PTR()

 hw/i386/pc.c         |  9 +++++----
 hw/i386/vmmouse.c    | 18 +++++++++++-------
 include/hw/i386/pc.h |  3 +++
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.11.0
