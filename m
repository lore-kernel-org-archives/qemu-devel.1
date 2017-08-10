Received: from eggs.gnu.org ([2001:4830:134:3::10]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfeAU-0001I3-1Q
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfeAQ-0001C4-Tk
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dfeAQ-0001BO-O0
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:29:50 -0400
References: <20170809163019.21593-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3aa9a02a-a550-6e73-77d4-d06e1c1ed59f@redhat.com>
Date: Thu, 10 Aug 2017 05:29:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170809163019.21593-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On 09.08.2017 18:30, Cornelia Huck wrote:
> Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
> on CONFIG_VIRTFS and CONFIG_VIRTIO/CONFIG_XEN only.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> v2->v3: switch dependencies to VIRTFS && (VIRTIO || XEN)
>         add explict VIRTIO dependency for virtio-9p-device.o
> 
> ---
>  fsdev/Makefile.objs   | 9 +++------
>  hw/9pfs/Makefile.objs | 2 +-
>  hw/Makefile.objs      | 2 +-
>  3 files changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
