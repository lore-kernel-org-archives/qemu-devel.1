Received: from eggs.gnu.org ([2001:4830:134:3::10]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFD-0001XI-5o
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFB-00048g-6O
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36119 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1ddeFA-00041J-Qx
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:29 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Fri,  4 Aug 2017 18:10:10 +0300
Message-Id: <20170804151013.13057-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 0/3] respect bdrv_getlength() error code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

These cases were reported by Markus Armbruster <armbru@redhat.com>
Patches add error checking of the bdrv_getlength() call or remove
the call of that function.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
