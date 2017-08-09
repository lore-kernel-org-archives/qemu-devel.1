Received: from eggs.gnu.org ([2001:4830:134:3::10]:58371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dfOcI-0003kY-M5
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dfOcF-0007BB-AM
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dfOcF-00078b-4H
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:53:31 -0400
References: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
	<3319b641-b7f3-0ee8-e5ed-9c378e723eb4@redhat.com>
	<bc619876-bca3-15c8-0ef0-0fc5f833bab3@intel.com>
	<14b1b111-d2d6-6954-2d12-8e0ac791ae44@redhat.com>
	<d06866b6-e089-0427-2d57-40c4648734da@intel.com>
	<97068eca-2788-8396-0f8d-1990c651bdfc@redhat.com>
	<20170723200440.GA3718@morn.lan>
	<767EFADFF809234DB6CAABD6D2F93847C5D3A5BC@IRSMSX107.ger.corp.intel.com>
	<8377f92c-9b65-0da4-2a5c-86c1e5d49448@redhat.com>
	<c07a1cec-fcb4-ccc8-9fdf-07ffb017ef3a@intel.com>
	<bf17dcaf-4252-59f9-6152-75d99ffeccbf@redhat.com>
	<767EFADFF809234DB6CAABD6D2F93847C5D4D52D@IRSMSX107.ger.corp.intel.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <28b850bd-1bac-efc9-3afd-2bf8b80be34c@redhat.com>
Date: Wed, 9 Aug 2017 13:53:16 +0300
MIME-Version: 1.0
In-Reply-To: <767EFADFF809234DB6CAABD6D2F93847C5D4D52D@IRSMSX107.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] >256 Virtio-net-pci hotplug Devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kinsella, Ray" <ray.kinsella@intel.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: "Tan, Jianfeng" <jianfeng.tan@intel.com>, "seabios@seabios.org" <seabios@seabios.org>, Michael Tsirkin <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 07/08/2017 22:00, Kinsella, Ray wrote:
> Hi Marcel,
> 

Hi Ray,

Please have a look on this thread, I think Laszlo and Paolo
found the root cause.
     https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01368.html
It seems hot-plugging the devices would not help.

Thanks,
MArcel

> Yup - I am using Seabios by default.
> I took all the measures from the Kernel time reported in syslog.
> As Seabios wasn't exhibiting any obvious scaling problem.
> 
> Ray K
> 
> -----Original Message-----
> From: Marcel Apfelbaum [mailto:marcel@redhat.com]
> Sent: Wednesday, August 2, 2017 5:43 AM
> To: Kinsella, Ray <ray.kinsella@intel.com>; Kevin O'Connor <kevin@koconnor.net>
> Cc: Tan, Jianfeng <jianfeng.tan@intel.com>; seabios@seabios.org; Michael Tsirkin <mst@redhat.com>; qemu-devel@nongnu.org; Gerd Hoffmann <kraxel@redhat.com>
> Subject: Re: [Qemu-devel] >256 Virtio-net-pci hotplug Devices
> 
> It is an issue worth looking into it, one more question, all the measurements are from OS boot? Do you use SeaBIOS?
> No problems with the firmware?
> 
> Thanks,
> Marcel
> 
> 
