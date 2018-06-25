Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fXUxY-0006aR-PG
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fXUxW-0002eJ-4d
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fXUxV-0002dp-VT
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7A6C87625
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 17:07:20 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Mon, 25 Jun 2018 18:07:14 +0100
Message-Id: <20180625170715.23149-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH] crypto: Implement TLS Pre-Shared Keys (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

TLS-PSK (Pre-Shared Keys) lets us set up TLS connections much more
easily, especially for NBD.

This is a "version 0" of the patch for now, mainly to solicit
comments.  It needs documentation at least.

Rich.
