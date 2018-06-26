Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fXlAj-0006TM-11
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fXlAd-00052t-UM
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fXlAd-00052J-Q2
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:25:59 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D466281F0C
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 10:25:58 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Tue, 26 Jun 2018 11:25:53 +0100
Message-Id: <20180626102554.23290-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2] crypto: Implement TLS Pre-Shared Keys (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v1 was here:

  https://lists.nongnu.org/archive/html/qemu-devel/2018-06/threads.html#07252

For v2:

 - Added documentation as suggested by Dan B.

 - Fixed a backwards test of creds->username which slipped into the
   previous version by accident because I was fiddling around with the
   code after I'd tested it but before posting it.  This version
   actually works.

Note also there is an nbdkit patch:

  https://www.redhat.com/archives/libguestfs/2018-June/thread.html#00121

nbdkit has an automated test that qemu TLS-PSK (NBD client)
interoperates with nbdkit (NBD server), so we can be confident that
the client functionality will receive continuous testing in future.

Rich.
