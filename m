Received: from eggs.gnu.org ([2001:4830:134:3::10]:56818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5RDX-0001CQ-KD
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5RDT-0002Oo-O3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e5RDT-0002Oa-HM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:55:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61A498047E
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 06:55:34 +0000 (UTC)
Message-ID: <1508482525.18146.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 20 Oct 2017 08:55:25 +0200
In-Reply-To: <d231ac0a-bb7d-78aa-ddb4-8048cc7bdfd8@redhat.com>
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
	<1508418225.18146.1.camel@redhat.com>
	<d231ac0a-bb7d-78aa-ddb4-8048cc7bdfd8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

  Hi,

> > commit message says:
> >=20
> > <quote>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0It turns out that some 32 bit windows g=
uests crash
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if 64 bit PCI hole size is >2G.
> > </quote>
> >=20
> > Why this suddenly isn't a problem any more?
> >=20
>=20
> I suppose it is, so we need a way to turn it "off".

Or have machine types behave differently, i.e. give q35 a large 64bit
hole and leave pc as-is.

Devices with that large bars are most likely pci express anyway ...

> This is how I started, however Eduardo and (and maybe Michael ?)
> where against letting the upper management software to deal with
> such a low low level detail. They simply can't take such a decision.
> This is why the property you mentioned is not ever linked
> in code anywhere! It is simply not implemented and not used.

Makes sense.

BTW:  Is it safe to just assume 40 bits physical is going to work?  My
workstation:

model name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: Intel(R) Core(TM) i7-7700=
K CPU @ 4.20GHz
address sizes=C2=A0=C2=A0=C2=A0: 39 bits physical, 48 bits virtual

Does this imply ept is limited 39 bits physical too?

cheers,
  Gerd
