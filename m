Received: from eggs.gnu.org ([209.51.188.92]:53087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMBSd-0004iF-4K
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMBSc-0006kc-Dv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:09:15 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Thu,  2 May 2019 16:08:21 +0300
Message-Id: <20190502130822.46858-1-shmuel.eiderman@oracle.com>
In-Reply-To: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
Subject: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to vmdk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, fam@euphon.net, eblake@redhat.com
Cc: shmuel.eiderman@oracle.com, arbel.moshe@oracle.com

Fixing broken iotests 110 and and 126 by filtering out
"backing file format" as Max suggested.
