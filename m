Received: from eggs.gnu.org ([2001:4830:134:3::10]:45468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dufH0-0007e0-C5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dufGz-0004r7-Dx
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:42:42 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:56070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dufGz-0004pd-87
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:42:41 -0400
Received: by mail-pf0-x229.google.com with SMTP id r71so1536275pfe.12
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
	<1503013010-11500-2-git-send-email-zuban32s@gmail.com>
	<20170919203449.GG21016@localhost.localdomain>
	<436365c9-43fc-95be-9bb2-7974f12e84df@redhat.com>
In-Reply-To: <436365c9-43fc-95be-9bb2-7974f12e84df@redhat.com>
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Wed, 20 Sep 2017 09:52:01 +0000
Message-ID: <CAKSfGUAS8EfYF179pjQ=svmAL2x-VR_iMTh=cZZjQmz77mO8fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/4] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: lersek@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, seabios@seabios.org

=D1=81=D1=80, 20 =D1=81=D0=B5=D0=BD=D1=82. 2017 =D0=B3. =D0=B2 10:13, Marce=
l Apfelbaum <marcel@redhat.com>:

> On 19/09/2017 23:34, Eduardo Habkost wrote:
> > On Fri, Aug 18, 2017 at 02:36:47AM +0300, Aleksandr Bezzubikov wrote:
> >> Introduce a new PCIExpress-to-PCI Bridge device,
> >> which is a hot-pluggable PCI Express device and
> >> supports devices hot-plug with SHPC.
> >>
> >> This device is intended to replace the DMI-to-PCI Bridge.
> >>
> >> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> >> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> >
> > It's possible to crash QEMU by instantiating this device, with;
> >
> >    $ qemu-system-ppc64 -machine prep -device pcie-pci-bridge
> >    qemu-system-ppc64: qemu/memory.c:1533: memory_region_finalize:
> Assertion `!mr->container' failed.
> >    Aborted
>
> Hi Edurado,
>
> >
> > I didn't investigate the root cause.
> >
>
> Thanks for reporting it!
> Aleksandr, can you have a look? Maybe we should not compile
> the device for ppc arch. (x86 and arm is enough)


I will see what can we do. Is x86 and arm really enough?


>
> Appreciated,
> Marcel
>
> --
Aleksandr Bezzubikov
