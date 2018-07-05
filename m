Received: from eggs.gnu.org ([2001:4830:134:3::10]:50213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb88r-000135-Ja
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb88o-00079O-FN
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:34:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fb88o-00078h-Aq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C6634021FC2
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 17:34:01 +0000 (UTC)
Date: Thu, 5 Jul 2018 20:34:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180705202215-mutt-send-email-mst@kernel.org>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
	<20180705164343.GE16293@redhat.com>
	<eba002c2-a50d-7252-65fa-104194e31fe8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba002c2-a50d-7252-65fa-104194e31fe8@redhat.com>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, jferlan@redhat.com

On Thu, Jul 05, 2018 at 07:15:34PM +0200, Laszlo Ersek wrote:
> > It has to be said that after reading the spec again [the MSFT spec,
> > not qemu's spec] and what other hypervisors are doing, I'm not sure
> > qemu is doing the right thing here.
> 
> That's the thing about specs -- interpretation. I've read the vmgenid
> spec several times as well, and I've always understood it as Microsoft
> meaning UUID / GUID as a primary representation for VMGENID. I may have
> been biased by UUID/GUID usage in UEFI.
> 
> When the feature was being developed for QEMU, we struggled with the
> interpretation of a good number of other bits as well; hence the
> "Requirements" section of QEMU's spec: "this is how we understood it".
> Without an open list to discuss things with Microsoft, sometimes we can
> only guess what is a "likely faithful" interpretation, and test it in
> practice.
> 
> I still believe QEMU's current interpretation is the right one; but I
> can't prove it.
> 
> Laszlo

Well it does seem that at least some guest code wants a counter
there. So if someone posts a patch adding a count property there
to be stored in LE format, plus a unit test - I'll merge it, even
though it does not look like libvirt wants that.

-- 
MST
