Received: from eggs.gnu.org ([2001:4830:134:3::10]:37757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNY2-0004aT-EF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNXy-0006Qd-Ib
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:24:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTNXy-0006QQ-DB
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:23:58 -0400
Date: Thu, 14 Jun 2018 09:23:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614082355.GJ6355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1528933916-40670-1-git-send-email-keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528933916-40670-1-git-send-email-keno@juliacomputing.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui: darwin: gtk: Add missing input keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Wed, Jun 13, 2018 at 07:51:56PM -0400, Keno Fischer wrote:
> In appears the input keymap for osx was forgotten in the commit that
> converted the gtk frontend to keycodemapdb. Add it.
>=20
> Fixes: 2ec78706 ("ui: convert GTK and SDL1 frontends to keycodemapdb")
> CC: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  Makefile           | 1 +
>  include/ui/input.h | 3 +++
>  ui/input-keymap.c  | 1 +
>  3 files changed, 5 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I guess this shows just how (in-)frequently people try to compile the GTK
frontend on OS-X :-(

>=20
> diff --git a/Makefile b/Makefile
> index 6a5fff0..1e79914 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -322,6 +322,7 @@ KEYCODEMAP_FILES =3D \
>  		 ui/input-keymap-xorgkbd-to-qcode.c \
>  		 ui/input-keymap-xorgxquartz-to-qcode.c \
>  		 ui/input-keymap-xorgxwin-to-qcode.c \
> +		 ui/input-keymap-osx-to-qcode.c \
>  		 $(NULL)
> =20
>  GENERATED_FILES +=3D $(KEYCODEMAP_FILES)
> diff --git a/include/ui/input.h b/include/ui/input.h
> index 16395ab..34ebc67 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -116,4 +116,7 @@ extern const guint16 qemu_input_map_xorgxquartz_to_=
qcode[];
>  extern const guint qemu_input_map_xorgxwin_to_qcode_len;
>  extern const guint16 qemu_input_map_xorgxwin_to_qcode[];
> =20
> +extern const guint qemu_input_map_osx_to_qcode_len;
> +extern const guint16 qemu_input_map_osx_to_qcode[];
> +
>  #endif /* INPUT_H */
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index 87cc301..db5ccff 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -21,6 +21,7 @@
>  #include "ui/input-keymap-xorgkbd-to-qcode.c"
>  #include "ui/input-keymap-xorgxquartz-to-qcode.c"
>  #include "ui/input-keymap-xorgxwin-to-qcode.c"
> +#include "ui/input-keymap-osx-to-qcode.c"
> =20
>  int qemu_input_linux_to_qcode(unsigned int lnx)
>  {
> --=20
> 2.8.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
