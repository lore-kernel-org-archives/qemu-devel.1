Received: from eggs.gnu.org ([2001:4830:134:3::10]:34806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cvgjR-0003wY-AV
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cvgjO-00067a-4Y
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:56:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56696
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cvgjN-00065S-UB
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:55:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v358raUg026776
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 04:55:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29mtpqpxty-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 04:55:55 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 5 Apr 2017 09:55:53 +0100
Date: Wed, 5 Apr 2017 10:55:47 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170404202429.14643-22-ehabkost@redhat.com>
References: <20170404202429.14643-1-ehabkost@redhat.com>
	<20170404202429.14643-22-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170405105547.00b5ed92.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 21/21] s390-pcibus: No need to set
 user_creatable=false explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue,  4 Apr 2017 17:24:29 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> TYPE_S390_PCI_HOST_BRIDGE is a subclass of TYPE_PCI_HOST_BRIDGE,
> which is a subclass of TYPE_SYS_BUS_DEVICE. TYPE_SYS_BUS_DEVICE
> already sets user_creatable=false, so we don't require an
> explicit user_creatable=false assignment in
> s390_pcihost_class_init().
> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v1 -> v2:
> * Previous patch was:
>   "s390: Add FIXME for unexplained user_creatable=false line",
>   but now we know we can remove the explicit user_creatable=false
>   assignment
> ---
>  hw/s390x/s390-pci-bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 1ec30c45ce..973893df07 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -867,7 +867,6 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>  
> -    dc->user_creatable = false;
>      dc->reset = s390_pcihost_reset;
>      k->init = s390_pcihost_init;
>      hc->plug = s390_pcihost_hot_plug;

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
