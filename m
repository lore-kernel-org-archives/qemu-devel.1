Received: from eggs.gnu.org ([209.51.188.92]:42768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1guhSf-0003vX-8g
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1guhSc-0002Ao-SE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:39:41 -0500
Date: Fri, 15 Feb 2019 10:39:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190215103925.2cbd1c8c@x1.home>
In-Reply-To: <e692c549-ae11-bd08-d494-96dff03dab6e@redhat.com>
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-5-philmd@redhat.com>
	<e692c549-ae11-bd08-d494-96dff03dab6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/12] MAINTAINERS: Add missing entries
 to VFIO and NVMe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Markus Armbruster <armbru@redhat.com>, Luc Michel <luc.michel@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Fri, 15 Feb 2019 18:29:19 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 18/12/2018 12.56, Philippe Mathieu-Daud=C3=A9 wrote:
> > The VFIO helpers are used by the NVMe block driver, add the
> > entries to both sections.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > v2: add util/vfio-helpers.c, add entries to NVMe section
> > ---
> >  MAINTAINERS | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f3305a65b6..7a94b0dab3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1365,7 +1365,10 @@ VFIO
> >  M: Alex Williamson <alex.williamson@redhat.com>
> >  S: Supported
> >  F: hw/vfio/*
> > +F: util/vfio-helpers.c
> >  F: include/hw/vfio/
> > +F: include/qemu/vfio-helpers.h
> > +F: docs/igd-assign.txt
> > =20
> >  vfio-ccw
> >  M: Cornelia Huck <cohuck@redhat.com>
> > @@ -2290,6 +2293,8 @@ M: Fam Zheng <fam@euphon.net>
> >  L: qemu-block@nongnu.org
> >  S: Supported
> >  F: block/nvme*
> > +F: util/vfio-helpers.c
> > +F: include/qemu/vfio-helpers.h
> > =20
> >  Bootdevice
> >  M: Gonglei <arei.gonglei@huawei.com>
> >  =20
>=20
> Cornelia? Alex? ... Ack? NAck?

vfio-helpers consumes vfio but that's really the only tie to me having
any remote authority over it.  I think it makes more sense to tie it
with the direct consumer, which is nvme, and developer, Fam.  Thanks,

Alex
