Received: from eggs.gnu.org ([2001:4830:134:3::10]:54831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cuxmG-0002Q8-LP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cuxmB-0003fU-Pf
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:55:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37038
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cuxmB-0003ce-JJ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:55:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v338rtQR062632
	for <qemu-devel@nongnu.org>; Mon, 3 Apr 2017 04:55:50 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29k21trwhb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:55:49 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 3 Apr 2017 09:55:45 +0100
Date: Mon, 3 Apr 2017 10:55:38 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170401004624.30886-3-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170403105538.606f5ca9.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC 02/19] s390: Add FIXME for unexplained
 user_creatable=false line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

On Fri, 31 Mar 2017 21:46:07 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> TYPE_S390_PCI_HOST_BRIDGE has user_creatable=false but has
> no comment explaining why. Add a FIXME to document that.
> 
> Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 1ec30c45ce..2c3b960bdf 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -867,7 +867,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>  
> -    dc->user_creatable = false;
> +    dc->user_creatable = false; /*FIXME: explain why */
>      dc->reset = s390_pcihost_reset;
>      k->init = s390_pcihost_init;
>      hc->plug = s390_pcihost_hot_plug;

(adding some more possibly interested parties)

We currently have one master s390 phb (and it's been that way since
s390 pci was introduced). Recently, there has been some remodelling
going on to make this more similar to what sPAPR does. I think we could
make this even more similar to sPAPR and have this user createable; but
I'm currently not sure it's worth the effort. Opinions?
