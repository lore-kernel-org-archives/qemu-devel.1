Received: from eggs.gnu.org ([2001:4830:134:3::10]:52154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1gP8Mr-0007dl-Ru
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1gP8Mm-0008Ha-TB
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:55:13 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1gP8Mm-0007yp-89
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:55:08 -0500
Received: by mail-qt1-x842.google.com with SMTP id v11so495861qtc.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:55:02 -0800 (PST)
Date: Tue, 20 Nov 2018 10:55:00 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20181120155500.GA29471@morn.lan>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
Subject: Re: [Qemu-devel] [SeaBIOS]  SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kraxel@redhat.com, stefanha@gmail.com, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stephen Douthit <stephend@silicom-usa.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Mon, Nov 19, 2018 at 07:38:39PM +0100, Stefano Garzarella wrote:
> just an update, I enabled the debug prints and I saw two timeouts fired
> with a lot
> of time lost (~780ms between "init timer" and "Scan for VGA ..."),
> putting other prints I discovered that a lot of time is spent in the
> tpm_setup(),
> during the probe of the 2 TPM devices:
> 
> 00.548869 init timer
> 00.549677 ./src/post.c:157 platform_hardware_setup
> 00.550182 ./src/hw/tpm_drivers.c:579 tpmhw_probe
> 01.300833 WARNING - Timeout at wait_reg8:81!
> 01.301388 ./src/hw/tpm_drivers.c:579 tpmhw_probe
> 01.331843 WARNING - Timeout at wait_reg8:81!
> 01.332316 ./src/post.c:160 platform_hardware_setup
> 01.333358 Scan for VGA option rom

FYI, this was raised a few months ago - see:

https://mail.coreboot.org/pipermail/seabios/2018-March/012186.html

IIRC, it should be possible to verify the TPM device is present before
trying to wait for it.

-Kevin
