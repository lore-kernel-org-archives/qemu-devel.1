Received: from eggs.gnu.org ([2001:4830:134:3::10]:42135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eFH5n-0007OT-0E
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eFH5m-0003dE-19
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:08:18 -0500
MIME-Version: 1.0
In-Reply-To: <04518567-9905-c22c-78f8-ea9dcde7e7ac@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
	<5b6f8758-5e3e-e759-1592-2768eb85b322@redhat.com>
	<CAJH6TXgrOWxP7jFg98_jv-R1nrFKOXBQA6pPxbkzGWTVW=EReA@mail.gmail.com>
	<CAJH6TXg7eCiqH+3Wq=-QEH3xFhJJekTXm+c1F5w7BebiQGni8A@mail.gmail.com>
	<d8b9ba38-f39a-9b79-ac89-64e9ab3e6a33@redhat.com>
	<04518567-9905-c22c-78f8-ea9dcde7e7ac@redhat.com>
From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date: Thu, 16 Nov 2017 11:08:09 +0100
Message-ID: <CAJH6TXjZMN9msT5sTHLcgFtfgR2bxPVCr2C7ndpnzWdHG0CfqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

2017-11-15 23:55 GMT+01:00 Max Reitz <mreitz@redhat.com>:
> https://xanclic.moe/convert-xva.rb -- does this work?
> (It seems to works on the two example images I found...)
>
> An example is in the code, you use it like this:
>
> $ ./convert-xva.rb ~/Downloads/stats-appliance-2.36.020502.xva Ref:73


It doesn't work on huge images:

# time convert-xva.rb 20171115_193814_efff_.xva Ref:10 -O qcow2 disk1.qcow2
/usr/bin/convert-xva.rb:119:in `exec': Argument list too long -
qemu-img (Errno::E2BIG)
from /usr/bin/convert-xva.rb:119:in `<main>'

real 9m41.414s
user 0m19.280s
sys 0m3.260s
