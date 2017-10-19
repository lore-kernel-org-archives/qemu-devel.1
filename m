Received: from eggs.gnu.org ([2001:4830:134:3::10]:39514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e5AyY-0005GG-Iy
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e5AyT-0000tu-IC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1e5AyT-0000ti-D0
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:35:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 724A4FED4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 13:35:00 +0000 (UTC)
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
	<1508418225.18146.1.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <d231ac0a-bb7d-78aa-ddb4-8048cc7bdfd8@redhat.com>
Date: Thu, 19 Oct 2017 16:34:46 +0300
MIME-Version: 1.0
In-Reply-To: <1508418225.18146.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 19/10/2017 16:03, Gerd Hoffmann wrote:
>    Hi,
>=20
>>  =C2=A0 - commit 39848901818 pc: limit 64 bit hole to 2G by default
>>  =C2=A0 shows us QEMU had the 64bit PCI hole, so it is a regression.
>=20
> commit message says:
>=20
> <quote>
>  =C2=A0=C2=A0=C2=A0=C2=A0It turns out that some 32 bit windows guests c=
rash
>  =C2=A0=C2=A0=C2=A0=C2=A0if 64 bit PCI hole size is >2G.
> </quote>
>=20
> Why this suddenly isn't a problem any more?
>=20

I suppose it is, so we need a way to turn it "off".

> Also: how about just using the existing pci_hole64_size property?
>=20

This is how I started, however Eduardo and (and maybe Michael ?)
where against letting the upper management software to deal with
such a low low level detail. They simply can't take such a decision.
This is why the property you mentioned is not ever linked
in code anywhere! It is simply not implemented and not used.

What about renaming the added compat property
from x-pci-hole64-fix to pci-hole64? Users using 32-bit Windows
guests having the mentioned issue guests will disable it.

Thanks,
Marcel

> cheers,
>    Gerd
>=20
