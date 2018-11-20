Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gP9G9-0003ZB-Mi
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gP9G5-0007eo-PC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:52:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gP9G5-0007SN-Iq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:52:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so3267314qkf.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 08:52:10 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120155500.GA29471@morn.lan>
	<03cf3bbc-d557-1c12-dd2b-6acf7934db3c@silicom-usa.com>
In-Reply-To: <03cf3bbc-d557-1c12-dd2b-6acf7934db3c@silicom-usa.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 20 Nov 2018 17:51:58 +0100
Message-ID: <CAGxU2F4FtdLb-aWCS_9E7kLGDdgR0-QT_KQpkNs6Zhucv6PF9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [SeaBIOS]  SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stephend@silicom-usa.com
Cc: kevin@koconnor.net, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com

On Tue, Nov 20, 2018 at 5:13 PM Steve Douthit <stephend@silicom-usa.com> wrote:
>
> On 11/20/18 10:55 AM, Kevin O'Connor wrote:
> > On Mon, Nov 19, 2018 at 07:38:39PM +0100, Stefano Garzarella wrote:
> >> just an update, I enabled the debug prints and I saw two timeouts fired
> >> with a lot
> >> of time lost (~780ms between "init timer" and "Scan for VGA ..."),
> >> putting other prints I discovered that a lot of time is spent in the
> >> tpm_setup(),
> >> during the probe of the 2 TPM devices:
> >>
> >> 00.548869 init timer
> >> 00.549677 ./src/post.c:157 platform_hardware_setup
> >> 00.550182 ./src/hw/tpm_drivers.c:579 tpmhw_probe
> >> 01.300833 WARNING - Timeout at wait_reg8:81!
> >> 01.301388 ./src/hw/tpm_drivers.c:579 tpmhw_probe
> >> 01.331843 WARNING - Timeout at wait_reg8:81!
> >> 01.332316 ./src/post.c:160 platform_hardware_setup
> >> 01.333358 Scan for VGA option rom
> >
> > FYI, this was raised a few months ago - see:
> >
> > https://mail.coreboot.org/pipermail/seabios/2018-March/012186.html
> >
> > IIRC, it should be possible to verify the TPM device is present before
> > trying to wait for it.
>
> We could skip probing entirely if there's no TCPA or TPM2 ACPI tables.
> There'd need to be some option to force probing in the case of
> missing/broken ACPI configurations.

I've just tried the
0001-tpm-Check-for-TPM-related-ACPI-tables-before-attempt.patch
(https://mail.coreboot.org/pipermail/seabios/2018-March/012188.html)
and it solves my issue with the TPM.

Thanks,
Stefano

>
> > -Kevin
> >
>


-- 
Stefano Garzarella
Red Hat
