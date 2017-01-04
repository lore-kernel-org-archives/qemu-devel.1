Received: from eggs.gnu.org ([2001:4830:134:3::10]:60979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOsad-0001CC-BS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOsaa-0007qy-91
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:55:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOsaa-0007pt-3B
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:55:16 -0500
Message-ID: <1483563313.8627.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 21:55:13 +0100
In-Reply-To: <20170104155116.GG10541@redhat.com>
References: <376FE1EF-577A-4BE3-B398-99ACB7F280F4@gmail.com>
	<1483433944.24493.3.camel@redhat.com>
	<D2287F42-8073-421D-9920-3048D63B41E3@gmail.com>
	<1483519059.5670.42.camel@redhat.com>
	<20170104155116.GG10541@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] Speed menu for GTK interfaace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

  Hi,

> > We already have "pause" in gtk, adding a "throttle" item next to it
> > looks reasonable to me.  I don't think it is that useful to have 10%
> > steps in there, you probably never throttle 10% in practice.  It's
> > probably more useful to have something like "throttle -> off / 50% /
> > 90% / 95% / 99%".
>=20
> This feels like going down the slippery slope to turn the GTK frontend
> into a full mgmt UI, which is something we've said we don't want todo
> inside QEMU UI frontends. IMHO this kind of feature is best left to
> external mgmt layers, like  virt-manager/GNOME Boxes/etc. It is already
> possible to timebox VMs CPU execution using cgroups quotas via libvirt.

Well, except that libvirt doesn't support gtk.  And gtk is what you get
by default when using qemu ad-hoc, without libvirt.  Adding features to
gtk which make sense in that context still looks useful to me.

Alternatively we could add qmp+hmp commands for cpu throttling, that way
libvirt can support the feature and with gtk it can be used too, via
monitor tab, even in case we don't create new menu items for it.

cheers,
  Gerd
