Received: from eggs.gnu.org ([2001:4830:134:3::10]:56480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhvz-0000hk-Dh
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhvv-0001aD-FE
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:32:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOhvv-0001Zp-9k
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:32:35 -0500
Message-ID: <1483520239.5670.47.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 09:57:19 +0100
In-Reply-To: <9ef03a73-2139-e586-7c2d-c234863bdcac@cendio.se>
References: <3fcc534530370027118377dc24d4049a1cef590e.1481807806.git.ossman@cendio.se>
	<1481820076.21413.23.camel@redhat.com>
	<9ef03a73-2139-e586-7c2d-c234863bdcac@cendio.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vnc: track LED state separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Ossman <ossman@cendio.se>
Cc: qemu-devel@nongnu.org

On Fr, 2016-12-16 at 10:00 +0100, Pierre Ossman wrote:
> On 15/12/16 17:41, Gerd Hoffmann wrote:
> >>
> >> -    caps =3D ledstate & QEMU_CAPS_LOCK_LED ? 1 : 0;
> >> -    num  =3D ledstate & QEMU_NUM_LOCK_LED  ? 1 : 0;
> >> -    scr  =3D ledstate & QEMU_SCROLL_LOCK_LED ? 1 : 0;
> >> +    if (ledstate !=3D vd->ledstate)
> >> +        return;
> >
> > Hmm?  Shouldn't that be (ledstate =3D=3D vd->ledstate)?
> >
>=20
> Right, sorry. Brain fart. :)

/me wonders how you've tested the patch ...

> Can you fix that up before commit or do you want a new patch?

Tried, but checkpatch found some more issues:

=3D=3D=3D checkpatch complains =3D=3D=3D
ERROR: braces {} are necessary for all arms of this statement
#71: FILE: ui/vnc.c:1691:
+    if (ledstate !=3D vd->ledstate)
[...]

ERROR: braces {} are necessary for all arms of this statement
#106: FILE: ui/vnc.c:3159:
+    if (vd->lock_key_sync)
[...]

ERROR: braces {} are necessary for all arms of this statement
#115: FILE: ui/vnc.c:3728:
+    if (lock_key_sync)
[...]

total: 3 errors, 0 warnings, 125 lines checked

Please fix and resend.

thanks,
  Gerd

>=20
> Regards
