Received: from eggs.gnu.org ([2001:4830:134:3::10]:48268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOfEw-0002pB-6O
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 03:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOfEt-0005DM-2h
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 03:49:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gOfEs-0005C3-Sk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 03:49:03 -0500
Date: Mon, 19 Nov 2018 09:48:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: seabios@seabios.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Rob Bradford <robert.bradford@intel.com>, Samuel Ortiz <sameo@linux.intel.com>

  Hi,

> I'm investigating the SeaBIOS booting time, to understand if we can
> reduce the boot time in some cases (e.g. legacy hardware is not
> needed). I think this can be interesting also for NEMU developers.

> The goal is to have only one image of SeaBIOS configurable at runtime
> to reduce the boot time, avoiding unnecessary initialization.

Why at runtime?  What is bad with two images?  With a runtime option
you probably need some way to enable the "fastboot" hint for seabios,
because some optimizations (like skipping ps/2 initialization) breaks
functionality.  So it must be opt-in so you can enable it if you know
your use case is fine with that.  But "qemu -boot fast=on" isn't much
different from "qemu -bios seabios-fastboot.bin" after all ...

> Any pointers or suggestions would be helpful.

seabios could try to skip initializing hardware without bootindex with
"qemu -boot menu=off,strict=on".

mmconfig support?  I think that would reduce the number of vmexits
needed for pci initialization.

cheers,
  Gerd
