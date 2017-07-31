Received: from eggs.gnu.org ([2001:4830:134:3::10]:57166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcBL1-0007n7-Bs
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcBL0-0005KD-DV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:06:27 -0400
Date: Mon, 31 Jul 2017 17:06:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170731170217-mutt-send-email-mst@kernel.org>
References: <1495537965-4187-1-git-send-email-diana.craciun@nxp.com>
	<20170525011034-mutt-send-email-mst@kernel.org>
	<AM3PR04MB061619F6FDC53F7FD4C1DAE4FFF10@AM3PR04MB0616.eurprd04.prod.outlook.com>
	<20170706023845-mutt-send-email-mst@kernel.org>
	<AM3PR04MB0616507B6F0989360D582F37FFB20@AM3PR04MB0616.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB0616507B6F0989360D582F37FFB20@AM3PR04MB0616.eurprd04.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add global device ID in virt machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Diana Madalina Craciun <diana.craciun@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "marcel@redhat.com" <marcel@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Mike Caraman <mike.caraman@nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>

On Mon, Jul 31, 2017 at 01:22:45PM +0000, Diana Madalina Craciun wrote:
> >> If we are to use a value of 0 for the constant in case of PCI devices,
> >> what happens if we have multiple PCI controllers?
> > I guess we'd use the PCI Segment number for that?
> >
> >
> 
> Yes, we can use the PCI segment for this scenario. But this would mean
> different solutions for the same problem. The main problem is that we
> can have multiple entities in the system that are using MSIs (for now
> PCI and NXP non-PCI bus infrastructure
> (https://lwn.net/Articles/635905/). I guess that we may have other
> platform devices that are using MSIs in the future.
> 
> Thanks,
> Diana
> 
> 

Don't have the time to explore NXP in depth, sorry - there's
a lot of complexity there.
Could you maybe stick some bits to specify bus type in there?
It just looks very wrong to push low level things like this
that users have no interest in up the stack.

-- 
MST
