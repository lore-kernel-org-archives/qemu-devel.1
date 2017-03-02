Received: from eggs.gnu.org ([2001:4830:134:3::10]:51700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTRz-0001Us-KH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTRx-0005Pc-0J
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:19:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjTRw-0005PM-Pz
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:19:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA87180F94
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 16:19:28 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  2 Mar 2017 16:19:19 +0000
Message-Id: <20170302161921.10181-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] migration: fixes to handling
 tls-hostname/tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The need for these two patches was identified during implementation  of
TLS encrypted migration in libvirt.

Changed in v3:

 - Add to qapi-schema.json docs

Daniel P. Berrange (2):
  migration: allow clearing migration string parameters
  migration: always report tls-creds & tls-hostname migrate parameters

 migration/migration.c | 22 ++++++++++++++++------
 qapi-schema.json      |  8 +++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.9.3
