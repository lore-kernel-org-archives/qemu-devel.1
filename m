Received: from eggs.gnu.org ([2001:4830:134:3::10]:35598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCx-0004p8-6B
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCw-0008KK-7l
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUcCw-0008JF-1i
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ED0A7F40C
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:10:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Jul 2017 18:10:34 +0100
Message-Id: <20170710171040.21021-4-dgilbert@redhat.com>
In-Reply-To: <20170710171040.21021-1-dgilbert@redhat.com>
References: <20170710171040.21021-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] doc: add item for "-M
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
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

It's never documented, and now we have one more parameter for it (which
obsoletes this one). Document it properly.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1499396048-21657-1-git-send-email-peterx@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Removed 'Although now' commit message as per Eduardo's review
---
 qemu-options.hx | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index ddab656eb3..76b1c67737 100644
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
2.13.0
