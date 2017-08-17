Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGYO-0006Do-5J
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGYJ-0004eN-BW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:53:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diGYJ-0004e2-4M
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:53:19 -0400
Date: Thu, 17 Aug 2017 10:53:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817105305.3d845d40.cohuck@redhat.com>
In-Reply-To: <1502951113-4246-4-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Thu, 17 Aug 2017 08:25:10 +0200
Thomas Huth <thuth@redhat.com> wrote:

> By using the "virtio-xxx" device name aliases instead of the
> "virtio-xxx-pci" names, we can use this test on s390x, too,
> to check that adding and deleting also works fine with the
> virtio-ccw bus.

I don't think we should leak the aliasing stuff into tests, but rather
specify the transport on a per-architecture basis explicitly. (We might
want to test virtio-pci on s390x in the future as well -- in addition
to virtio-ccw, not replacing it.)

Also, the same question as for the previous patch: Is this supposed to
test virtio explicitly, or do we just want a reasonable device?

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |  1 +
>  tests/drive_del-test.c | 13 +++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
