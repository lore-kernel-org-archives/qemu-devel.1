Received: from eggs.gnu.org ([2001:4830:134:3::10]:46410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1f1poK-0005kz-OO
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 04:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1f1poH-0006IN-MP
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 04:55:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2095 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiangyiwen@huawei.com>)
	id 1f1poH-0006Ai-Bb
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 04:54:57 -0400
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5ABDFB24.1080207@huawei.com>
Date: Fri, 30 Mar 2018 16:53:56 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC] About 9pfs support "O_DIRECT + aio"?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Morton <akpm@linux-foundation.org>, Eric Van Hensbergen <ericvh@gmail.com>, Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, qemu-devel@nongnu.org

Hi everyone,

Currently, I found virtio-9p in VirtFS don't support "O_DIRECT + aio"
mode, both v9fs and qemu. So when user use "O_DIRECT + aio" mode and
increase iodepths, they can't get higher IOPS.

I want to know why v9fs don't implement this mode? And I will try to
implement this mode from now on.

Thanks,
Yiwen.
