Received: from eggs.gnu.org ([2001:4830:134:3::10]:45982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUa-0002ry-4u
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUV-00028g-7X
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDvUV-00028W-2j
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6B474072CF9
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 17:24:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 May 2018 19:24:24 +0200
Message-Id: <1525281868-24747-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Removal of deprecated -no-kvm* options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The -no-kvm* options are a remainder of the ancient "qemu-kvm"
fork. They have never been officially documented in our qemu-doc,
they have been marked as deprecated in the sources since a very
long time, and we've marked them as deprecated in our qemu-doc
since QEMU v2.10. So far I haven't seen any complaints that we
should keep them, so it's time to remove these old parameters now.

Thomas Huth (4):
  qemu-options: Remove remainders of the -tdf option
  qemu-options: Remove deprecated -no-kvm-pit-reinjection
  qemu-options: Remove deprecated -no-kvm-irqchip
  qemu-options: Remove deprecated -no-kvm

 qemu-doc.texi   | 15 ---------------
 qemu-options.hx | 13 -------------
 vl.c            | 21 ---------------------
 3 files changed, 49 deletions(-)

-- 
1.8.3.1
