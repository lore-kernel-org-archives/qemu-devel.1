Received: from eggs.gnu.org ([2001:4830:134:3::10]:59653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRWY3-0003Xi-SO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRWY3-0007YO-AU
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:08:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRWY3-0007YI-5X
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:08:39 -0500
Date: Tue, 27 Nov 2018 07:08:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181127060836.hfvzjga4rdnpb4ws@sirius.home.kraxel.org>
References: <D9DE8DBB19F2A24080482022C1DE758302D358E6@DGGEMM529-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302D358E6@DGGEMM529-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [BUG] qemu stuck when detach host-usb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, libusb-devel@lists.sourceforge.net

On Tue, Nov 27, 2018 at 01:26:24AM +0000, linzhecheng wrote:
> Description of problem:
> The guest has a host-usb device(Kingston Technology DataTraveler 100 G3/G4/SE9 G2), which is attached
> to xhci controller(on host). Qemu will stuck if I detach it from guest.
> 
> How reproducible:
> 100%
> 
> Steps to Reproduce:
> 1.            Use usb stick to copy files in guest , make it busy working.
> 2.            virsh detach-device vm_name usb.xml
> 
> Then qemu will stuck for 20s, I found this is because libusb_release_interface block for 20s.
> Dmesg prints:
> 
> [35442.034861] usb 4-2.1: Disable of device-initiated U1 failed.
> [35447.034993] usb 4-2.1: Disable of device-initiated U2 failed.
> [35452.035131] usb 4-2.1: Set SEL for device-initiated U1 failed.
> [35457.035259] usb 4-2.1: Set SEL for device-initiated U2 failed.
> 
> Is this a hardware error or software's bug?

I'd guess software error, could be is libusb or (host) linux kernel.
Cc'ing libusb-devel.

cheers,
  Gerd
