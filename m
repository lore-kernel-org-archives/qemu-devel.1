Received: from eggs.gnu.org ([2001:4830:134:3::10]:42841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlG43-0008Rb-SQ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlG3z-0002uM-1Q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlG3y-0002tt-Qu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:58:22 -0400
Date: Fri, 25 Aug 2017 15:58:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170825145810.GG2090@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-2-dgilbert@redhat.com>
	<CAJ+F1CJes1RPzwC18GdgmHMLfN9OhCMA+-8DwHnfzrzztkwH5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJes1RPzwC18GdgmHMLfN9OhCMA+-8DwHnfzrzztkwH5w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 01/32] vhu: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com, peterx@redhat.com, quintela@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Aug 24, 2017 at 9:39 PM Dr. David Alan Gilbert (git) <
> dgilbert@redhat.com> wrote:
>=20
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Add a vu_queue_started method to complement vu_queue_enabled.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks.

>=20
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 6 ++++++
> >  contrib/libvhost-user/libvhost-user.h | 9 +++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c
> > b/contrib/libvhost-user/libvhost-user.c
> > index 35fa0c5e56..201b9846e9 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -930,6 +930,12 @@ vu_queue_enabled(VuDev *dev, VuVirtq *vq)
> >      return vq->enable;
> >  }
> >
> > +bool
> > +vu_queue_started(VuDev *dev, VuVirtq *vq)
> >
>=20
> I guess we could make it const, but this is true for many other functio=
ns.
> Could be done later in one go.

Thanks; I've added the consts.

Dave

> > +{
> > +    return vq->started;
> > +}
> > +
> >  static inline uint16_t
> >  vring_avail_flags(VuVirtq *vq)
> >  {
> > diff --git a/contrib/libvhost-user/libvhost-user.h
> > b/contrib/libvhost-user/libvhost-user.h
> > index 53ef222c0b..acd019876d 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -328,6 +328,15 @@ void vu_queue_set_notification(VuDev *dev, VuVir=
tq
> > *vq, int enable);
> >  bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
> >
> >  /**
> > + * vu_queue_started:
> > + * @dev: a VuDev context
> > + * @vq: a VuVirtq queue
> > + *
> > + * Returns: whether the queue is started.
> > + */
> > +bool vu_queue_started(VuDev *dev, VuVirtq *vq);
> > +
> > +/**
> >   * vu_queue_empty:
> >   * @dev: a VuDev context
> >   * @vq: a VuVirtq queue
> > --
> > 2.13.5
> >
> >
> > --
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
