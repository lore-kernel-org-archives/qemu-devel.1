Received: from eggs.gnu.org ([2001:4830:134:3::10]:33276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZG7z-0006vb-VT
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZG7v-0002WA-UZ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:04:39 -0500
Date: Thu, 2 Feb 2017 07:04:21 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1666046970.16239766.1486037061141.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170202101758.GC22164@stefanha-x1.localdomain>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
	<1485800032-24404-2-git-send-email-hch@lst.de>
	<20170201164050.GD12283@stefanha-x1.localdomain>
	<af5d7115-1b30-41aa-f3e5-0c4e4271d52c@redhat.com>
	<20170202101758.GC22164@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] nvme: implement the DSM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, keith busch <keith.busch@intel.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

> On Wed, Feb 01, 2017 at 12:29:22PM -0800, Paolo Bonzini wrote:
> > On 01/02/2017 08:40, Stefan Hajnoczi wrote:
> > >> +        goto out_free_range;
> > >> +    }
> > >> +
> > >> +    if (dma_buf_write((uint8_t *)range, sizeof(range), &qsg)) {
> > > 
> > > Did you mean sizeof(*range) * nr?
> > 
> > Did you also mean dma_buf_read (you want to read from device to range)?
> 
> uint64_t dma_buf_write(uint8_t *ptr, int32_t len, QEMUSGList *sg)
> {
>     return dma_buf_rw(ptr, len, sg, DMA_DIRECTION_TO_DEVICE);
> }
> 
> DMA_DIRECTION_TO_DEVICE seems correct.

Yes, it is.

Paolo
