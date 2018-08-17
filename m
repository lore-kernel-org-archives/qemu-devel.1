Received: from eggs.gnu.org ([2001:4830:134:3::10]:34004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqbhA-0008Ub-7F
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqbcL-0002Mr-Ra
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:04:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqbcL-0002MS-Mr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:04:29 -0400
Date: Fri, 17 Aug 2018 11:04:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817100424.GA21930@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1534491213-24748-1-git-send-email-thuth@redhat.com>
	<20180817094819.GE11124@redhat.com>
	<adc83475-3772-ca87-8498-3b5df1ddf046@redhat.com>
	<20180817095944.GF11124@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817095944.GF11124@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] qom: Rename object_new_with_props to
 object_new_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Aug 17, 2018 at 10:59:44AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 17, 2018 at 11:58:07AM +0200, Thomas Huth wrote:
> > On 08/17/2018 11:48 AM, Daniel P. Berrang=C3=A9 wrote:
> > > On Fri, Aug 17, 2018 at 09:33:33AM +0200, Thomas Huth wrote:
> > >> While adding the object_initialize_child() function, Paolo suggest=
ed
> > >> to rename the similar object_new_with_props() function accordingly=
:
> > >>
> > >> http://marc.info/?i=3De034610d-9a1d-a8a5-ee92-b2e3f0ba2891@redhat.=
com
> > >>
> > >> This way it is more obvious that this function creates a new objec=
t
> > >> as a child of another object.
> > >=20
> > > I'd expect 'object_new_with_child' to be the same as 'object_new',
> > > but with only 'parent' & 'id' args added, which isn't the case here=
.
> > >=20
> > > If we want the full & consistent design then we should have
> > >=20
> > >   object_new(typename)
> > >   object_new_with_child(typename, parent, id)
> > >   object_new_props(typename, ...)
> > >   object_new_propv(typename, va_arg props)
> > >   object_new_with_child_props(typename, parent, id, ...)
> > >   object_new_with_child_propv(typename, parent, id, va_arg props)
> >=20
> > "new_with_child" sounds wrong, too, since the parent is not created
> > here, but the child. Anyway, I guess the naming of these functions is
> > too much subject to bikeshedding, so never mind, let's keep it as it
> > currently is.
>=20
> True, 'new_with_parent' is a better choice in retrospect :-)

Or indeed 'object_new_child' and 'object_new_child_prop{s,v}' approx as
you had suggested


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
