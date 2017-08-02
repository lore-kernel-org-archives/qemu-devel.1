Received: from eggs.gnu.org ([2001:4830:134:3::10]:53669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dct03-000440-1T
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcszy-0005U6-2i
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dcszx-0005TY-S7
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:43:37 -0400
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
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <bf17dcaf-4252-59f9-6152-75d99ffeccbf@redhat.com>
Date: Wed, 2 Aug 2017 15:43:25 +0300
MIME-Version: 1.0
In-Reply-To: <c07a1cec-fcb4-ccc8-9fdf-07ffb017ef3a@intel.com>
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

On 25/07/2017 21:00, Kinsella, Ray wrote:
> 
> Hi Marcel,
>

Hi Ray,

> On 24/07/2017 00:14, Marcel Apfelbaum wrote:
>> On 24/07/2017 7:53, Kinsella, Ray wrote:
>>
>> Even if I am not aware of how much time would take to init a bare-metal
>> PCIe Root Port, it seems too much.
>>
> 
> So I repeated the testing for 64, 128, 256 and 512 ports. I ensured the 
> configuration was sane, that 128 was twice the number of root ports and 
> virtio-pci-net devices as 64.
> 
> I got the following results - shown in seconds, as you can see it is non 
> linear but not exponential, there is something that is not scaling well.
> 
>          64    128    256    512
> PCIe Root Ports    14    72    430    2672
> ACPI        4    35    342    3863
> Loading Drivers    1    1    31    621
> Total Boot    34    137    890    7516
> 
> ( I did try to test 1024 devices, but it just dies silently )
> 
> Ray K
> 

It is an issue worth looking into it, one more question,
all the measurements are from OS boot? Do you use SeaBIOS?
No problems with the firmware?

Thanks,
Marcel
