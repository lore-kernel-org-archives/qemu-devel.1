Received: from eggs.gnu.org ([2001:4830:134:3::10]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb2wA-0000u7-Ja
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb2w9-0002T4-Kz
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cb2w9-0002Pj-Ey
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:23:49 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D76B61B8E
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 10:23:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  7 Feb 2017 11:23:40 +0100
Message-Id: <1486463022-4780-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH 0/2] Fix HTML issues discovered with
 the W3 HTML validator
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

The W3 HTML validator (https://validator.w3.org/) complains about
missing "alt" attributes and a missing "</section>" tag for the
new QEMU website. Here are two patches to fix the issues.

Thomas Huth (2):
  Add missing HTML tag to close the screenshots section
  Add "alt" attributes to the img tags

 _includes/screenshot.html | 2 +-
 index.html                | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.3.1
