Received: from eggs.gnu.org ([2001:4830:134:3::10]:47002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEe5E-00054V-F7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEe5A-0003dL-H8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51706 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEe5A-0003cm-Da
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98B8E4026779
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 17:01:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  4 May 2018 19:01:05 +0200
Message-Id: <1525453270-23074-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Removal of deprecated -no-kvm* options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>

The -no-kvm* options are a remainder of the ancient "qemu-kvm"
fork. They have never been officially documented in our qemu-doc,
they have been marked as deprecated in the sources since a very
long time, and we've marked them as deprecated in our qemu-doc
since QEMU v2.10. So far I haven't seen any complaints that we
should keep them, so it's time to remove these old parameters now.

While I'm at it, this patch series also removes a left-over from
the "-tdf" option (which has been removed with QEMU v2.12) and
fixes a deficiency in the option parsing code that has been
revealed by the remainder of the "-tdf" option.

Thomas Huth (5):
  qemu-options: Remove remainders of the -tdf option
  qemu-options: Bail out on unsupported options instead of silently
    ignoring them
  qemu-options: Remove deprecated -no-kvm-pit-reinjection
  qemu-options: Remove deprecated -no-kvm-irqchip
  qemu-options: Remove deprecated -no-kvm

 include/qemu-common.h |  2 +-
 os-posix.c            |  6 +++++-
 os-win32.c            |  4 ++--
 qemu-doc.texi         | 15 ---------------
 qemu-options.hx       | 13 -------------
 vl.c                  | 26 ++++----------------------
 6 files changed, 12 insertions(+), 54 deletions(-)

-- 
1.8.3.1
