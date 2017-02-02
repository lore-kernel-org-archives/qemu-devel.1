Received: from eggs.gnu.org ([2001:4830:134:3::10]:47736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZJC1-0006W9-Q2
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZJBw-00028B-Q4
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:21:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cZJBw-00027p-KX
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:20:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACC3F8046D
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 15:20:56 +0000 (UTC)
Message-ID: <1486048853.3484.21.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 02 Feb 2017 16:20:53 +0100
In-Reply-To: <25c8a78b-1d81-2a62-61ac-722d22999c41@redhat.com>
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
	<25c8a78b-1d81-2a62-61ac-722d22999c41@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, drjones@redhat.com

On Thu, 2017-02-02 at 16:42 +0200, Marcel Apfelbaum wrote:
[...]
> > +[device "ich9-pcie-port-1"]
>=C2=A0
> I would use the new generic root port.

This sample configuration (q35-emulated.cfg) is supposed to
match physical hardware as closely as possible, so we should
stick with ioh3420s.

[...]
> > +[device "pci.1"]
> > +=C2=A0=C2=A0driver =3D "ioh3420"
>=C2=A0
> Same here, maybe we can use the new generic port.

These sample configuration files (q35-virtio-*.cfg) should
probably use the generic ports instead, yes. It's just that
they were not merged yet when I started working on this :)

[...]
> > +[device "ich9-pci-bridge"]
> > +=C2=A0=C2=A0driver =3D "i82801b11-bridge"
> > +=C2=A0=C2=A0bus =3D "pcie.0"
> > +=C2=A0=C2=A0addr =3D "1e.0"
>=C2=A0
> I am not sure about having the DMI-PCI bridge "by default".
> Users can understand is actually a good idea to have it by default
> while we don't really want them to use legacy PCI devices on Q35;
> and even if so, they should use them as Integrated Endpoints.
> They don't have hotplug for the DMI-PCI bridge anyway.

Not sure about this one. It doesn't show up on my laptop,
so it's not like every single q35-based physical machine has
it. I'd be okay with dropping it, but I leave the decision
to Gerd.

[...]
> Thanks for taking your time to update the configuration files!
> Marcel
>=C2=A0
>=C2=A0
> I personally don't use them because every time I try, I
> find something with no config support....

Is that so? Can you please test these new ones and see
whether they work for you?

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
