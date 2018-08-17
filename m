Received: from eggs.gnu.org ([2001:4830:134:3::10]:50900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fqfIF-0001Jf-JH
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fqfIC-0004Na-7b
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:59:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1fqfIC-0004NJ-0Y
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D24D40676C0
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 13:59:55 +0000 (UTC)
Message-ID: <81275e43ba20750cbf90b679e6120746d34a23c7.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 17 Aug 2018 15:59:49 +0200
In-Reply-To: <20180817104351.GG11124@redhat.com>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<20180817104351.GG11124@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] clean/simple Q35 support in libvirt+QEMU
 for guest OSes that don't support virtio-1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: Laine Stump <laine@redhat.com>, Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>

On Fri, 2018-08-17 at 11:43 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 17, 2018 at 12:35:11PM +0200, Andrea Bolognani wrote:
> > If we decide we want to explicitly spell out the options instead
> > of relying on QEMU changing behavior based on the slot type, which
> > is probably a good idea anyway, I think we should have
> >=20
> >   virtio-0.9 =3D> disable-legacy=3Dno,disable-modern=3Dno
> >   virtio-1.0 =3D> disable-legacy=3Dyes,disable-modern=3Dno
> >=20
> > There's basically no reason to have a device legacy-only rather
> > than transitional, and spelling out both options instead of only
> > one of them just seems more robust.
>=20
> From a testing POV it is desirable to be able to have legacy-only.
> There is also possibility that guest OS impl 1.0 in a buggy manner,
> so forcing legacy only is desirable.
>=20
> The existing device still already provides a transitional option
> on i440fx, and on Q35 if you do explicit placement in a PCI slot.
> So I don't think there's a good reason to have a second transitional
> device type, especially if we're naming it virtio-0.9, it is rather
> misleading if it would be in fact able to run virtio-1.0 mode.

Sounds reasonable.

--=20
Andrea Bolognani / Red Hat / Virtualization
