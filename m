Received: from eggs.gnu.org ([2001:4830:134:3::10]:33205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNT1A-0006nI-V6
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 20:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNT17-0000ya-Qc
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 20:33:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:16114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gNT17-0000hS-Hl
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 20:33:53 -0500
Message-ID: <5BEE1FA0.10002@intel.com>
Date: Fri, 16 Nov 2018 09:38:40 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <154230782139.21.15647395935691674416@c26723477dc9>
In-Reply-To: <154230782139.21.15647395935691674416@c26723477dc9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 0/8] virtio-balloon: free page hint
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, liliang.opensource@gmail.com, peterx@redhat.com, pbonzini@redhat.com, nilal@redhat.com

On 11/16/2018 02:50 AM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
>    CC      net/filter.o
>    CC      net/filter-buffer.o
>    CC      net/filter-mirror.o
>    CC      net/colo-compare.o
> /tmp/qemu-test/src/migration/rdma.c: In function 'qemu_rdma_accept':
> /tmp/qemu-test/src/migration/rdma.c:3353:5: error: implicit declaration of function 'migrate_postcopy' [-Werror=implicit-function-declaration]
>       if (migrate_postcopy() && !rdma->is_return_path) {
>       ^
> /tmp/qemu-test/src/migration/rdma.c:3353:5: error: nested extern declaration of 'migrate_postcopy' [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> make: *** [migration/rdma.o] Error 1
> make: *** Waiting for unfinished jobs....

This is caused by missing "migration/misc.h" in rdma.c, since we moved 
the migrate_postcopy() declaration there. I'll add it.

Best,
Wei
