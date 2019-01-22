Received: from eggs.gnu.org ([209.51.188.92]:34135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glsej-0005zV-GW
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glsei-0000EW-LF
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:47:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1glsei-0008SN-Es
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:47:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16CCEC058CAD
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:47:28 +0000 (UTC)
Date: Tue, 22 Jan 2019 09:47:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122094720.GC13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190122092814.14919-1-kraxel@redhat.com>
	<20190122092814.14919-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122092814.14919-2-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/8] kbd-state: add keyboard state
 tracker
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

On Tue, Jan 22, 2019 at 10:28:07AM +0100, Gerd Hoffmann wrote:
> Now that most user interfaces are using QKeyCodes it is easier to have
> common keyboard code useable by all user interfaces.
>=20
> This patch adds helper code to track the state of all keyboard keys,
> using a bitmap indexed by QKeyCode.  Modifier state is tracked too,
> as separate bitmap.  That makes checking modifier state easier.
> Likewise we can easily apply special handling for capslock & numlock
> (toggles on keypress) and ctrl + shift (we have two keys for that).
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/kbd-state.h |  96 +++++++++++++++++++++++++++++++++++++
>  ui/kbd-state.c         | 125 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  ui/Makefile.objs       |   2 +-
>  3 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 include/ui/kbd-state.h
>  create mode 100644 ui/kbd-state.c
>=20
> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
> new file mode 100644
> index 0000000000..277198f169
> --- /dev/null
> +++ b/include/ui/kbd-state.h
> @@ -0,0 +1,96 @@

Missing license boilerplate header, and same in the .c file.

> +#ifndef QEMU_UI_KBD_STATE_H
> +#define QEMU_UI_KBD_STATE_H 1

With license header added

 Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
