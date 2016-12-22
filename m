Received: from eggs.gnu.org ([2001:4830:134:3::10]:60044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKAYc-00018V-JO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 16:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKAYY-0006nB-Hv
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 16:05:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cKAYY-0006mX-0x
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 16:05:42 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BD238FCE6
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 21:05:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-14-marcandre.lureau@redhat.com>
Date: Thu, 22 Dec 2016 22:05:38 +0100
In-Reply-To: <20161206141343.28044-14-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 6 Dec 2016
	17:13:39 +0300")
Message-ID: <87oa03r7x9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 13/17] build-sys: use --no-split for info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Splitting the info files doesn't bring much benefits these days.
> This fixes also untracked generated info files from git ignore.
>
> Let's use MAKEINFOFLAGS for common flags, --number-sections is already
> the default anyway, so adding it doesn't change the info output.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 361773634d..0bc470d974 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -529,17 +529,17 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
>=20=20
>  # documentation
>  MAKEINFO=3Dmakeinfo
> -MAKEINFOFLAGS=3D--no-headers --no-split --number-sections
> +MAKEINFOFLAGS=3D--no-split --number-sections
>  TEXIFLAG=3D$(if $(V),,--quiet)
>  %.dvi: %.texi
>  	$(call quiet-command,texi2dvi $(TEXIFLAG) -I . $<,"GEN","$@")
>=20=20
>  %.html: %.texi
> -	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --html $< =
-o $@, \
> -	"GEN","$@")
> +	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
> +	--html $< -o $@,"GEN","$@")
>=20=20
>  %.info: %.texi
> -	$(call quiet-command,$(MAKEINFO) $< -o $@,"GEN","$@")
> +	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
>=20=20
>  %.pdf: %.texi
>  	$(call quiet-command,texi2pdf $(TEXIFLAG) -I . $<,"GEN","$@")

Reviewed-by: Markus Armbruster <armbru@redhat.com>
