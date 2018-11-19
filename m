Received: from eggs.gnu.org ([2001:4830:134:3::10]:54991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gOh0w-0005xl-HD
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gOh0s-0008Ci-Ht
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:42:46 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:34955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gOh0q-0008B5-UN
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:42:41 -0500
Received: by mail-qk1-f180.google.com with SMTP id w204so47744819qka.2
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 02:42:40 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
In-Reply-To: <20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 19 Nov 2018 11:42:28 +0100
Message-ID: <CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: seabios@seabios.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Rob Bradford <robert.bradford@intel.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Nov 19, 2018 at 9:49 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > I'm investigating the SeaBIOS booting time, to understand if we can
> > reduce the boot time in some cases (e.g. legacy hardware is not
> > needed). I think this can be interesting also for NEMU developers.
>
> > The goal is to have only one image of SeaBIOS configurable at runtime
> > to reduce the boot time, avoiding unnecessary initialization.
>
> Why at runtime?  What is bad with two images?  With a runtime option
> you probably need some way to enable the "fastboot" hint for seabios,
> because some optimizations (like skipping ps/2 initialization) breaks
> functionality.  So it must be opt-in so you can enable it if you know
> your use case is fine with that.  But "qemu -boot fast=on" isn't much
> different from "qemu -bios seabios-fastboot.bin" after all ...
>

You are right, but maybe having a single image can be simpler to distribute,
and we can implement something (eg. using fw_cfg) to selectively enable
features needed.
Anyway, as the first step, I'll try to build a separate image of SeaBIOS.


> > Any pointers or suggestions would be helpful.
>
> seabios could try to skip initializing hardware without bootindex with
> "qemu -boot menu=off,strict=on".
>
> mmconfig support?  I think that would reduce the number of vmexits
> needed for pci initialization.
>

Thank you very much, I'll investigate that points.

Cheers,
Stefano


> cheers,
>   Gerd
>
>

-- 
Stefano Garzarella
Red Hat
