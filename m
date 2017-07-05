Received: from eggs.gnu.org ([2001:4830:134:3::10]:36339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZC-0005ux-CP
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSfZB-0000UX-Ft
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSfZB-0000UK-5Y
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:21:45 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Jul 2017 16:21:22 +0800
Message-Id: <1499242883-2184-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1499242883-2184-1-git-send-email-peterx@redhat.com>
References: <1499242883-2184-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] doc: add item for "-M
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, haoqf@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It's never documented, and now we have one more parameter for it (which
obsoletes this one). Document it properly.

Although now when enforce-config-section is set, it'll override the
other "-global" parameter, that is not necessarily a rule. Forbid that
usage in the document.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qemu-options.hx | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 297bd8a..2c1116e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -85,6 +85,17 @@ Enables or disables NVDIMM support. The default is off.
 @item s390-squash-mcss=on|off
 Enables or disables squashing subchannels into the default css.
 The default is off.
+@item enforce-config-section=on|off
+If @option{enforce-config-section} is set to @var{on}, force migration
+code to send configuration section even if the machine-type sets the
+@option{migration.send-configuration} property to @var{off}.
+@option{enforce-config-section} cannot be used together with
+@option{-global} @option{migration.send-configuration}. Behavior is
+undefined if @option{enforce-config-section} and @option{-global}
+@option{migration.send-configuration} are used together.
+
+NOTE: this parameter is deprecated. Please use @option{-global}
+@option{migration.send-configuration}=@var{on|off} instead.
 @end table
 ETEXI
 
-- 
2.7.4
