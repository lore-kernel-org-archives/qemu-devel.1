Received: from eggs.gnu.org ([2001:4830:134:3::10]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXvBi-0007px-GK
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 16:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXvBf-0004bz-UM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 16:03:14 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42498
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXvBf-0004aV-PR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 16:03:11 -0400
From: anton.ivanov@cambridgegreys.com
Date: Wed, 19 Jul 2017 21:02:55 +0100
Message-Id: <20170719200259.17428-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] Revised Unified Datagram Socket Transport patchset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com

Hi Jason, hi list,

Follows a revised patchset. I have addressed most comments.

TODO: replace memcpy with dup where applicable
TODO: add force v4 option
TODO: port the UDP portion of the existing socket transport
to the new infrastructure

Future: add sendmmsg once a "bulk xmit" has been arranged
on the QEMU hw and/or lower network subsystem layers side.
