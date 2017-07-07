Received: from eggs.gnu.org ([2001:4830:134:3::10]:50284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dTJPP-0003Au-FL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dTJPM-0005Ac-DO
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dTJPM-0005A8-6k
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:54:16 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri,  7 Jul 2017 10:54:08 +0800
Message-Id: <1499396048-21657-1-git-send-email-peterx@redhat.com>
In-Reply-To: <20170706183014.GH12152@localhost.localdomain>
Subject: [Qemu-devel] [PATCH v2.2 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, lvivier@redhat.com, ehabkost@redhat.com, quintela@redhat.com, groug@kaod.org, dgilbert@redhat.com, peterx@redhat.com

It's never documented, and now we have one more parameter for it (which
obsoletes this one). Document it properly.

Although now when enforce-config-section is set, it'll override the
other "-global" parameter, that is not necessarily a rule. Forbid that
usage in the document.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2.1 -> v2.2
- remove the last two lines of document [Eduardo]

 qemu-options.hx | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 297bd8a..cd95516 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -85,6 +85,12 @@ Enables or disables NVDIMM support. The default is off.
 @item s390-squash-mcss=on|off
 Enables or disables squashing subchannels into the default css.
 The default is off.
+@item enforce-config-section=on|off
+If @option{enforce-config-section} is set to @var{on}, force migration
+code to send configuration section even if the machine-type sets the
+@option{migration.send-configuration} property to @var{off}.
+NOTE: this parameter is deprecated. Please use @option{-global}
+@option{migration.send-configuration}=@var{on|off} instead.
 @end table
 ETEXI
 
-- 
2.7.4
