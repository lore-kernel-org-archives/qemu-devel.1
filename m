Received: from eggs.gnu.org ([209.51.188.92]:42873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggf2Q-0006aZ-JV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggf2L-0004qy-KX
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:14:31 -0500
Date: Mon, 7 Jan 2019 19:14:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190107191401-mutt-send-email-mst@kernel.org>
References: <20181212091623.16950-1-david@redhat.com>
	<20181212091623.16950-5-david@redhat.com>
	<2527cf5c-983b-e4df-2c26-c47df87e6bf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2527cf5c-983b-e4df-2c26-c47df87e6bf0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/11] pci/pcie: stop plug/unplug if the
 slot is locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-ppc@nongnu.org

On Mon, Jan 07, 2019 at 01:13:58PM +0100, David Hildenbrand wrote:
> On 12.12.18 10:16, David Hildenbrand wrote:
> > We better stop right away. For now, errors would be partially ignored
> > (so the guest might get informed or the device might get unplugged),
> > although actual plug/unplug will be reported as failed to the user.
> > 
> > While at it, properly move the check to the pre_plug handler for the plug
> > case, as we can test the slot state before the device will be realized.
> > 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> @MST, looks like you missed this one.


Ouch I wonder what happened.
Thanks!

> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
