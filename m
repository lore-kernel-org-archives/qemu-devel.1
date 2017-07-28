Received: from eggs.gnu.org ([2001:4830:134:3::10]:43272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dayeq-0008F4-0b
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dayem-0002Ta-IZ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:21:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dayem-0002Su-AB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:21:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 082567CD92
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 06:21:51 +0000 (UTC)
Message-ID: <1501222909.10943.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 08:21:49 +0200
In-Reply-To: <20170727174522.GA29600@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
	<20170727140025.392-5-kraxel@redhat.com>
	<20170727174522.GA29600@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, 2017-07-27 at 18:45 +0100, Daniel P. Berrange wrote:
> On Thu, Jul 27, 2017 at 04:00:22PM +0200, Gerd Hoffmann wrote:
> > Add multimedia keys to QKeyCodes and to the keymaps.
> >=20
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Message-id: 20170726152918.11995-5-kraxel@redhat.com
> > ---
> > =C2=A0ui/input-keymap.c | 44
> > ++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0qapi-schema.json=C2=A0=C2=A0| 28 +++++++++++++++++++++++++++-
> > =C2=A02 files changed, 71 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> > index 7461e1edde..ae781beae9 100644
> > --- a/ui/input-keymap.c
> > +++ b/ui/input-keymap.c
> > @@ -116,6 +116,28 @@ static int linux_to_qcode[KEY_CNT] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[KEY_LEFTMETA]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D Q_KEY_CODE_META_L,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[KEY_RIGHTMETA]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D Q_KEY_CODE_META_R,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[KEY_MENU]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_MENU,
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_SLEEP]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_SLEEP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_WAKEUP]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_WAKE,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_CALC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_CALCULATOR,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_MAIL]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_MAIL,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_COMPUTER]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D Q_KEY_CODE_COMPUTER,
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_STOP]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_AC_STOP,
>=20
> We already have a Q_KEY_CODE_STOP that I think is the correct mapping
> for KEY_STOP, so this new Q_KEY_CODE_AC_STOP looks like a dupe.

Oops, missed that indeed.

> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_BOOKMARKS]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=3D Q_KEY_CODE_AC_BOOKMARKS,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_BACK]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_AC_BACK,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_FORWARD]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D Q_KEY_CODE_AC_FORWARD,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_HOMEPAGE]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D Q_KEY_CODE_AC_HOME,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_REFRESH]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D Q_KEY_CODE_AC_REFRESH,
> > +=C2=A0=C2=A0=C2=A0=C2=A0[KEY_FIND]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D Q_KEY_CODE_AC_SEARCH,
>=20
> Similarly we already have a Q_KEY_CODE_FIND that should map to
> KEY_FIND, so this Q_KEY_CODE_AC_SEARCH is another dup AFAICT.

Yes.

> I'm curious what the 'AC_' prefix on all these is indicating ?
> Do we actually need it ?

Seems to stand for "application control".

# grep " AC " include/standard-headers/linux/input-event-codes.h=C2=A0
=C2=A0* AC - Application Control
#define KEY_STOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0128=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
* AC Stop */
#define KEY_PROPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0130=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* AC P=
roperties */
#define KEY_UNDO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0131=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
* AC Undo */
[ ... ]

I think it is better to keep it, even if it is inconsistent because we
already have stop + find without prefix.   Just dropping the ac_ prefix
will not work for some keys, ac_home for example.

> Missing Q_KEY_CODE_MEDIASELECT entry - presumably it was supposed
> to map to=C2=A0=C2=A0KEY_MEDIA

There is KEY_SELECT too, but not KEY_MEDIASELECT.  Hmm.

cheers,
  Gerd
