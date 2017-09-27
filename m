Received: from eggs.gnu.org ([2001:4830:134:3::10]:57494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ0U-0005mC-Ga
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ0P-0007UJ-KE
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxJ0P-0007Tv-EN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0744335655
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:32:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 17:32:23 -0300
Message-Id: <20170927203225.30896-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
have no default config files that would be disabled using
-nodefconfig.  This series cleans up the code, updates
documentation, and document -nodefconfig as deprecated.

Eduardo Habkost (2):
  vl: Eliminate defconfig variable
  qemu-options: Deprecate -nodefconfig

 vl.c            |  5 +----
 qemu-options.hx | 13 +++++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.13.5
