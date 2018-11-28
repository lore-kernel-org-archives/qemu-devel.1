Received: from eggs.gnu.org ([2001:4830:134:3::10]:44415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1gRpGw-0001A7-C7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 21:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1gRpGt-0006T2-1k
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 21:08:14 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1gRpGs-0006Sr-OA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 21:08:10 -0500
Received: by mail-qt1-x843.google.com with SMTP id p17so24209194qtl.5
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 18:08:10 -0800 (PST)
Date: Tue, 27 Nov 2018 21:08:07 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20181128020807.GA27698@morn.lan>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120155500.GA29471@morn.lan>
	<03cf3bbc-d557-1c12-dd2b-6acf7934db3c@silicom-usa.com>
	<CAGxU2F4FtdLb-aWCS_9E7kLGDdgR0-QT_KQpkNs6Zhucv6PF9g@mail.gmail.com>
	<4c5a4f44-b707-e40a-a82b-81f59f83d59a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5a4f44-b707-e40a-a82b-81f59f83d59a@linux.ibm.com>
Subject: Re: [Qemu-devel] [SeaBIOS]  SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, stephend@silicom-usa.com, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com

On Wed, Nov 21, 2018 at 12:43:34AM -0500, Stefan Berger wrote:
> On 11/20/18 11:51 AM, Stefano Garzarella wrote:
> > On Tue, Nov 20, 2018 at 5:13 PM Steve Douthit <stephend@silicom-usa.com> wrote:
> > > On 11/20/18 10:55 AM, Kevin O'Connor wrote:
> > > > FYI, this was raised a few months ago - see:
> > > > 
> > > > https://mail.coreboot.org/pipermail/seabios/2018-March/012186.html
> > > > 
> > > > IIRC, it should be possible to verify the TPM device is present before
> > > > trying to wait for it.
> > > We could skip probing entirely if there's no TCPA or TPM2 ACPI tables.
> > > There'd need to be some option to force probing in the case of
> > > missing/broken ACPI configurations.
> > I've just tried the
> > 0001-tpm-Check-for-TPM-related-ACPI-tables-before-attempt.patch
> > (https://mail.coreboot.org/pipermail/seabios/2018-March/012188.html)
> > and it solves my issue with the TPM.
> 
> I have tried it with the attached patch of that mail. We have to apply it,
> also for QEMU. It is this patch here:

Okay, thanks.  I applied Steve's patch.

-Kevin
