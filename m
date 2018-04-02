Received: from eggs.gnu.org ([2001:4830:134:3::10]:37044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f2pUg-00008D-BS
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f2pUd-00070k-61
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:46:50 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f2pUc-00070V-Vj
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 22:46:47 -0400
Received: by mail-wm0-f46.google.com with SMTP id p9so22896220wmc.3
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 19:46:46 -0700 (PDT)
References: <5ABDFB24.1080207@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41088460-11f1-1ec7-2bfa-1ebdf675dc17@redhat.com>
Date: Mon, 2 Apr 2018 04:45:36 +0200
MIME-Version: 1.0
In-Reply-To: <5ABDFB24.1080207@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] About 9pfs support "O_DIRECT + aio"?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiangyiwen <jiangyiwen@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, Eric Van Hensbergen <ericvh@gmail.com>, Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

On 30/03/2018 10:53, jiangyiwen wrote:
> Currently, I found virtio-9p in VirtFS don't support "O_DIRECT + aio"
> mode, both v9fs and qemu. So when user use "O_DIRECT + aio" mode and
> increase iodepths, they can't get higher IOPS.
> 
> I want to know why v9fs don't implement this mode? And I will try to
> implement this mode from now on.

Can you explain?  I think 9p has support for direct I/O in Linux.  See
v9fs_direct_IO in fs/9p/vfs_addr.c.

Paolo
