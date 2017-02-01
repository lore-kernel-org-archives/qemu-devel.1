Received: from eggs.gnu.org ([2001:4830:134:3::10]:58522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYwAo-00067R-Lq
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYwAk-0002W8-8v
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:46:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYwAk-0002Vp-3a
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:46:10 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38DABC05681B
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 14:46:10 +0000 (UTC)
Message-ID: <1485960366.1076.63.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Feb 2017 15:46:06 +0100
In-Reply-To: <1485958183.3484.13.camel@redhat.com>
References: <1485788877-3823-1-git-send-email-abologna@redhat.com>
	<1485894840.1076.45.camel@redhat.com>
	<1485958183.3484.13.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] q35: Provide improved sample configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com

  Hi,

>   q35-emulated.cfg          # emulated guest
>   q35-virtio-common.cfg     # shared by all VirtIO guests
>   q35-virtio-graphical.cfg  # VirtIO guest, graphical console
>   q35-virtio-serial.cfg     # VirtIO guest, serial console

Looks good to me.

> > > +[device "tablet"]
> > > +  driver =3D "usb-tablet"
> > > +  bus =3D "usb.0"
> > > +  port =3D "2"
> >=20
> > There is also virtio-tablet, but for a generic config usb is probably
> > the better choice as virtio-tablet is supported by modern linux only (o=
n
> > x86, on arm we have only modern linux anyway so picking virtio-tablet
> > should be fine).
>=20
> Okay, I will keep this in mind when working on the
> aarch64/virt sample configuration. We can probably use
> virtio-keyboard-pci and virtio-tablet-pci there, avoiding
> the need to have a USB controller at all.

Not sure whenever we have firmware support for virtio-keyboard (which of
course only matters with virtio-gpu being supported, otherwise we have
to use the serial line anyway to operate the grub boot menu).

cheers,
  Gerd
