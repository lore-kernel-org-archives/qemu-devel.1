Received: from eggs.gnu.org ([2001:4830:134:3::10]:36640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eJgT2-00073P-9N
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eJgSs-0001Mp-NQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:02:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eJgSs-0001Mc-FN
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:02:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASE1bsB109551
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 09:02:19 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eh92y0h45-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 09:02:19 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 28 Nov 2017 14:02:15 -0000
References: <20171128134648.21530-1-cohuck@redhat.com>
	<20171128134648.21530-2-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 28 Nov 2017 15:02:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171128134648.21530-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9c8eb74b-ddc7-3fc6-d26f-efa5fea72fcc@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] s390x/css: attach css bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

Looks good to me and is similar to the other devices (e.g. the IPL device)

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>



On 11/28/2017 02:46 PM, Cornelia Huck wrote:
> Logically, the css bridge should be attached to the machine.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/css-bridge.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index c4a9735d71..84d33eafc2 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -99,6 +99,8 @@ VirtualCssBus *virtual_css_bus_init(void)
> 
>      /* Create bridge device */
>      dev = qdev_create(NULL, TYPE_VIRTUAL_CSS_BRIDGE);
> +    object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
> +                              OBJECT(dev), NULL);
>      qdev_init_nofail(dev);
> 
>      /* Create bus on bridge device */
> 
