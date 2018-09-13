Received: from eggs.gnu.org ([2001:4830:134:3::10]:50275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0PZU-0006Cj-ST
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0PZQ-0006cg-Se
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g0PZQ-0006cM-MQ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:14:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0877D36883
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 11:14:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 13 Sep 2018 13:06:00 +0200
Message-Id: <1536836762-273036-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v8 0/2] deprecate incorrect CPUs topolog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com

Changelog since v7:
  * drop repetitive sentence in deprication doc (Eric Blake <eblake@redhat.com>)
Changelog since v5:
  * add(v6) and then remove(v7) Notes section to/from deprication doc
     (Eduardo Habkost <ehabkost@redhat.com>)
  * fix up wording and math formating in deprication doc
     (Eduardo Habkost <ehabkost@redhat.com>)
  * drop !socket check as it always evaluates to true at that point
     (Eduardo Habkost <ehabkost@redhat.com>)
Changelog since v4:
  * extend deprication doc, adding that maxcpus should be multiple of
        present on CLI [sockets/cores/threads] options
        (Eduardo Habkost <ehabkost@redhat.com>)

series bundles together 2 related patches posted separately earlier:
  vl.c deprecate incorrect CPUs topology
  vl:c: make sure that sockets are calculated  correctly in '-smp X' case

Goal is to depricate invalid topologies so we could make sure that topology
configuration is correct by forbidding invalid input once deprecation
period ends.


CC: eblake@redhat.com
CC: ehabkost@redhat.com

Igor Mammedov (2):
  vl.c deprecate incorrect CPUs topology
  vl:c: make sure that sockets are calculated correctly in '-smp X' case

 qemu-deprecated.texi | 12 ++++++++++++
 vl.c                 | 12 +++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.7.4
