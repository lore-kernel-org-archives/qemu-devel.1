Received: from eggs.gnu.org ([209.51.188.92]:50924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghphW-0001Ir-EE
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 00:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghphU-0002bW-Fm
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 00:49:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:14145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ghphS-0002Y9-P5
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 00:49:48 -0500
Date: Fri, 11 Jan 2019 13:46:04 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190111054604.GA1038@yangzhon-Virtual>
References: <20190110083753.GA31730@yangzhon-Virtual>
	<20190110103636.GG19025@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110103636.GG19025@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] If Qemu support NVMe over Fabrics ?y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, pbonzini@redhat.com, keith.busch@intel.com, Yang Zhong <yang.zhong@intel.com>

On Thu, Jan 10, 2019 at 10:36:37AM +0000, Stefan Hajnoczi wrote:
> On Thu, Jan 10, 2019 at 04:37:53PM +0800, Yang Zhong wrote:
> > Do you know if Qemu support NVMe over Fabrics(NVMe-oF)?
> > https://nvmexpress.org/wp-content/uploads/NVMe_Over_Fabrics.pdf
> > 
> > The Qemu has enabled RDMA in last year, and i am not sure if Qemu 
> > should support NVME-oF. If Qemu support it, would you please share
> > me the qemu related command or guides? thanks a lot!
> 
> QEMU supports many different storage configurations.  Can you be more
> specific?
> 
> For example, if your host has NVMe-oF set up then you can give the NVMe
> block devices to QEMU just like any other host block device (-drive
> file=/dev/sdc,...).
> 
> But maybe you are thinking about other configurations, like exposing
> NVMe-oF to the guest?
> 
  Thanks Stefan's comments. We only want Qemu as NVMe-oF initiator to
  access remote target's resource.

  I checked the block/nvme.c and hw/block/nvme.c code, which seems do
  not support NVMe-oF . If i am wrong please correct me.

  If Qemu support NVMe-oF initiator, please share me how to use it. 
  If Qemu does not support it, please tell me if community has plan 
  to implement it. thanks a lot!
 
  Regards,

  Yang
 
> Stefan
