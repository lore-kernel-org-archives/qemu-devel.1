Received: from eggs.gnu.org ([2001:4830:134:3::10]:41439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e47FX-000407-Io
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e47FW-0000ug-9u
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:24:15 -0400
Date: Mon, 16 Oct 2017 17:24:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171016152404.GD5145@localhost.localdomain>
References: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
	<20171013113708.2dd02a17.cohuck@redhat.com>
	<20171013094400.GD20515@redhat.com>
	<20171016132246.GC5145@localhost.localdomain>
	<20171016133812.GB11975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016133812.GB11975@redhat.com>
Subject: Re: [Qemu-devel] German BSI analysed security of KVM / QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Cornelia Huck <cohuck@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, qemu-block@nongnu.org

Am 16.10.2017 um 15:38 hat Daniel P. Berrange geschrieben:
> > Another thing that made me a bit sad is that they mention qed as a
> > better performing alternative for qcow2. Even in 2017, people keep
> > spreading this nonsense. :-(
> 
> Probably because when you google for QED you inevitably hit this article
> near the top:
> 
>   https://www.phoronix.com/scan.php?page=news_item&px=OTY0MQ
> 
> And there's little clear information on QEMU website to show that QED
> is essentially an obsolete experiment.
> 
> Perhaps some clear update to this page would help, and also in the
> qemu docs
> 
>   https://wiki.qemu.org/Features/QED

I updated the wiki page, maybe this will help a bit.

We could also consider printing a warning when you create a new image in
an obsolete native qemu format (i.e. qcow1 and qed).

Kevin
