Received: from eggs.gnu.org ([2001:4830:134:3::10]:39537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1enoB1-0004jp-Md
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1enoAz-0003K0-Rg
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1enoAz-0003J2-E4
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9820B40FB647
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 16:20:24 +0000 (UTC)
Date: Mon, 19 Feb 2018 17:20:18 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180219162016.dcnfebkotjjy4ny6@eukaryote>
References: <20180219154333.20810-1-kchamart@redhat.com>
	<20180219154612.GX11516@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180219154612.GX11516@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: pcie: Spell out machine type needs
 for PCIe features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com

On Mon, Feb 19, 2018 at 03:46:12PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Feb 19, 2018 at 04:43:33PM +0100, Kashyap Chamarthy wrote:
> > PCIe features are available only via the Q35 machine for x86, or the

[...]

> >  1. Introduction
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -The doc proposes best practices on how to use PCI Express/PCI device
> > -in PCI Express based machines and explains the reasoning behind them=
.
> > +The doc proposes best practices on how to use PCI Express (PCIe) / P=
CI
> > +device in PCI Express based machines and explains the reasoning behi=
nd
> > +them.
>=20
> Pre-existing bug  s/device/devices/

Fixed in v2.

> > +This applies to the Q35 machine type on x86 and the 'virt' machine t=
ype
>=20
> For consistency I'd suggest  'q35' rather than Q35.

Yep, fixed in v2.

(I actually did that first in v1 and removed it =E2=80=94 as I saw the
captialized variant used througout the doc.  But I see you're asking to
be consistent in the sentence.)

> > +on AArch64 (in other words, PCIe features are available only when us=
ing
> > +the Q35 and 'virt' machine types for the said architectures). Other
>=20
> And again, though I feel the stuff in (...) is just repeating what's
> said in the stuff either side of the brackets.

I was also hesitant on the repetition.  But I wanted to put some wording
that is unambiguous about the mandatory requirements.  How about this,
that I currently have in my v2 draft:

    "Note that the PCIe features are available only when using the 'q35'
    machine type on x86 architecture and the 'virt' machine type on
    AArch64. Other machine types do not use PCIe at this time."


Thanks for the quick review!

--=20
/kashyap
