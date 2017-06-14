Received: from eggs.gnu.org ([2001:4830:134:3::10]:35199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLCyf-0005a6-Og
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLCyc-0007cO-FM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLCyc-0007al-8j
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:25:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32DAC4E4C6
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 18:25:08 +0000 (UTC)
Date: Wed, 14 Jun 2017 21:25:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170614211927-mutt-send-email-mst@kernel.org>
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
	<1496951333.29761.5.camel@redhat.com>
	<20170608224942-mutt-send-email-mst@kernel.org>
	<7a7647cd-3d7a-0b6f-0691-d656c9026f44@redhat.com>
	<1497038478.10080.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1497038478.10080.1.camel@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

On Fri, Jun 09, 2017 at 10:01:18PM +0200, Gerd Hoffmann wrote:
> On Fri, 2017-06-09 at 13:40 +0200, Paolo Bonzini wrote:
> >=20
> > On 08/06/2017 21:55, Michael S. Tsirkin wrote:
> > > We don't have room anywhere in PCI config space. Laszlo makes
> > > argument
> > > why it's safe for this device based on spec but it's anyone's guess
> > > whether current and future software will follow spec.=A0=A0In short=
,
> > > going
> > > anywhere near the emulated device has a potential to break some
> > > drivers.
> >=20
> > There are no such drivers.=A0=A0The MCH and PCH are only touched by t=
he
> > firmware, not by the OS.
>=20
> Yea.  That is *exactly* the reason why I think simply using the 0x50
> offset probably works fine in practice even though I suspect on
> physical hardware it might be some undocumented register.  Much of the
> stuff in the host bridge pci config space is firmware territory, and we
> run qemu specific firmware *anyway*.
>=20
> cheers,
>   Gerd

To be specific, what I meant is a bit that tells guest that a
config space register is available, and lets host find out
that guest is going to use it.

This to ensure full forward and backward compatibility.

I agree a fw cfg file for a single bit seems like an overkill, that's
why I thought sharing feature files with SMI would be a good idea.

Do you see an issue with that?

--=20
MST
