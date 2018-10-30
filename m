Received: from eggs.gnu.org ([2001:4830:134:3::10]:51205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHQIg-0003CG-6D
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHQIa-0007l0-Bc
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:27:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gHQIY-0007im-G8
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:26:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so12624104qto.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 02:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-2-marcandre.lureau@redhat.com>
	<20181022153330.6996de15@igors-macbook-pro.local>
	<20181026151321.GE3902@habkost.net>
	<20181029105657.5106265f@redhat.com>
	<20181030013702.GQ3902@habkost.net>
In-Reply-To: <20181030013702.GQ3902@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 13:26:40 +0400
Message-ID: <CAMxuvazWr=HB0XSb6u_E21Oq8AH3Jr2jD96_o7nQ4PbtfFQ0QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "Michael S . Tsirkin" <mst@redhat.com>, atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk

Hi

On Tue, Oct 30, 2018 at 5:37 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> On Mon, Oct 29, 2018 at 10:56:57AM +0100, Igor Mammedov wrote:
> > On Fri, 26 Oct 2018 12:13:21 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > > On Mon, Oct 22, 2018 at 03:33:30PM +0100, Igor Mammedov wrote:
> > > > On Wed, 12 Sep 2018 16:55:23 +0400
> > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > > >
> > > > > Improve a bit code readability.
> > > > >
> > > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> > > > > ---
> > > > >  include/qom/object_interfaces.h | 4 ++++
> > > > >  qom/object.c                    | 4 ++--
> > > > >  qom/object_interfaces.c         | 9 +++------
> > > > >  3 files changed, 9 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/include/qom/object_interfaces.h b/include/qom/object=
_interfaces.h
> > > > > index 4d513fb329..46b0861457 100644
> > > > > --- a/include/qom/object_interfaces.h
> > > > > +++ b/include/qom/object_interfaces.h
> > > > > @@ -9,9 +9,13 @@
> > > > >  #define USER_CREATABLE_CLASS(klass) \
> > > > >       OBJECT_CLASS_CHECK(UserCreatableClass, (klass), \
> > > > >                          TYPE_USER_CREATABLE)
> > > > > +#define IS_USER_CREATABLE_CLASS(klass) \
> > > > > +    object_class_dynamic_cast(OBJECT_CLASS(oc), TYPE_USER_CREATA=
BLE)
> > > > >  #define USER_CREATABLE_GET_CLASS(obj) \
> > > > >       OBJECT_GET_CLASS(UserCreatableClass, (obj), \
> > > > >                        TYPE_USER_CREATABLE)
> > > > > +#define IS_USER_CREATABLE(obj) \
> > > > > +    object_dynamic_cast(OBJECT(obj), TYPE_USER_CREATABLE)
> > > > >  #define USER_CREATABLE(obj) \
> > > > >       INTERFACE_CHECK(UserCreatable, (obj), \
> > > > >                       TYPE_USER_CREATABLE)
> > > > > diff --git a/qom/object.c b/qom/object.c
> > > > > index 75d1d48944..0703e8e4ff 100644
> > > > > --- a/qom/object.c
> > > > > +++ b/qom/object.c
> > > > > @@ -424,7 +424,7 @@ void object_initialize_childv(Object *parento=
bj, const char *propname,
> > > > >          goto out;
> > > > >      }
> > > > >
> > > > > -    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
> > > > > +    if (IS_USER_CREATABLE(obj)) {
> > > > >          user_creatable_complete(obj, &local_err);
> > > > >          if (local_err) {
> > > > >              object_unparent(obj);
> > > > > @@ -605,7 +605,7 @@ Object *object_new_with_propv(const char *typ=
ename,
> > > > >          goto error;
> > > > >      }
> > > > >
> > > > > -    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
> > > > > +    if (IS_USER_CREATABLE(obj)) {
> > > > >          user_creatable_complete(obj, &local_err);
> > > > >          if (local_err) {
> > > > >              object_unparent(obj);
> > > > > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > > > > index 72b97a8bed..e3084bc04a 100644
> > > > > --- a/qom/object_interfaces.c
> > > > > +++ b/qom/object_interfaces.c
> > > > > @@ -10,18 +10,15 @@
> > > > >
> > > > >  void user_creatable_complete(Object *obj, Error **errp)
> > > > >  {
> > > > > -
> > > > >      UserCreatableClass *ucc;
> > > > > -    UserCreatable *uc =3D
> > > > > -        (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREA=
TABLE);
> > > > >
> > > > > -    if (!uc) {
> > > > > +    if (!IS_USER_CREATABLE(obj)) {
> > > > >          return;
> > > > >      }
> > > > >
> > > > > -    ucc =3D USER_CREATABLE_GET_CLASS(uc);
> > > > > +    ucc =3D USER_CREATABLE_GET_CLASS(obj);
> > > > >      if (ucc->complete) {
> > > > > -        ucc->complete(uc, errp);
> > > > > +        ucc->complete(USER_CREATABLE(obj), errp);
> > > >                          ^^^
> > > > even though function becomes more concise,
> > > > this will call expensive dynamic cast 2nd time (IS_USER_CREATABLE w=
as the 1st and discarded)
> > > > so I'm not sure is a good idea to regress startup time for readabil=
ity.

I hope it's not measurable, unless we create billions of objects. Do
you want some figures?

> > >
> > > (INTERFACE_CHECK is a nop if CONFIG_QOM_CAST_DEBUG is not
> > > enabled, so I don't understand how it would regress startup time.
> > Isn't it enabled by default though?
> > Maybe we should flip default to disabled then cast should be ok and ena=
ble it
> > when generic '--debug' is enabled.
>
> This is called only once for each -object option.  Even if QOM
> debugging is enabled by default I don't see why it wouldn't be OK
> to call object_dynamic_cast_assert() here.

Yes, imho it's very marginal. Thus I would value more readability.

Alternatively, we can consider replacing
ucc->complete(USER_CREATABLE(obj), errp); by
ucc->complete((UserCreatable*)obj, errp); to get back to the same
number of dynamic_cast calls.
