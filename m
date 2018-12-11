Received: from eggs.gnu.org ([2001:4830:134:3::10]:50095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWZID-0005EQ-GI
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 23:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWZI9-0006sf-SC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 23:05:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gWZI9-0006s4-Ld
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 23:05:05 -0500
Date: Mon, 10 Dec 2018 23:04:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181210230435-mutt-send-email-mst@kernel.org>
References: <7CECC2DFC21538489F72729DF5EFB4D908ABD3A4@dggemm521-mbs.china.huawei.com>
	<20181209211730-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC486D@DGGEMM501-MBX.china.huawei.com>
	<20181210130650-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC78EE@DGGEMM501-MBX.china.huawei.com>
	<20181210205229-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC7980@DGGEMM501-MBX.china.huawei.com>
	<20181210223128-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC7A04@DGGEMM501-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D908AC7A04@DGGEMM501-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [BUG]Unassigned mem write during pci device
 hot-plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xuyandong <xuyandong2@huawei.com>
Cc: "marcel@redhat.com" <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On Tue, Dec 11, 2018 at 03:51:09AM +0000, xuyandong wrote:
> > There could we a way to work around this.
> > Does below help?
> 
> I am sorry to tell you, I tested this patch and it doesn't work fine.

What happens?

> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c index
> > 236a20eaa8..7834cac4b0 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -551,7 +551,7 @@ static void build_append_pci_bus_devices(Aml
> > *parent_scope, PCIBus *bus,
> > 
> >          aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> >          aml_append(method,
> > -            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Check */)
> > +            aml_call2("DVNT", aml_name("PCIU"), aml_int(4) /* Device
> > + Check Light */)
> >          );
> >          aml_append(method,
> >              aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Request */)
