Received: from eggs.gnu.org ([2001:4830:134:3::10]:35880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3Wf-0004js-I1
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3Wc-0007MR-E4
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:55:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dJ3Wc-0007MH-7e
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:55:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB79730AF7A
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 19:55:20 +0000 (UTC)
Date: Thu, 8 Jun 2017 22:55:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170608224942-mutt-send-email-mst@kernel.org>
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
	<1496951333.29761.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1496951333.29761.5.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jun 08, 2017 at 09:48:53PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > I really dislike negotiation being re-invented for each device.=A0=A0=
Do
> > we
> > need these tricks?=A0=A0Can we just do fw cfg with standard discovery=
?
> > This ties in with my proposal to generalize smi features to
> > generic ones.
>=20
> Device properties should be part of the device.
> We should have done this with the smi too.

What is part of the device and what isn't? It's all part
of QEMU in the end.  Adding probing for multiple devices
will just add to number of exits and slow down guest boot.

We do want to stick to emulating real devices if we can, no argument
here - but this stuff is PV anyway - what do we gain by spreading it
out?

> A more standard way to handle this would be to add a vendor-specific
> pci capability and place the register there.  Not sure we have room for
> that in the pci config space though.
>=20
> cheers,
>   Gerd

We don't have room anywhere in PCI config space. Laszlo makes argument
why it's safe for this device based on spec but it's anyone's guess
whether current and future software will follow spec.  In short, going
anywhere near the emulated device has a potential to break some drivers.

--=20
MST
