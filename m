Received: from eggs.gnu.org ([2001:4830:134:3::10]:52894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVwSF-00014L-7u
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVwSB-0004Zv-9G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:00:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVwSB-0004Ya-2a
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:00:03 -0400
Date: Fri, 14 Jul 2017 10:59:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170714105957.649fd693@gondolin>
In-Reply-To: <1499961789-127874-6-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
	<1499961789-127874-6-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] s390x/kvm: enable guarded storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>

On Thu, 13 Jul 2017 18:03:07 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Fan Zhang <zhangfan@linux.vnet.ibm.com>
> 
> Introduce guarded storage support for KVM guests on s390.
> We need to enable the capability, extend machine check validity,
> sigp store-additional-status-at-address, and migration.
> 
> The feature is fenced for older machine type versions.
> 
> Signed-off-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 18 ++++++++++
>  include/hw/s390x/s390-virtio-ccw.h |  3 ++
>  target/s390x/cpu.h                 |  7 ++++
>  target/s390x/kvm.c                 | 71 ++++++++++++++++++++++++++++++++------
>  target/s390x/machine.c             | 17 +++++++++
>  5 files changed, 106 insertions(+), 10 deletions(-)

I'll trust you on the bits.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
