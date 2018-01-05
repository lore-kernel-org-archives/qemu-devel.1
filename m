Received: from eggs.gnu.org ([2001:4830:134:3::10]:52152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXVNL-0002sf-L6
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXVNH-0000O4-N4
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eXVNH-0000Ml-8x
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:01:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1731B25B89
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 17:01:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  5 Jan 2018 17:01:36 +0000
Message-Id: <20180105170138.23357-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] find_ram_offset cleanups and alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is mainly the alignment change that Paolo asked for
in the 2nd commit, but while I was there I added some comments
and tracing that I've split out.

Dave

Dr. David Alan Gilbert (2):
  find_ram_offset: Add comments and tracing
  find_ram_offset: Align ram_addr_t allocation on long boundaries

 exec.c       | 22 +++++++++++++++++++++-
 trace-events |  3 +++
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.14.3
