Received: from eggs.gnu.org ([2001:4830:134:3::10]:54123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee1jR-0008P7-48
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee1jM-0002YX-7z
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ee1jM-0002Xi-1n
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B1E78553F
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 16:47:27 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 23 Jan 2018 16:47:16 +0000
Message-Id: <20180123164718.12714-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] Two fixes to make rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The primary goal of this was to fix the recent regression that made
everything done by make completely silent, causing things like
"make install" to emit no output. In doing so I noticed a small mistake
in the help text.

Daniel P. Berrange (2):
  Revert "build-sys: silence make by default or V=0"
  make: fix help message reference to bogus V=0 variable

 Makefile  | 5 +++--
 rules.mak | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.14.3
