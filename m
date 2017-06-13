Received: from eggs.gnu.org ([2001:4830:134:3::10]:58470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiX4-000416-J0
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiX0-0004cU-32
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiWz-0004cM-Sy
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:54:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D063823E6C1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:54:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:54:30 +0200
Message-Id: <20170613095432.11623-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Check migration enabled features on both
 sides
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This was part of my multifd series, it just "requires" that
migartion features being enabled on both sides.
- XBZRLE: libvirt only enables it on source, so we don't test it

- compression threads: we check at reception when we receive a
                       compression page that we have compression
                       threads enabled.  Otherwise we exit with one
                       error.

- Now that we check if compression threads are enabled, we don't
  create the threads if they are not enabled.

  It makes debugging much easier, because I have less threads on
  destination to search where things are hang up.

Please review,

Thanks, Juan.

Juan Quintela (2):
  migration: Test for disabled features on reception
  migration: Don't create decompression threads if not enabled

 migration/ram.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
2.9.4
