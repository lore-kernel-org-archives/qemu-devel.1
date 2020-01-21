Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8752C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F59E2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMa7QdHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F59E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itun3-0006TX-Aq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ituer-00047Z-3c
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ituem-0005NJ-65
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:37:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21146
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ituem-0005Mc-1B
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579617447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+UzUK2wRmVZ144t7lo3LyLfhE0JZJ3+2YM1Va6gtcY=;
 b=hMa7QdHKCOioIiIofFS4dXaZc2GTwSVrNNL0mM/Bm7BQCbQWln3QDMSnrcRJhv3zXkFVrG
 jp0BPwro/bXnLfJQuVngBNQZStMD5CYW20jpn8qyj0JWiwrFeAxUzTB/DD/rRy25LmFPsY
 n4jO+pXWcZQ//SbN2dXlYWQbHaq7vAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-3XPRmgp5MbWvBArZR8M4rw-1; Tue, 21 Jan 2020 09:37:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2363418B6380;
 Tue, 21 Jan 2020 14:37:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AF5F60C88;
 Tue, 21 Jan 2020 14:37:01 +0000 (UTC)
Date: Tue, 21 Jan 2020 14:36:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Integrating QOM into QAPI (was: Making QEMU easier for
 management tools and applications)
Message-ID: <20200121143658.GB597037@redhat.com>
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87wo9lc4oe.fsf_-_@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3XPRmgp5MbWvBArZR8M4rw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 02:36:17PM +0100, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>=20
> > Hi
> >
> > On Tue, Jan 21, 2020 at 3:32 PM Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> >>
> >> On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
> >> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >> >
> >> > > On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
> >> > >> Christophe de Dinechin <dinechin@redhat.com> writes:
> >> > >> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com=
> wrote:
> >> > >> * qemuMonitorJSONSetIOThread() uses it to control iothread's prop=
erties
> >> > >>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
> >> > >>   documented (in qemu-options.hx), their use with qom-set is not.
> >> > >
> >> > > I'm happy to use a different interface.
> >> > >
> >> > > Writing a boilerplate "iothread-set-poll-params" QMP command in C =
would
> >> > > be a step backwards.
> >> >
> >> > No argument.
> >> >
> >> > > Maybe the QAPI code generator could map something like this:
> >> > >
> >> > >   { 'command': 'iothread-set-poll-params',
> >> > >     'data': {
> >> > >         'id': 'str',
> >> > >     '*max-ns': 'uint64',
> >> > >     '*grow': 'uint64',
> >> > >     '*shrink': 'uint64'
> >> > >     },
> >> > >     'map-to-qom-set': 'IOThread'
> >> > >   }
> >> > >
> >> > > And turn it into QOM accessors on the IOThread object.
> >> >
> >> > I think a generic "set this configuration to that value" command is =
just
> >> > fine.  qom-set fails on several counts, though:
> >> >
> >> > * Tolerable: qom-set is not actually generic, it applies only to QOM=
.
> >> >
> >> > * qom-set lets you set tons of stuff that is not meant to be changed=
 at
> >> >   run time.  If it breaks your guest, you get to keep the pieces.
> >> >
> >> > * There is virtually no documentation on what can be set to what val=
ues,
> >> >   and their semantics.
> >> >
> >> > In its current state, QOM is a user interface superfund site.
> >>
> >> Thoughts about a solution:
> >>
> >> Static QOM properties should be declared via QAPI instead of
> >> imperatively via QOM APIs.  That way they are introspectable and type
> >> information is present in the schema.
> >>
> >> The QAPI code generator could emit a function that is callable from
> >> .class_init().  This eliminates the need to manually call
> >> object_class_property_add().
>=20
> We need to make up our minds what exactly we want generated.  Then we
> can design the QAPI language, and code up the generator.
>=20
> Skeleton QOM type, to help with the discussion:
>=20
>     #define TYPE_FOO "foo"
>=20
>     #define FOO(obj) OBJECT_CHECK(Foo, (obj), TYPE_FOO)
>     #define FOO_CLASS(klass) \
>         OBJECT_CLASS_CHECK(FooClass, (klass), TYPE_FOO)
>     #define FOO_GET_CLASS(obj) \
>         OBJECT_GET_CLASS(FooClass, (obj), TYPE_FOO)
>=20
>     typedef FooClass {
>         ParentClass parent_class;
>         ... // hand-written per-class state
>     }
>=20
>     struct Chardev {
>         ParentObject parent_obj;
>         ... // hand-written instance (per-object) state
>     };
>=20
>     static const TypeInfo char_type_info =3D {
>         .name =3D TYPE_FOO,
>         .parent =3D TYPE_OBJECT,
>         .instance_size =3D sizeof(Foo),
>         .instance_init =3D ...,                   // methods to initializ=
e
>         .instance_post_init =3D ...,              // and finalize instanc=
es,
>         .instance_finalize =3D ...,               // all optional
>         .abstract =3D ...,                        // true or false (d'oh)
>         .class_size =3D sizeof(FooClass),
>         .class_init =3D ...,                      // methods to initializ=
e
>         .class_base_init =3D ...,                 // classes, optional
>         .class_data =3D ...,                      // extra argument for t=
hem
>         .interfaces =3D ...
>     };
>=20
> There's substantial boilerplate, with plenty of hand-written code in the
> gaps.  What of the boilerplate do we plan to generate?  How do we plan
> to fill the gaps, if any?

FWIW, even without a QOM generator, we can do waaaaaaay better on the
amount of boilerplate needed for QOM without very much work. It just
needs a few convenience macros writing.

QOM is not GObject, but is heavily inspired by it and so looking at
GObject gives us a design pattern we can aim to match in terms of
amount of boilerplate.

What we do manually with TypeInfo struct there has essentially always
been done by a 1 line macro in GObject:

  G_DEFINE_TYPE(virIdentity, vir_identity, G_TYPE_OBJECT)

If implementing interfaces, there's 1 extra line needed per interface
to associate them.

  https://developer.gnome.org/gobject/stable/gobject-Type-Information.html#=
G-DEFINE-TYPE:CAPS
 =20

And what we do in the header file to add the 4 or more FOO_XXX macros,
and the class struct and the object struct has recently been turned
into a 2-liner:

  #define VIR_TYPE_IDENTITY vir_identity_get_type()
  G_DECLARE_FINAL_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObject);

  https://developer.gnome.org/gobject/stable/gobject-Type-Information.html#=
G-DECLARE-FINAL-TYPE:CAPS

Or=20

  #define VIR_TYPE_IDENTITY vir_identity_get_type()
  G_DECLARE_DERIVABLE_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObjec=
t);

  https://developer.gnome.org/gobject/stable/gobject-Type-Information.html#=
G-DECLARE-DERIVABLE-TYPE:CAPS


It would be nice to have a QOM code generator so that we can statically
declare properties & parent/child/interface relationships, but for an
immediate low cost win, better macros would be very useful IMHO.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


