Received: from eggs.gnu.org ([2001:4830:134:3::10]:57040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fE8XW-0003Sv-T3
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fE8XS-0005yo-GX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:20:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fE8XS-0005yD-C4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:20:26 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-9-peterx@redhat.com>
	<2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B5D2@SHSMSX101.ccr.corp.intel.com>
	<20180427072810.GB13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
	<20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
	<20180503060442.GB2378@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <547a97a1-0ac0-21b2-af00-036b795b06cc@redhat.com>
Date: Thu, 3 May 2018 15:20:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180503060442.GB2378@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>



On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 14:04, Peter Xu wrote:
> IMHO the guest can't really detect this, but it'll found that the
> device is not working functionally if it's doing something like what
> Jason has mentioned.
>
> Actually now I have had an idea if we really want to live well even
> with Jason's example: maybe we'll need to identify PSI/DSI.  For DSI,
> we don't remap for mapped pages; for PSI, we unmap and remap the
> mapped pages.  That'll complicate the stuff a bit, but it should
> satisfy all the people.
>
> Thanks,

So it looks like there will be still unnecessary unamps. How about=20
record the mappings in the tree too?

Thanks
