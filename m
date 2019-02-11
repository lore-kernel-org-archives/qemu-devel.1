Received: from eggs.gnu.org ([209.51.188.92]:47658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtD1b-0002DY-Lu
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtD1a-0002t4-D7
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:57:35 -0500
Date: Mon, 11 Feb 2019 15:57:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190211155714.0b657552.cohuck@redhat.com>
In-Reply-To: <8d2c66ce-fdc6-d12b-256c-1760330c4360@de.ibm.com>
References: <20190211113255.3837-1-cohuck@redhat.com>
	<8d2c66ce-fdc6-d12b-256c-1760330c4360@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: always provide pci support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>

On Mon, 11 Feb 2019 15:05:46 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11.02.2019 12:32, Cornelia Huck wrote:
> > We tried to make pci support optional on s390x in the past;
> > unfortunately, we still require the s390 phb to be created
> > unconditionally due to backwards compatibility issues.
> > 
> > Instead of sinking more effort into this (including compat
> > handling for older machines etc.) for non-obvious gains, let's
> > just make CONFIG_PCI something that is always set on s390x.
> > 
> > Note that you can still fence off pci for the _guest_ if you
> > provide a cpu model without the zpci feature.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> The previous attempts of making it configurable caused more  pain than
> benefit.

I think we've reaped all the benefits of the attempt already (making
relevant instructions check for the zpci feature bit).
