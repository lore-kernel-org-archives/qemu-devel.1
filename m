Received: from eggs.gnu.org ([209.51.188.92]:47508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grjWD-00049H-Cc
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grjW9-0007Zu-RK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:15:05 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Feb 2019 14:14:54 +0100
Message-Id: <1549545296-18903-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Deprecation patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org

A fix for a wrongly resolved merge conflict in qemu-deprecated.texi,
and the removal of the deprecated -clock option.

Thomas Huth (2):
  qemu-deprecated: Remove -virtioconsole and -no-frame for good
  qemu-options: Remove deprecated option -clock

 qemu-deprecated.texi | 17 -----------------
 qemu-options.hx      |  3 ---
 vl.c                 |  6 ------
 3 files changed, 26 deletions(-)

-- 
1.8.3.1
