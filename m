Received: from eggs.gnu.org ([2001:4830:134:3::10]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas.tai@oracle.com>) id 1fGUbf-00054V-TD
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas.tai@oracle.com>) id 1fGUbc-00029s-LR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:18:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thomas.tai@oracle.com>)
	id 1fGUbc-00029U-9y
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:18:28 -0400
From: Thomas Tai <thomas.tai@oracle.com>
Date: Wed,  9 May 2018 15:53:04 -0400
Message-Id: <1525895585-79023-1-git-send-email-thomas.tai@oracle.com>
Subject: [Qemu-devel] [PATCH V2 0/1] virtio-balloon: fix internal stat name
 array to match Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, rob.gardner@oracle.com, thomas.tai@oracle.com

Hi Michael,
As you have suggested I have imported the kernel header
file and use the new macro to create the string array.
Would you kindly review the patch for me? Please feel
free to comment.

Thank you,
Thomas
