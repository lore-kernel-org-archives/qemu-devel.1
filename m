Received: from eggs.gnu.org ([209.51.188.92]:52715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hJChc-0003k9-9v
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hJCek-00081k-UB
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:49:27 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Wed, 24 Apr 2019 10:48:59 +0300
Message-Id: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH 0/2]: vmdk: Add read-only support for the new
 seSparse format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, eyal.moscovici@oracle.com, liran.alon@oracle.com, qemu-devel@nongnu.org, shmuel.eiderman@oracle.com

VMware introduced a new snapshot format in VMFS6 - seSparse (Space
Efficient Sparse) which is the default format available in ESXi 6.7.
Add read-only support for the new snapshot format.
