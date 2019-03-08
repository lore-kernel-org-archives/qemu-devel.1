Received: from eggs.gnu.org ([209.51.188.92]:36946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2Bey-0005iN-MH
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2Bey-0000Fe-3P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h2Bex-0000EY-T5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:20 -0500
Date: Fri, 8 Mar 2019 10:19:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190308091917.kmjlvvkl5oxcetcu@sirius.home.kraxel.org>
References: <CAEt6vxELvT1gadPihazzmKDsGgFDa1whxnKAVMEwsf_e7ycGdg@mail.gmail.com>
	<d856dc98-018b-3eec-fe05-26035a64e9bb@redhat.com>
	<5109bd99-ab78-ef32-b900-15896dc00d1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5109bd99-ab78-ef32-b900-15896dc00d1f@redhat.com>
Subject: Re: [Qemu-devel] qemu bluetooth support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Daryl Oliver <gen.dr.aireagoirdragesteam@gmail.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>

  Hi,

> For Windows, we could also pass it through as an HID device, using
> something like virtio-input-host-pci but for USB.  It wouldn't be hard
> to implement, but you'd have to write a converter from Linux evdev
> descriptors to USB HID descriptors.

I think we actually have virtio-input windows drivers, didn't Ladi work
on that?

Another possible option would be to usb pass through a bluetooth dongle.

cheers,
  Gerd
