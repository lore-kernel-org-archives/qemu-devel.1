Received: from eggs.gnu.org ([2001:4830:134:3::10]:36882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8kP-0006Rq-LK
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8kO-0002W7-Jw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:11:09 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cU8kO-0002Ve-DM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:11:08 -0500
Received: by mail-yw0-x242.google.com with SMTP id l75so3260803ywb.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 01:11:08 -0800 (PST)
MIME-Version: 1.0
References: <1484816804-12598-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1484816804-12598-1-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Jan 2017 09:10:57 +0000
Message-ID: <CAJ+F1CJFgEx2Q+HwWoqVh0DS7R80memvL9XYW3QqyCHyE_cSUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: Minor qapi doc generation
 target cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Thu, Jan 19, 2017 at 1:07 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Move makeinfo flags from MAKEINFO to MAKEINFOFLAGS.  Fix the call of
> quiet-command for target qemu-ga-qapi.texi.  Both messed up in commit
> 56e8bdd.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Yes, I thought you touched that before the merge:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9f8968d..f35c422 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -542,8 +542,8 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
>         ui/shader/texture-blit-vert.h ui/shader/texture-blit-frag.h
>
>  # documentation
> -MAKEINFO=3Dmakeinfo -D 'VERSION $(VERSION)'
> -MAKEINFOFLAGS=3D--no-split --number-sections
> +MAKEINFO=3Dmakeinfo
> +MAKEINFOFLAGS=3D--no-split --number-sections -D 'VERSION $(VERSION)'
>  TEXIFLAG=3D$(if $(V),,--quiet) --command=3D'@set VERSION $(VERSION)'
>
>  %.html: %.texi
> @@ -573,7 +573,7 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx
> $(SRC_PATH)/scripts/hxtool
>         $(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< >
> $@,"GEN","$@")
>
>  qemu-qapi.texi: $(qapi-modules) $(qapi-py)
> -       $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $=
<
> > $@,"GEN" "$@")
> +       $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $=
<
> > $@,"GEN","$@")
>
>  qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $=
<
> > $@,"GEN","$@")
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
