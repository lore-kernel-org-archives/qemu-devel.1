Received: from eggs.gnu.org ([2001:4830:134:3::10]:39107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr5uw-0006PT-NM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr5ut-0000tB-La
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cr5ut-0000sx-GO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:48:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35EE87AE9A
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 16:48:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Mar 2017 17:48:48 +0100
Message-ID: <87mvccaqhb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Question nbd_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

BlockdevOptionsNbd has a member SocketAddress, and nbd_config() doesn't
restrict variants.  Thus, all four SOCKET_ADDRESS_KIND_ can occur.

Now have a look at nbd_refresh_filename().  s->saddr->type is If
SOCKET_ADDRESS_KIND_VSOCK or SOCKET_ADDRESS_KIND_FD, then @host, @port
and @path all remain null, and bs->exact_filename[] is not touched.

Does this work as intended?
