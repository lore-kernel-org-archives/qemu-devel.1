Received: from eggs.gnu.org ([2001:4830:134:3::10]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHJq-0003j8-HW
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHJo-0000aT-0M
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZHJn-0000Zz-Qc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4A06780F6
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:25:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Jan 2018 15:25:13 +0100
Message-Id: <20180110142515.13242-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] find_ram_offset cleanups and alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com

These are basically David's patches, with a couple changes for clarity
and robustness.

Dr. David Alan Gilbert (2):
  find_ram_offset: Add comments and tracing
  find_ram_offset: Align ram_addr_t allocation on long boundaries

 exec.c       | 33 ++++++++++++++++++++++++++-------
 trace-events |  4 ++++
 2 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.14.3
