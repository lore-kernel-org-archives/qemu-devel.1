Received: from eggs.gnu.org ([2001:4830:134:3::10]:49411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIpm-0001Mv-Bi
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIpi-0006UC-71
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:19:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gaIph-0006T5-RW
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:19:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF23A169736
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 11:19:07 +0000 (UTC)
Date: Fri, 21 Dec 2018 11:19:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181221111903.GK7439@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-8-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219120904.17643-8-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/7] keymap: fix keyup mappings
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

On Wed, Dec 19, 2018 at 01:09:04PM +0100, Gerd Hoffmann wrote:
> It is possible that the modifier state on keyup is different from the
> modifier state on keydown.  In that case the keycode lookup can end up
> with different keys in case multiple keysym -> keycode mappings exist,
> because it picks the mapping depending on modifier state.
>=20
> To fix that change the lookup logic for keyup events.  Instead of
> looking at the modifier state check the key state and prefer a keycodes
> where the key is in "down" state right now.
>=20
> Fixes: abb4f2c965 keymap: consider modifier state when picking a mappin=
g
> Buglink: https://bugs.launchpad.net/bugs/1738283
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1658676
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/keymaps.h |  2 +-
>  ui/curses.c  |  2 +-
>  ui/keymaps.c | 55 ++++++++++++++++++++++++++++++++++------------------=
---
>  ui/vnc.c     |  2 +-
>  4 files changed, 37 insertions(+), 24 deletions(-)


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
