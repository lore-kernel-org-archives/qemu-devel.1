Received: from eggs.gnu.org ([2001:4830:134:3::10]:54080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsT-0007J8-WC
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsO-0007mU-VT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:49 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42616
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYGsO-0007l7-PI
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:44 -0400
From: anton.ivanov@cambridgegreys.com
Date: Thu, 20 Jul 2017 20:12:23 +0100
Message-Id: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] Unified Datagram Socket Transport
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

Hi all,

This addresses comments so far except Eric's suggestion to use
InetSocketAddressBase. If I understand correctly its intended use,
it will not be of help for protocols which have no port (raw
sockets - GRE, L2TPv3, etc).

It also includes a port of the original socket.c transport to
the new UDST backend. The relevant code is ifdef-ed so there
should be no effect on other systems.

I think that this is would be the appropriate place to stop in this
iteration. I would prefer to have this polished, before I start
looking at sendmmsg and bulk send or some of the more unpleasant
encapsulations like geneve.

A.
