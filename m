Received: from eggs.gnu.org ([2001:4830:134:3::10]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXsYn-0007Mp-TY
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXsYm-0007e5-LT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:14:53 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dXsYm-0007dP-Fe
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:14:52 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so462938pfh.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 10:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<20170719135726.GG5722@char.us.oracle.com>
In-Reply-To: <20170719135726.GG5722@char.us.oracle.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Wed, 19 Jul 2017 17:14:41 +0000
Message-ID: <CAKSfGUDgtN+S=u_4S7-s1wUxt6fZtibLG+ZSX+qZ0d+9marXQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Allow RedHat PCI bridges reserve
 more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: marcel@redhat.com, qemu-devel@nongnu.org, seabios@seabios.org

=D1=81=D1=80, 19 =D0=B8=D1=8E=D0=BB=D1=8F 2017 =D0=B3. =D0=B2 16:57, Konrad=
 Rzeszutek Wilk <konrad.wilk@oracle.com>:

> On Wed, Jul 19, 2017 at 04:20:12PM +0300, Aleksandr Bezzubikov wrote:
> > Now PCI bridges (and PCIE root port too) get a bus range number in
> system init,
> > basing on currently plugged devices. That's why when one wants to
> hotplug another bridge,
> > it needs his child bus, which the parent is unable to provide.
>
> Could you explain how you trigger this?


I'm trying to hot plug pcie-pci bridge into pcie root port, and Linux says
'cannot allocate bus number for device bla-bla'. This obviously does not
allow me to use the bridge at all.

>
>
> > The suggested workaround is to have vendor-specific capability in RedHa=
t
> generic pcie-root-port
> > that contains number of additional bus to reserve on BIOS PCI init.
>
> But wouldn't the proper fix be for the PCI bridge to have the subordinate
> value be extended to fit more bus ranges?


What do you mean? This is what I'm trying to do. Do you suppose to get rid
of vendor-specific cap and use original register value instead of it?

>
> >
> > Aleksandr Bezzubikov (2):
> >   pci: add support for direct usage of bdf for capability lookup
> >   pci: enable RedHat pci bridges to reserve more buses
> >
> >  src/fw/pciinit.c   | 12 ++++++++++--
> >  src/hw/pcidevice.c | 24 ++++++++++++++++++++++++
> >  src/hw/pcidevice.h |  1 +
> >  3 files changed, 35 insertions(+), 2 deletions(-)
> >
> > --
> > 2.7.4
> >
> >
>
--=20
Alexander Bezzubikov
