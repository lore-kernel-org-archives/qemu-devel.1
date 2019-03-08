Received: from eggs.gnu.org ([209.51.188.92]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2CWb-0007yz-6G
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2CWa-0008U8-GT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:14:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2CWa-0008Td-6C
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:14:44 -0500
References: <CAEt6vxELvT1gadPihazzmKDsGgFDa1whxnKAVMEwsf_e7ycGdg@mail.gmail.com>
	<d856dc98-018b-3eec-fe05-26035a64e9bb@redhat.com>
	<5109bd99-ab78-ef32-b900-15896dc00d1f@redhat.com>
	<20190308091917.kmjlvvkl5oxcetcu@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d59fa93f-4ecc-fa7b-9bf9-bb144c02d614@redhat.com>
Date: Fri, 8 Mar 2019 11:14:36 +0100
MIME-Version: 1.0
In-Reply-To: <20190308091917.kmjlvvkl5oxcetcu@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu bluetooth support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Daryl Oliver <gen.dr.aireagoirdragesteam@gmail.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 08/03/19 10:19, Gerd Hoffmann wrote:
>   Hi,
> 
>> For Windows, we could also pass it through as an HID device, using
>> something like virtio-input-host-pci but for USB.  It wouldn't be hard
>> to implement, but you'd have to write a converter from Linux evdev
>> descriptors to USB HID descriptors.
> 
> I think we actually have virtio-input windows drivers, didn't Ladi work
> on that?

Ah indeed.  So virtio-input-host-pci might work even for Windows.

Paolo

> Another possible option would be to usb pass through a bluetooth dongle.
> 
> cheers,
>   Gerd
> 
