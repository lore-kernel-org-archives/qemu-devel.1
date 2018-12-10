Received: from eggs.gnu.org ([2001:4830:134:3::10]:47032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWV7E-0005Q3-Os
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 18:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWV7B-00016S-Im
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 18:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gWV7B-00014s-Cn
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 18:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 802C6D2EF0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 23:37:28 +0000 (UTC)
Date: Mon, 10 Dec 2018 18:37:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181210183313-mutt-send-email-mst@kernel.org>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: "Hoffmann, Gerd" <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>

On Mon, Dec 10, 2018 at 10:36:29PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Mon, Dec 10, 2018 at 6:30 PM Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> >
> > On Mon, Nov 26, 2018 at 04:42:40PM +0400, Marc-Andr=E9 Lureau wrote:
> > > As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> > > review, let's define a common set of backend conventions to help wi=
th
> > > management layer implementation, and interoperability.
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> >
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > btw: have you seen the idea to use a vfio-style interface for
> > communication between qemu and external device emulation processes?
>=20
> I heard there was some discussion during KVM forum.
>=20
> Fwiwi, this is also an idea I proposed last year (and quickly
> discussed during my talk about multi-process qemu).
> I also experimented with the idea, and wrote a vfio-user backend, with
> a PCI serial device running in a seperate process:
> the qemu tree: https://github.com/elmarco/qemu/tree/wip/vfio-user (dirt=
y tree)
> and the serial device:
> https://github.com/elmarco/qemu/blob/wip/vfio-user/contrib/libvfio-user=
/vfio-user-serial.c

Right. The main issue is that we need to make sure only
in-tree devices are supported. vhost-user by design
is for out of tree users. It needn't be hard,
maybe it's enough to just make qemu launch these processes
as opposed to connecting to them on command line.

>=20
>=20
> >
> > cheers,
> >   Gerd
> >
