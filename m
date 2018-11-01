Received: from eggs.gnu.org ([2001:4830:134:3::10]:38329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIFBV-0004H9-VA
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIFBR-000239-TT
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:47:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gIFBR-00022v-Lc
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:46:57 -0400
Date: Thu, 1 Nov 2018 16:46:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101164645.2b2718b8@redhat.com>
In-Reply-To: <20181101150203.GV3902@habkost.net>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-2-marcandre.lureau@redhat.com>
	<20181022153330.6996de15@igors-macbook-pro.local>
	<20181026151321.GE3902@habkost.net>
	<20181029105657.5106265f@redhat.com>
	<20181030013702.GQ3902@habkost.net>
	<CAMxuvazWr=HB0XSb6u_E21Oq8AH3Jr2jD96_o7nQ4PbtfFQ0QA@mail.gmail.com>
	<20181030152243.1602e9d2@redhat.com>
	<20181030230717.GX3902@habkost.net>
	<20181101131637.5336779c@redhat.com>
	<20181101150203.GV3902@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] qom/user-creatable: add a few helper
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Bonzini,
	Paolo" <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, "Michael S . Tsirkin" <mst@redhat.com>, atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk

On Thu, 1 Nov 2018 12:02:03 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Nov 01, 2018 at 01:16:37PM +0100, Igor Mammedov wrote:
> > On Tue, 30 Oct 2018 20:07:17 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >  =20
> > > On Tue, Oct 30, 2018 at 03:22:43PM +0100, Igor Mammedov wrote: =20
> > > > On Tue, 30 Oct 2018 13:26:40 +0400
> > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > > >    =20
> > > > > Hi
> > > > >=20
> > > > > On Tue, Oct 30, 2018 at 5:37 AM Eduardo Habkost <ehabkost@redhat.=
com> wrote:   =20
> > > > > >
> > > > > > On Mon, Oct 29, 2018 at 10:56:57AM +0100, Igor Mammedov wrote: =
    =20
> > > > > > > On Fri, 26 Oct 2018 12:13:21 -0300
> > > > > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > > > >     =20
> > > > > > > > On Mon, Oct 22, 2018 at 03:33:30PM +0100, Igor Mammedov wro=
te:     =20
> > > > > > > > > On Wed, 12 Sep 2018 16:55:23 +0400
> > > > > > > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrot=
e: =20
> [...]
> > > > > > > > > >  void user_creatable_complete(Object *obj, Error **errp)
> > > > > > > > > >  {
> > > > > > > > > > -
> > > > > > > > > >      UserCreatableClass *ucc;
> > > > > > > > > > -    UserCreatable *uc =3D
> > > > > > > > > > -        (UserCreatable *)object_dynamic_cast(obj, TYPE=
_USER_CREATABLE);
> > > > > > > > > >
> > > > > > > > > > -    if (!uc) {
> > > > > > > > > > +    if (!IS_USER_CREATABLE(obj)) {
> > > > > > > > > >          return;
> > > > > > > > > >      }
> > > > > > > > > >
> > > > > > > > > > -    ucc =3D USER_CREATABLE_GET_CLASS(uc);
> > > > > > > > > > +    ucc =3D USER_CREATABLE_GET_CLASS(obj);
> > > > > > > > > >      if (ucc->complete) {
> > > > > > > > > > -        ucc->complete(uc, errp);
> > > > > > > > > > +        ucc->complete(USER_CREATABLE(obj), errp);     =
=20
> > > > > > > > >                          ^^^
> > > > > > > > > even though function becomes more concise,
> > > > > > > > > this will call expensive dynamic cast 2nd time (IS_USER_C=
REATABLE was the 1st and discarded)
> > > > > > > > > so I'm not sure is a good idea to regress startup time fo=
r readability.     =20
> > > > >=20
> > > > > I hope it's not measurable, unless we create billions of objects.=
 Do
> > > > > you want some figures?   =20
> > > > I recall penalty was big enough for QEMU, that we added qom debug o=
ption,
> > > > in case of -object, the cost could be multiplied by hundreds   =20
> > >=20
> > > This sounds like premature optimization.  Did you measure how
> > > many nanoseconds we're saving per -object option? =20
> > it's not optimization, it's about not making code worse and using
> > resources reasonably object_dynamic_cast() with IS_USER_CREATABLE(). =20
>=20
> How exactly is the code worse?
making it slower /doesn't matter how much/ when there is better way
to do it.
Anyways the point is moot as Mark rewrote it in another way (better)
so this question won't arise.

=20
> >=20
> > I'd replace object_dynamic_cast() with IS_FOO() in places where
> > we just test but do not use the result for a better readability.
> > But is we need the result later I'd keep object_dynamic_cast(),
> > it's not much worse but allows us to reuse the result of cast. =20
>=20
> Readability is orders of magnitude more important to me.
>=20
> This is not readable:
>   (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE)
>=20
> This is readable:
>   USER_CREATABLE(obj)
>=20
> If the overhead of the extra object_dynamic_cast() call is too
> much, it's already possible to disable QOM cast debugging.

I'm typically on the side of simplifying code and readability
but in this case I have to disagree, out of context ^^^ it might
look fine but with full context

 uc =3D (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE)
 if(uc)
    call(uc)

vs

 if(IS_USER_CREATABLE(obj))
   // discard above hidden cast result and do it again
   call(USER_CREATABLE(obj))
 =20
the former is not horrible enough to warrant doing senseless discard.
So lets agree to disagree :)

>=20
> > [...] =20
>=20
