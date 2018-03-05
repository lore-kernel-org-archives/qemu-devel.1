Received: from eggs.gnu.org ([2001:4830:134:3::10]:33094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslU9-0000MA-5s
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslU5-0008N0-46
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:54305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eslU4-0008Mm-Rx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:37 -0500
Date: Mon, 5 Mar 2018 16:11:43 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305081143.GD2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-6-git-send-email-yi.l.liu@linux.intel.com>
	<aabe6bc6-5dbc-c3d7-1461-ead8cefa8466@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabe6bc6-5dbc-c3d7-1461-ead8cefa8466@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/12] hw/pci: introduce PCISVAOps to
 PCIDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On Fri, Mar 02, 2018 at 04:10:48PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 11:33, Liu, Yi L wrote:
> > +void pci_setup_sva_ops(PCIDevice *dev, PCISVAOps *ops)
> > +{
> > +    if (dev) {
> > +        dev->sva_ops = ops;
> > +    }
> > +    return;
> > +}
> > +
> 
> Better:
> 
> {
>     assert(ops && !dev->sva_ops);
>     dev->sva_ops = ops;
> }

Thanks, would apply in next version.

Regards,
Yi Liu
