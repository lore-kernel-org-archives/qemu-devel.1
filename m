Received: from eggs.gnu.org ([2001:4830:134:3::10]:38282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gABIH-0007UD-Ox
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gABIC-0002O3-NH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gABIA-0002Fz-R5
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:00:36 -0400
Date: Wed, 10 Oct 2018 11:59:53 +0200
From: "Hoffmann, Gerd" <kraxel@redhat.com>
Message-ID: <20181010095953.7anfc57dtgwz54kt@sirius.home.kraxel.org>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181005135052.GA4113@lpt>
	<CAMxuvawF+5=GyP70FNzS3zWfoe7Ca667hMKqmjWkhCe_bNCCMg@mail.gmail.com>
	<20181005155850.vci6pt27rumdlq6t@sirius.home.kraxel.org>
	<CAMxuvazsSRvwRpDH=MR4kEnQCJgcv3FOb+hn-rdfKO3Gtpy4sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvazsSRvwRpDH=MR4kEnQCJgcv3FOb+hn-rdfKO3Gtpy4sw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Kaplansky, Victor" <victork@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Felipe Franciosi <felipe@nutanix.com>, "Liu, Changpeng" <changpeng.liu@intel.com>

On Sat, Oct 06, 2018 at 02:32:45AM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Fri, Oct 5, 2018 at 7:59 PM Hoffmann, Gerd <kraxel@redhat.com> wrote=
:
> >
> >   Hi,
> >
> > > For example, "virgl" support may not be implemented. This
> > > --print-capabilities is a simple way to check what the backend
> > > implements.
> >
> > What is the expected behavior in case virgl is implemented by the
> > backend, but not available (due to lack of 3d hardware in the host fo=
r
> > example) ?
>=20
> I would say either it fails at runtime, or the backend doesn't announce=
 it.
>=20
> Would you want something else?

Yes, one of the two, but we should clarify which one.

I suspect "fail at runtime" is easier for libvirt, given that it libvirt
must handle backend failures anyway ...

cheers,
  Gerd
