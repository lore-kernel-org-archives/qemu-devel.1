Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZx9N-0000rD-RP
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 05:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZx9J-0002tx-T0
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 05:00:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cZx9J-0002ti-N5
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 05:00:53 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Sat,  4 Feb 2017 10:00:47 +0000
Message-Id: <20170204100048.31850-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v4] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com, stefanha@gmail.com

v3 -> v4:

- Remove restriction on --fork again.

- Retest the patch using virt-p2v.

Rich.
