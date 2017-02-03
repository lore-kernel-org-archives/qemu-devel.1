Received: from eggs.gnu.org ([2001:4830:134:3::10]:33131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZhMc-0006OT-Sj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZhMZ-0003jS-NS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:09:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cZhMZ-0003io-HC
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:09:31 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Fri,  3 Feb 2017 17:09:24 +0000
Message-Id: <20170203170925.12554-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v3] qemu-nbd: Implement socket activation.
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

v2 -> v3:

- Changes suggested by Stefan.

- Retested it, using my socket activation code in virt-p2v:
  https://www.redhat.com/archives/libguestfs/2017-February/msg00036.html

Rich.
