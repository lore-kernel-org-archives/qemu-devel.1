Received: from eggs.gnu.org ([2001:4830:134:3::10]:35715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUZK3-0001bn-Mb
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUZJz-0001BG-JV
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:42:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gUZJz-0001Au-Bl
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:42:43 -0500
Date: Wed, 5 Dec 2018 08:42:40 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181205084240.122d7626@x1.home>
In-Reply-To: <20181205093221.206dc18d.cohuck@redhat.com>
References: <154394083644.28192.8501647946108201466.stgit@gimli.home>
	<154394987445.795.4102526920089904508.stgit@gimli.home>
	<6bc68937-ec9e-d28f-9468-5ee9ba08ef52@de.ibm.com>
	<20181204122647.3a560066@x1.home>
	<CAFEAcA_5tDfoPZaPcheMGUyq_ibbvT+GE8WKgXnHf8SnxioPvA@mail.gmail.com>
	<20181204125621.0ad30dc0@x1.home>
	<20181205093221.206dc18d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3.1 8/9] q35/440fx/arm/spapr/ccw:
 Add QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael
	S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>

On Wed, 5 Dec 2018 09:32:21 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 4 Dec 2018 12:56:21 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
>=20
> > On Tue, 4 Dec 2018 19:29:25 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  =20
> > > On Tue, 4 Dec 2018 at 19:26, Alex Williamson <alex.williamson@redhat.=
com> wrote:   =20
> > > >
> > > > On Tue, 4 Dec 2018 20:16:44 +0100
> > > > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > > >     =20
> > > > > I think Conny has already added the s390/ccw part to her next tre=
e.
> > > > > From a quick glimpse both patches look identical.     =20
> > > >
> > > > If so then we can just use the original v3 version of this patch th=
at
> > > > touches all but ccw and let them come together in mainline.  My
> > > > assumption is that Peter is only trying to make sure all versioned
> > > > machines are updated early in this release, not necessarily that
> > > > they need to be updated together.     =20
> > >=20
> > > Yes, that's the idea. I also think it's a suboptimal idea
> > > to include the version-number-bump patch in a series that's
> > > adding some feature, because then if the feature itself
> > > has to go through several rounds of patch review the
> > > version-number-bump patch is stuck unapplied (we saw that
> > > at the end of the 3.1 cycle), or it gets bumped by some
> > > other unrelated series and then there's a merge conflict.
> > > But that's more of a things-for-next time remark, no need
> > > to rearrange this now.   =20
> >=20
> > If you and the other stakeholders agree, you are more than welcome to
> > pluck this patch from the series and apply it as soon as 4.0 opens.  It
> > might make things a tiny bit easier down the road to avoid the
> > conflicts since we seem to have multiple contenders vying for this
> > update.  Maybe the best practice going forward is to open the merge
> > window with such a commit.  Thanks, =20
>=20
> FWIW, I had planned to send a pull request with what is in my queue
> (including the new machine type) first thing after 4.0 opens.
>=20
> For the next release: Should we always create a patch like this that
> adds the new type for all machines and queue this as the first thing
> when the tree opens again? (I'd even be willing to do that...) For this
> release, I would prefer to use the already-existing patches instead.

Ok, so we'll stick with the original v3 version that didn't include ccw
and Marc-Andr=C3=A9's series and this one can fight it out for the rest of
the versioned machines.  Please disregard this v3.1 patch including
ccw.  Thanks,

Alex
