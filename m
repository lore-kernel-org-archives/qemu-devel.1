Received: from eggs.gnu.org ([209.51.188.92]:60956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glsZ1-0001LI-B1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glsZ0-0003bM-62
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:41:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1glsZ0-0003a8-0A
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:41:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B101DC057F99
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:41:43 +0000 (UTC)
Date: Tue, 22 Jan 2019 09:41:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122094139.GB13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-6-kraxel@redhat.com>
	<20181221111801.GI7439@redhat.com>
	<20190122090036.p7hfsgezzokpovlh@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122090036.p7hfsgezzokpovlh@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/7] kbd-state: use state tracker
 for vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 22, 2019 at 10:00:36AM +0100, Gerd Hoffmann wrote:
> > > @@ -1859,30 +1828,25 @@ static void do_key_event(VncState *vs, int =
down, int keycode, int sym)
> > >             toggles capslock away from the VNC window.
> > >          */
> > >          int uppercase =3D !!(sym >=3D 'A' && sym <=3D 'Z');
> > > -        int shift =3D !!(vs->modifiers_state[0x2a] | vs->modifiers=
_state[0x36]);
> > > -        int capslock =3D !!(vs->modifiers_state[0x3a]);
> > > +        bool shift =3D kbd_state_modifier_get(vs->vd->kbd, KBD_MOD=
_SHIFT);
> > > +        bool capslock =3D kbd_state_modifier_get(vs->vd->kbd, KBD_=
MOD_CAPSLOCK);
> >=20
> > This uses the modifier state
> >=20
> > In old code it would use the newly updated modifier state
> >=20
> > In new code it now uses the old modifier state.
>=20
> Ordering doesn't matter.  This code doesn't run on modifier key events.
> On letter keydown events it checks whenever shift and capslock state ar=
e
> consistent, and if not it generates a capslock keypress.

Ok, then

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
