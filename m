Received: from eggs.gnu.org ([209.51.188.92]:60055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hBl5R-0003st-Sy
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hBky0-00083w-EW
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:50:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hBky0-00080z-83
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:50:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id z76so26527qkb.12
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 11:50:31 -0700 (PDT)
Date: Wed, 3 Apr 2019 14:50:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190403144550-mutt-send-email-mst@kernel.org>
References: <f3a469aa-4a18-a8be-3a37-8989401e2db7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a469aa-4a18-a8be-3a37-8989401e2db7@huawei.com>
Subject: Re: [Qemu-devel] Question: can we hot plug a PCIe switch on machine
 "virt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, wanghaibin 00208455 <wanghaibin.wang@huawei.com>

On Wed, Apr 03, 2019 at 03:32:09PM +0800, Heyi Guo wrote:
> Hi folks,
> 
> In physical world, a PCIe switch including one upstream port and several downstream ports is a single physical device, however we treat each port as a device in qemu world. In qemu docs/pcie.txt, we have below statements:
> 
> Line 230: Be aware that PCI Express Downstream Ports can't be hot-plugged into
> Line 231: an existing PCI Express Upstream Port.
> 
> To my understanding, it implies PCIe downstream ports *can* be hot-plugged into something which is not an existing upstream port. If it is true, how can we do that? AFAIK monitor command device_add can only add one device at a time.
> 
> Please help to show the truth.
> 
> Thanks,
> 
> Heyi
> 

afaik they can only be plugged into upstearm ports with or without hotplug.

-- 
mst
