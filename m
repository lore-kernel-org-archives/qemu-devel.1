Received: from eggs.gnu.org ([209.51.188.92]:59397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gjo5R-0005X4-FX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gjo5P-0003xX-IM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:30:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gjo5P-0003tz-CL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:30:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92D26811D6
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 16:24:10 +0000 (UTC)
Message-ID: <a85c6b3f384fc82c7d5d2debf8c7ad0eedcbb657.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 16 Jan 2019 17:24:02 +0100
In-Reply-To: <20190116154042.GA20275@redhat.com>
References: <cover.1547420060.git.crobinso@redhat.com>
	<1ac81ba920b03d153f80236fea5aa81321e054fa.1547420060.git.crobinso@redhat.com>
	<20190115165614.GL16157@redhat.com>
	<624086124c9a2673c627203f3310fd63495e00c0.camel@redhat.com>
	<20190116113953.GO20275@redhat.com>
	<d3fd5d3bf9a6823b24756b4f376e20903ac1a575.camel@redhat.com>
	<20190116124445.GS20275@redhat.com>
	<2b4954e50ad51e7b3bdaf6b7b183254e2a1cd70d.camel@redhat.com>
	<20190116143722.GY20275@redhat.com>
	<20190116144543.GA14807@habkost.net>
	<20190116154042.GA20275@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 4/6] qemu: Wire up disk
 model=virtio-{non-}transitional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Cole Robinson <crobinso@redhat.com>, libvirt-list@redhat.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 2019-01-16 at 15:40 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 16, 2019 at 12:45:43PM -0200, Eduardo Habkost wrote:
> > But I don't want to create unnecessary obstacles for libvirt, so
> > if there's a real benefit in promising compatibility between both
> > device types, we can still promise that on the QEMU side.
>=20
> I don't think there's an obstacle for libvirt, as I don't see any
> compelling reason to avoid the new devices when we have QEMU >=3D 4.0.

Alright, let's do it that way then.

I still think it's important to maintain the relationship between
old and new devices consistent going forward, because not doing so
will certainly result in confusion for those using QEMU directly.

--=20
Andrea Bolognani / Red Hat / Virtualization
