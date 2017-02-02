Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZFt2-0000Od-O4
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZFsx-0004I6-Uu
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:49:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZFsx-0004HX-Oe
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:49:07 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9D3CC05005F
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 11:49:07 +0000 (UTC)
Message-ID: <1486036144.20628.40.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Feb 2017 12:49:04 +0100
In-Reply-To: <1486031975.3484.17.camel@redhat.com>
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
	<1486021764.20628.29.camel@redhat.com>
	<1486031975.3484.17.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
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

  Hi,

> > If you add a video card manually (via -device or config file entry) qem=
u
> > will not add the default video card.
> >=20
> > Likewise, if you add a NIC manually, qemu will not add the default
> > ethernet device (and IIRC creating the default netdev will be skipped
> > too).
>=20
> This has the potential to give you some unexpected results

Indeed.

> but I'd say it's still entirely reasonable.

Well, makes it easy for users to get started, just "qemu -cdrom $live"
gives you a usable virtual machine without having to worry too much
about what devices you want plug in.

But that kind of magic -- while convenient at times -- can also easily
get into the way.  Guess why the -nodefaults switch exists ...

> So what do you think, should q35-emulated.cfg recommend the
> use of -nodefaults the same way q35-virtio-*.cfg do and add
> the video card (cirrus-vga?) and Ethernet adapter explicitly?

I think that would be good, for consistency across all q35*.cfg files.

But please don't use cirrus[1], it isn't the default any more for good
reasons.  I'd suggest to go with our new default, which is stdvga
(-device VGA), as we don't have intel graphics emulation.

> The advantage in doing so would be that we would provide
> maybe slightly more documentation, and we would be able to
> plug the Ethernet adapter at 19.0 instead of 02.0, which as
> I understand it matches real hardware better.

Yes.

cheers,
  Gerd

[1]
https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
