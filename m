Received: from eggs.gnu.org ([2001:4830:134:3::10]:43356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dfBdu-0006Kf-8e
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 17:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dfBdq-0007bt-9i
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 17:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dfBdq-0007aN-3a
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 17:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1B355AFED
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:53:50 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  8 Aug 2017 16:53:26 -0400
Message-Id: <20170808205327.8768-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] QAPI schema: turn example commands/returns
 into proper JSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

The QAPI schema documentation sections contain examples of QMP input
and output.  These are supposed to follow the "JSON-based" wire
protocol, but in practice, there are a few data structure problems and
also documentation.

This turns all inputs and outputs into parseable JSON-like data.
Besides allowing humans to copy and paste the examples without
surprises, this also paves the way towards automatic execution of
examples as tests.

Cleber Rosa(1):
   QAPI schema: turn example commands/returns into proper JSON

 qapi-schema.json     |  9 ++++-----
 qapi/block-core.json | 32 ++++++++++++++++----------------
 qapi/rocker.json     |  5 +----
 3 files changed, 21 insertions(+), 25 deletions(-)
