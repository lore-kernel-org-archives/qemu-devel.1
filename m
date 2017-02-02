Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZPXG-0006nD-Ji
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZPXC-0007J6-KN
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:07:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZPXC-0007In-Dw
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:07:18 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B32580F99
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 22:07:18 +0000 (UTC)
Message-ID: <1486073234.20628.51.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Feb 2017 23:07:14 +0100
In-Reply-To: <1486049722.3484.25.camel@redhat.com>
References: <1486046738-26059-1-git-send-email-abologna@redhat.com>
	<1486047322.20628.42.camel@redhat.com>
	<1486049722.3484.25.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, drjones@redhat.com

On Do, 2017-02-02 at 16:35 +0100, Andrea Bolognani wrote:
> On Thu, 2017-02-02 at 15:55 +0100, Gerd Hoffmann wrote:
> > > +++ b/docs/q35-emulated.cfg
> > >=20
> > > +#   00:01.0 VGA compatible controller
> > >=20
> > > +[device "video"]
> > > +  driver =3D "VGA"
> > > +  bus =3D "pcie.0"
> > > +  addr =3D "02.0"
> >=20
> > Here is a address mismatch ;)
>=20
> Oh, wait, I realize where the mismatch comes from now:
> on real hardware (my laptop) the video card is plugged
> into 00:02.0, but the default one you get when you don't
> pass -nodefault to QEMU is plugged into 00:01.0!

And that depends on the chipset.  On q35 it is 01.0, whereas on pc it is
02.0 because 01.0 is occupied by the piix southbridge.

> I think we should use 00:02.0, do you agree? I would
> also use the same slot in q35-virtio-graphical.cfg.

Matter of taste really.  I have some guests where the vga is at 04.0,
works fine too.  But being consistent across all configurations makes
sense.

cheers,
  Gerd
