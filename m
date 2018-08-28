Received: from eggs.gnu.org ([2001:4830:134:3::10]:45078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuXC4-0000xL-G9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 02:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuXAR-0004cb-Ju
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 02:07:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuXAR-0004cK-ER
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 02:07:55 -0400
Date: Tue, 28 Aug 2018 08:07:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180828060752.mmsd7x7uobqm2gsr@sirius.home.kraxel.org>
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
	<CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
	<5f5dc082-7053-d6b9-b01f-fffba1847ba5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5f5dc082-7053-d6b9-b01f-fffba1847ba5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC v2 0/3] Support multiple pci
 domains in pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, seabios@seabios.org

  Hi,

> Since we will not use all 256 buses of an extra PCI domain,
> I think this space will allow us to support more PCI domains.

Depends on the use case I guess.  If you just need many pcie devices
this probably doesn't help.  If you want them for numa support then yes,
more domains with less devices each can be useful then.

> How will the flow look like ?
>=20
> 1. QEMU passes to SeaBIOS information of how many extra
> =A0=A0 PCI domains needs, and how many buses per domain.
> =A0=A0 How it will pass this info? A vendor specific capability,
> =A0=A0 some PCI registers or modifying extra-pci-roots fw_cfg file?

Where is the pxb-pcie device?  0000:$somewhere?  Or $domain:00:00.0?

> 2. SeaBIOS assigns the address for each PCI Domain and
> =A0=A0=A0 returns the information to QEMU.
> =A0 =A0 How it will do that? Some pxb-pcie registers? Or do we model
> =A0=A0=A0 the MMCFG like a PCI BAR?

If we can access pxb-pcie registers before configuring MMCFG then yes,
we should use pxb-pcie registers for that.

cheers,
  Gerd
