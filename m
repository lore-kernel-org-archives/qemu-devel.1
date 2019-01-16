Received: from eggs.gnu.org ([209.51.188.92]:55265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjuhX-0002ZK-RC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjuXx-00021I-Jd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gjuXo-0001s8-3A
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:24:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A34B874F12
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 23:24:17 +0000 (UTC)
Date: Wed, 16 Jan 2019 21:24:11 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190116232411.GE14807@habkost.net>
References: <20190115165614.GL16157@redhat.com>
	<624086124c9a2673c627203f3310fd63495e00c0.camel@redhat.com>
	<20190116113953.GO20275@redhat.com>
	<d3fd5d3bf9a6823b24756b4f376e20903ac1a575.camel@redhat.com>
	<20190116124445.GS20275@redhat.com>
	<2b4954e50ad51e7b3bdaf6b7b183254e2a1cd70d.camel@redhat.com>
	<20190116143722.GY20275@redhat.com>
	<20190116144543.GA14807@habkost.net>
	<20190116154042.GA20275@redhat.com>
	<a85c6b3f384fc82c7d5d2debf8c7ad0eedcbb657.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a85c6b3f384fc82c7d5d2debf8c7ad0eedcbb657.camel@redhat.com>
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
To: Andrea Bolognani <abologna@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Cole Robinson <crobinso@redhat.com>, libvirt-list@redhat.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Jan 16, 2019 at 05:24:02PM +0100, Andrea Bolognani wrote:
> On Wed, 2019-01-16 at 15:40 +0000, Daniel P. Berrang=E9 wrote:
> > On Wed, Jan 16, 2019 at 12:45:43PM -0200, Eduardo Habkost wrote:
> > > But I don't want to create unnecessary obstacles for libvirt, so
> > > if there's a real benefit in promising compatibility between both
> > > device types, we can still promise that on the QEMU side.
> >=20
> > I don't think there's an obstacle for libvirt, as I don't see any
> > compelling reason to avoid the new devices when we have QEMU >=3D 4.0=
.
>=20
> Alright, let's do it that way then.
>=20
> I still think it's important to maintain the relationship between
> old and new devices consistent going forward, because not doing so
> will certainly result in confusion for those using QEMU directly.

Agreed that it's a good thing to have.  I will extend the
existing virtio_version.py test case to be more strict and try to
catch mistakes that would break compatibility between the two
device types in the future.

--=20
Eduardo
