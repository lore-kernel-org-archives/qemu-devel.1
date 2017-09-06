Received: from eggs.gnu.org ([2001:4830:134:3::10]:35313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpXlO-0002qX-Qq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpXlK-0000AY-V7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpXlK-000088-Pl
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:40:50 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  6 Sep 2017 11:40:41 +0100
Message-Id: <20170906104043.30745-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] Improve websockets server error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brian Rak <brak@vultr.com>, "Daniel P. Berrange" <berrange@redhat.com>

The websockets server gives no useful error response to the client
nor provides any way to debug errors no the server

Daniel P. Berrange (2):
  io: send proper HTTP response for websocket errors
  io: include full error message in websocket handshake trace

 io/channel-websock.c | 184 ++++++++++++++++++++++++++++++++++++++-------------
 io/trace-events      |   2 +-
 2 files changed, 138 insertions(+), 48 deletions(-)

-- 
2.13.5
