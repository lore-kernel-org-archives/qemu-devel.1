Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH66P-0005wH-Im
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH66M-0004MY-Fo
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:48:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eH66M-0004MD-8s
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:48:26 -0500
Date: Tue, 21 Nov 2017 11:48:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121114822.4458fb2a.cohuck@redhat.com>
In-Reply-To: <1510854715-7081-6-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-6-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] s390x/pci: move the memory region
 read from pcilg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Thu, 16 Nov 2017 18:51:53 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Let's move the memory region read from pcilg into a dedicated function.
> This allows us to prepare a later patch.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Looks good.
