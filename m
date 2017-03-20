Received: from eggs.gnu.org ([2001:4830:134:3::10]:51230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxBs-0008FW-6Z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxBo-0004rt-Uv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:17:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cpxBo-0004qe-OU
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:17:36 -0400
Date: Mon, 20 Mar 2017 09:17:31 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <466178818.9811389.1490015851375.JavaMail.zimbra@redhat.com>
In-Reply-To: <1490015515-25851-2-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-2-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/6] qapi: Drop excessive Make
 dependencies on qapi2texi.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre lureau <marcandre.lureau@redhat.com>, eblake@redhat.com, mdroth@linux.vnet.ibm.com



----- Original Message -----
> When qapi2texi.py changes, we regenerate everything QAPI.  Screwed up
> in commit 56e8bdd.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 73e0c12..14d3e55 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -391,7 +391,6 @@ qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-genera=
ted
>  gen-out-type =3D $(subst .,-,$(suffix $@))
> =20
>  qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
> -qapi-py +=3D $(SRC_PATH)/scripts/qapi2texi.py
> =20
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
:\
>  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py
>  $(qapi-py)
> @@ -700,10 +699,12 @@ qemu-monitor-info.texi:
> $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
>  qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxt=
ool
>  =09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN"=
,"$@")
> =20
> -docs/qemu-qmp-qapi.texi: $(qapi-modules) $(qapi-py)
> +docs/qemu-qmp-qapi.texi docs/qemu-ga-qapi.texi:
> $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
> +
> +docs/qemu-qmp-qapi.texi: $(qapi-modules)
>  =09$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< >
>  =09$@,"GEN","$@")
> =20
> -docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
> +docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
>  =09$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< >
>  =09$@,"GEN","$@")
> =20
>  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi
>  qemu-monitor-info.texi
> --
> 2.7.4
>=20
>=20
