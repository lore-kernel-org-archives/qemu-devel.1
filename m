Received: from eggs.gnu.org ([2001:4830:134:3::10]:60767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dverma@redhat.com>) id 1di0q8-0000gv-32
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dverma@redhat.com>) id 1di0q2-0006T5-1V
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dverma@redhat.com>) id 1di0q1-0006St-RN
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:06:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42A57404325
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 15:59:37 +0000 (UTC)
From: dverma <dverma@redhat.com>
Date: Wed, 16 Aug 2017 11:59:27 -0400
Message-Id: <1502899168-19852-3-git-send-email-dverma@redhat.com>
In-Reply-To: <1502899168-19852-1-git-send-email-dverma@redhat.com>
References: <1502899168-19852-1-git-send-email-dverma@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] Update the existing whitelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jen@redhat.com, dgilbert@redhat.com, quintela@redhat.com, dverma <dverma@redhat.com>

Appended newer fields and introduced new names in the whitelist

Changes v1->v2:
1. Fix patchew warnings about exceeding 80 characters

Signed-off-by: Deepak Verma <dverma@redhat.com>
---
 scripts/vmstate-static-checker.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index b416b66..ae41e44 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -49,7 +49,6 @@ def check_fields_match(name, s_field, d_field):
     # is used to whitelist such changes in each section / description.
     changed_names = {
         'apic': ['timer', 'timer_expiry'],
-        'e1000': ['dev', 'parent_obj'],
         'ehci': ['dev', 'pcidev'],
         'I440FX': ['dev', 'parent_obj'],
         'ich9_ahci': ['card', 'parent_obj'],
@@ -73,7 +72,6 @@ def check_fields_match(name, s_field, d_field):
                      'tmr.timer', 'ar.tmr.timer',
                      'tmr.overflow_time', 'ar.tmr.overflow_time',
                      'gpe', 'ar.gpe'],
-        'rtl8139': ['dev', 'parent_obj'],
         'qxl': ['num_surfaces', 'ssd.num_surfaces'],
         'usb-ccid': ['abProtocolDataStructure', 'abProtocolDataStructure.data'],
         'usb-host': ['dev', 'parent_obj'],
@@ -96,6 +94,26 @@ def check_fields_match(name, s_field, d_field):
                       'mem_win_size', 'mig_mem_win_size',
                       'io_win_addr', 'mig_io_win_addr',
                       'io_win_size', 'mig_io_win_size'],
+        'rtl8139': ['dev', 'parent_obj'],
+        'e1000e': ['PCIDevice', 'PCIEDevice', 'intr_state', 'redhat_7_3_intr_state'],
+        'nec-usb-xhci': ['PCIDevice', 'PCIEDevice'],
+        'xhci-intr': ['er_full_unused', 'er_full'],
+        'e1000': ['dev', 'parent_obj',
+                  'tx.ipcss', 'tx.props.ipcss',
+                  'tx.ipcso', 'tx.props.ipcso',
+                  'tx.ipcse', 'tx.props.ipcse',
+                  'tx.tucss', 'tx.props.tucss',
+                  'tx.tucso', 'tx.props.tucso',
+                  'tx.tucse', 'tx.props.tucse',
+                  'tx.paylen', 'tx.props.paylen',
+                  'tx.hdr_len', 'tx.props.hdr_len',
+                  'tx.mss', 'tx.props.mss',
+                  'tx.sum_needed', 'tx.props.sum_needed',
+                  'tx.ip', 'tx.props.ip',
+                  'tx.tcp', 'tx.props.tcp',
+                  'tx.ipcss', 'tx.props.ipcss',
+                  'tx.ipcss', 'tx.props.ipcss',
+                  ]
     }
 
     if name not in changed_names:
-- 
1.8.3.1
