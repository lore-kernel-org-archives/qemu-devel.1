Received: from eggs.gnu.org ([2001:4830:134:3::10]:59861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZPdZ-0001OP-4D
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZPdV-0002TB-59
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:13:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZPdU-0002Rx-Uv
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:13:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AF8BC04BD2B
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 22:13:49 +0000 (UTC)
Message-ID: <1486073625.20628.57.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Feb 2017 23:13:45 +0100
In-Reply-To: <1486048853.3484.21.camel@redhat.com>
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
	<25c8a78b-1d81-2a62-61ac-722d22999c41@redhat.com>
	<1486048853.3484.21.camel@redhat.com>
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
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, drjones@redhat.com

On Do, 2017-02-02 at 16:20 +0100, Andrea Bolognani wrote:
> On Thu, 2017-02-02 at 16:42 +0200, Marcel Apfelbaum wrote:
> [...]
> > > +[device "ich9-pcie-port-1"]
> >=20
> > I would use the new generic root port.
>=20
> This sample configuration (q35-emulated.cfg) is supposed to
> match physical hardware as closely as possible, so we should
> stick with ioh3420s.

Agree.

> [...]
> > > +[device "pci.1"]
> > > +  driver =3D "ioh3420"
> >=20
> > Same here, maybe we can use the new generic port.
>=20
> These sample configuration files (q35-virtio-*.cfg) should
> probably use the generic ports instead, yes. It's just that
> they were not merged yet when I started working on this :)

Agree too.

> > I am not sure about having the DMI-PCI bridge "by default".
> > Users can understand is actually a good idea to have it by default
> > while we don't really want them to use legacy PCI devices on Q35;
> > and even if so, they should use them as Integrated Endpoints.
> > They don't have hotplug for the DMI-PCI bridge anyway.
>=20
> Not sure about this one. It doesn't show up on my laptop,
> so it's not like every single q35-based physical machine has
> it.

Is your laptop really q35+ich9 or something newer?

> I'd be okay with dropping it, but I leave the decision
> to Gerd.

Please leave it in for qemu-emulated.cfg, as this is supposed to serve
as documentation how real q35 hardware looks like.

=46rom the virtio variants it can be dropped.

> > I personally don't use them because every time I try, I
> > find something with no config support....
>=20
> Is that so? Can you please test these new ones and see
> whether they work for you?

I think mst means that not all qemu command line switches are using
QemuOpts, and the ones which don't can't be used with -readconfig.

cheers,
  Gerd
