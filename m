Received: from eggs.gnu.org ([2001:4830:134:3::10]:40525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb2wD-0000wI-D7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb2wB-0002Wx-Du
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cb2wB-0002VG-89
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:51 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 753A33B71B
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 10:23:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  7 Feb 2017 11:23:42 +0100
Message-Id: <1486463022-4780-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1486463022-4780-1-git-send-email-thuth@redhat.com>
References: <1486463022-4780-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH 2/2] Add "alt" attributes to the img
 tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

The "alt" attribute is mandatory for the img tags according to
the HTML standard, so we need this to get valid HTML.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _includes/screenshot.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/_includes/screenshot.html b/_includes/screenshot.html
index 3f85791..70b0d11 100644
--- a/_includes/screenshot.html
+++ b/_includes/screenshot.html
@@ -5,5 +5,5 @@
    else %}{{screenshot.description}}{%endif %}{%
    if screenshot.author %} {{screenshot.author | markdownify | remove: '<p>' | remove: '</p>' | strip_newlines | escape}} {% endif %}{%
    if screenshot.source %} (&lt;a href=&quot;{{screenshot.source}}&quot;&gt;Source&lt;/a&gt;){%endif %}"><img
-   src="screenshots/{{screenshot.file}}"/></a>
+   src="screenshots/{{screenshot.file}}" alt="Screenshot: {{screenshot.description}}"/></a>
 {% endfor %}
-- 
1.8.3.1
