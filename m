Received: from eggs.gnu.org ([2001:4830:134:3::10]:35076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIC9j-0002UQ-8O
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIBty-0006KT-NE
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gIBty-0006KB-Dj
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:16:42 -0400
Date: Thu, 1 Nov 2018 13:16:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101131637.5336779c@redhat.com>
In-Reply-To: <20181030230717.GX3902@habkost.net>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-2-marcandre.lureau@redhat.com>
	<20181022153330.6996de15@igors-macbook-pro.local>
	<20181026151321.GE3902@habkost.net>
	<20181029105657.5106265f@redhat.com>
	<20181030013702.GQ3902@habkost.net>
	<CAMxuvazWr=HB0XSb6u_E21Oq8AH3Jr2jD96_o7nQ4PbtfFQ0QA@mail.gmail.com>
	<20181030152243.1602e9d2@redhat.com>
	<20181030230717.GX3902@habkost.net>
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

On Tue, 30 Oct 2018 20:07:17 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Oct 30, 2018 at 03:22:43PM +0100, Igor Mammedov wrote:
> > On Tue, 30 Oct 2018 13:26:40 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >  =20
> > > Hi
> > >=20
> > > On Tue, Oct 30, 2018 at 5:37 AM Eduardo Habkost <ehabkost@redhat.com>=
 wrote: =20
> > > >
> > > > On Mon, Oct 29, 2018 at 10:56:57AM +0100, Igor Mammedov wrote:   =20
> > > > > On Fri, 26 Oct 2018 12:13:21 -0300
> > > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > >   =20
> > > > > > On Mon, Oct 22, 2018 at 03:33:30PM +0100, Igor Mammedov wrote: =
  =20
> > > > > > > On Wed, 12 Sep 2018 16:55:23 +0400
> > > > > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > > > > > >   =20
> > > > > > > > Improve a bit code readability.
> > > > > > > >
> > > > > > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@red=
hat.com>
> > > > > > > > ---
> > > > > > > >  include/qom/object_interfaces.h | 4 ++++
> > > > > > > >  qom/object.c                    | 4 ++--
> > > > > > > >  qom/object_interfaces.c         | 9 +++------
> > > > > > > >  3 files changed, 9 insertions(+), 8 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/include/qom/object_interfaces.h b/include/qom/=
object_interfaces.h
> > > > > > > > index 4d513fb329..46b0861457 100644
> > > > > > > > --- a/include/qom/object_interfaces.h
> > > > > > > > +++ b/include/qom/object_interfaces.h
> > > > > > > > @@ -9,9 +9,13 @@
> > > > > > > >  #define USER_CREATABLE_CLASS(klass) \
> > > > > > > >       OBJECT_CLASS_CHECK(UserCreatableClass, (klass), \
> > > > > > > >                          TYPE_USER_CREATABLE)
> > > > > > > > +#define IS_USER_CREATABLE_CLASS(klass) \
> > > > > > > > +    object_class_dynamic_cast(OBJECT_CLASS(oc), TYPE_USER_=
CREATABLE)
> > > > > > > >  #define USER_CREATABLE_GET_CLASS(obj) \
> > > > > > > >       OBJECT_GET_CLASS(UserCreatableClass, (obj), \
> > > > > > > >                        TYPE_USER_CREATABLE)
> > > > > > > > +#define IS_USER_CREATABLE(obj) \
> > > > > > > > +    object_dynamic_cast(OBJECT(obj), TYPE_USER_CREATABLE)
> > > > > > > >  #define USER_CREATABLE(obj) \
> > > > > > > >       INTERFACE_CHECK(UserCreatable, (obj), \
> > > > > > > >                       TYPE_USER_CREATABLE)
> > > > > > > > diff --git a/qom/object.c b/qom/object.c
> > > > > > > > index 75d1d48944..0703e8e4ff 100644
> > > > > > > > --- a/qom/object.c
> > > > > > > > +++ b/qom/object.c
> > > > > > > > @@ -424,7 +424,7 @@ void object_initialize_childv(Object *p=
arentobj, const char *propname,
> > > > > > > >          goto out;
> > > > > > > >      }
> > > > > > > >
> > > > > > > > -    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
> > > > > > > > +    if (IS_USER_CREATABLE(obj)) {
> > > > > > > >          user_creatable_complete(obj, &local_err);
> > > > > > > >          if (local_err) {
> > > > > > > >              object_unparent(obj);
> > > > > > > > @@ -605,7 +605,7 @@ Object *object_new_with_propv(const cha=
r *typename,
> > > > > > > >          goto error;
> > > > > > > >      }
> > > > > > > >
> > > > > > > > -    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
> > > > > > > > +    if (IS_USER_CREATABLE(obj)) {
> > > > > > > >          user_creatable_complete(obj, &local_err);
> > > > > > > >          if (local_err) {
> > > > > > > >              object_unparent(obj);
> > > > > > > > diff --git a/qom/object_interfaces.c b/qom/object_interface=
s.c
> > > > > > > > index 72b97a8bed..e3084bc04a 100644
> > > > > > > > --- a/qom/object_interfaces.c
> > > > > > > > +++ b/qom/object_interfaces.c
> > > > > > > > @@ -10,18 +10,15 @@
> > > > > > > >
> > > > > > > >  void user_creatable_complete(Object *obj, Error **errp)
> > > > > > > >  {
> > > > > > > > -
> > > > > > > >      UserCreatableClass *ucc;
> > > > > > > > -    UserCreatable *uc =3D
> > > > > > > > -        (UserCreatable *)object_dynamic_cast(obj, TYPE_USE=
R_CREATABLE);
> > > > > > > >
> > > > > > > > -    if (!uc) {
> > > > > > > > +    if (!IS_USER_CREATABLE(obj)) {
> > > > > > > >          return;
> > > > > > > >      }
> > > > > > > >
> > > > > > > > -    ucc =3D USER_CREATABLE_GET_CLASS(uc);
> > > > > > > > +    ucc =3D USER_CREATABLE_GET_CLASS(obj);
> > > > > > > >      if (ucc->complete) {
> > > > > > > > -        ucc->complete(uc, errp);
> > > > > > > > +        ucc->complete(USER_CREATABLE(obj), errp);   =20
> > > > > > >                          ^^^
> > > > > > > even though function becomes more concise,
> > > > > > > this will call expensive dynamic cast 2nd time (IS_USER_CREAT=
ABLE was the 1st and discarded)
> > > > > > > so I'm not sure is a good idea to regress startup time for re=
adability.   =20
> > >=20
> > > I hope it's not measurable, unless we create billions of objects. Do
> > > you want some figures? =20
> > I recall penalty was big enough for QEMU, that we added qom debug optio=
n,
> > in case of -object, the cost could be multiplied by hundreds =20
>=20
> This sounds like premature optimization.  Did you measure how
> many nanoseconds we're saving per -object option?
it's not optimization, it's about not making code worse and using
resources reasonably object_dynamic_cast() with IS_USER_CREATABLE().

I'd replace object_dynamic_cast() with IS_FOO() in places where
we just test but do not use the result for a better readability.
But is we need the result later I'd keep object_dynamic_cast(),
it's not much worse but allows us to reuse the result of cast.
=20
> > > > > > (INTERFACE_CHECK is a nop if CONFIG_QOM_CAST_DEBUG is not
> > > > > > enabled, so I don't understand how it would regress startup tim=
e.   =20
> > > > > Isn't it enabled by default though?
> > > > > Maybe we should flip default to disabled then cast should be ok a=
nd enable it
> > > > > when generic '--debug' is enabled.   =20
> > > >
> > > > This is called only once for each -object option.  Even if QOM
> > > > debugging is enabled by default I don't see why it wouldn't be OK
> > > > to call object_dynamic_cast_assert() here.   =20
> > >=20
> > > Yes, imho it's very marginal. Thus I would value more readability. =20
> > Probably not marginal for folks who are trying to reduce every
> > tiny bit of start up time. =20
>=20
> These people should be disabling QOM debugging, then.
>=20
> >=20
> > Considering readablity change here doesn't really make a difference,
> > I'd pick performance. i.e. do cast and then reuse result later.
> >   =20
> > > Alternatively, we can consider replacing
> > > ucc->complete(USER_CREATABLE(obj), errp); by
> > > ucc->complete((UserCreatable*)obj, errp); to get back to the same
> > > number of dynamic_cast calls. =20
> > Unsafe casts (foo*) typically frowned upon but it should be safe
> > since one gets here after IS_USER_CREATABLE check, so I don't really
> > care in this case. But I'd drop user_creatable_complete() hunk,
> > so that original cast result is being reused. =20
>=20
> Please don't do that.  Readability, safety, and consistency are
> more important.  For the few users where QOM debugging has a
> measurable performance impact, we already have a mechanism to
> disable it.
