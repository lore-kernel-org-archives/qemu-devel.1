Received: from eggs.gnu.org ([2001:4830:134:3::10]:39516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dknty-0001aJ-VL
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dkntx-0004ap-75
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:54:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1dkntx-0004aI-0X
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:54:09 -0400
Message-ID: <1503564841.3438.23.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 24 Aug 2017 10:54:01 +0200
In-Reply-To: <ddb6f49e-6617-a659-08bf-cf093f658a8c@redhat.com>
References: <1503506783.3438.19.camel@redhat.com>
	<ddb6f49e-6617-a659-08bf-cf093f658a8c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Number of usable slots in PCIe Root Port / PCIe
 Switch Downstream Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <mapfelba@redhat.com>, laine@laine.org, Lukas Doktor <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 2017-08-23 at 23:16 +0300, Marcel Apfelbaum wrote:
> > Is such a configuration considered valid?
>=20
> Definitely no.
>=20
> > Or should
> > libvirt and the guest OS / firmware start allowing it?
>=20
> I thought libvirt does not allow it anyway and yes, is a bug,
> but considered low priority.

That's correct, libvirt knows those controllers only have
a single slot and will prevent you from adding more than
one device to them. So no change needed there.

IIUC Luk=C3=A1=C5=A1 is using QEMU directly in (some parts of)
Avocado, so I imagine emitting an error rather than
silently accepting an invalid configuration would save
him some debugging time :) But he knows not to do that
now, so I guess low priority sounds about right.

Thanks for clarifying!

--=20
Andrea Bolognani / Red Hat / Virtualization
