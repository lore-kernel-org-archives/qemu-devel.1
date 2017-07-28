Received: from eggs.gnu.org ([2001:4830:134:3::10]:59064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0dS-0006X3-4q
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0dO-0001yt-5V
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db0dN-0001xb-SV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAE0D22759
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 08:28:32 +0000 (UTC)
Date: Fri, 28 Jul 2017 09:28:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728082826.GE31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
	<20170727140025.392-5-kraxel@redhat.com>
	<20170727174522.GA29600@redhat.com>
	<1501222909.10943.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501222909.10943.1.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/7] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Fri, Jul 28, 2017 at 08:21:49AM +0200, Gerd Hoffmann wrote:
> On Thu, 2017-07-27 at 18:45 +0100, Daniel P. Berrange wrote:
> > On Thu, Jul 27, 2017 at 04:00:22PM +0200, Gerd Hoffmann wrote:
> > > Add multimedia keys to QKeyCodes and to the keymaps.
> > >=20
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > > Message-id: 20170726152918.11995-5-kraxel@redhat.com
> > > ---
> > > =C2=A0ui/input-keymap.c | 44
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0qapi-schema.json=C2=A0=C2=A0| 28 +++++++++++++++++++++++++++-
> > > =C2=A02 files changed, 71 insertions(+), 1 deletion(-)
> > >=20

> > I'm curious what the 'AC_' prefix on all these is indicating ?
> > Do we actually need it ?
>=20
> Seems to stand for "application control".
>=20
> # grep " AC " include/standard-headers/linux/input-event-codes.h=C2=A0
> =C2=A0* AC - Application Control
> #define KEY_STOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0128=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
* AC Stop */
> #define KEY_PROPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0130=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* A=
C Properties */
> #define KEY_UNDO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0131=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
* AC Undo */
> [ ... ]
>=20
> I think it is better to keep it, even if it is inconsistent because we
> already have stop + find without prefix.   Just dropping the ac_ prefix
> will not work for some keys, ac_home for example.

Ok

>=20
> > Missing Q_KEY_CODE_MEDIASELECT entry - presumably it was supposed
> > to map to=C2=A0=C2=A0KEY_MEDIA
>=20
> There is KEY_SELECT too, but not KEY_MEDIASELECT.  Hmm.

I found a keyboard with a key labelled "Media"  and when pressed
it generates Linux key 171  / AT set1  0xe0 0x01 which is KEY_CONFIG
and GNOME pops up the control panel when pressed !

Would be interested to know results of "showkey" and "showkey -s" for
any other keyboards with a key labelled "Media", since I don't entirely
trust this particular one to be representative of general usage.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
