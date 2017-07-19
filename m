Received: from eggs.gnu.org ([2001:4830:134:3::10]:45924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjiO-0007Ux-CO
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjiK-00024b-EW
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXjiK-00024B-86
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:48:08 -0400
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-3-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4cbc5c19-6c4d-6387-2b8d-8635918a41b9@redhat.com>
Date: Wed, 19 Jul 2017 09:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170718142455.32676-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/9] s390x/pci: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 18.07.2017 16:24, Cornelia Huck wrote:
> Some non-pci code calls into zpci code. Provide some stubs for builds
> without pci.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/Makefile.objs   |  3 +-
>  hw/s390x/s390-pci-stub.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 hw/s390x/s390-pci-stub.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
