Received: from eggs.gnu.org ([2001:4830:134:3::10]:50275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjxE-0005Im-Ph
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjxB-0008Pm-JX
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:03:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXjxB-0008Pb-DG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:03:29 -0400
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-7-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c72a0745-1383-7d67-851f-61cd6d043142@redhat.com>
Date: Wed, 19 Jul 2017 10:03:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170718142455.32676-7-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 6/9] s390x/sclp: properly guard
 pci-specific functions
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
> If we do not provide zpci, pci reconfiguration via sclp is not available
> either. Don't indicate it in the sclp facilities and return an invalid
> command if the guest tries to issue pci configure/deconfigure.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/sclp.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
