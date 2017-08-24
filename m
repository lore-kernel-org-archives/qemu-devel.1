Received: from eggs.gnu.org ([2001:4830:134:3::10]:52048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkory-0001a4-Dl
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkorv-000591-8f
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkorv-00058j-1p
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:56:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-16-git-send-email-armbru@redhat.com>
Date: Thu, 24 Aug 2017 11:55:59 +0200
In-Reply-To: <1503564371-26090-16-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Thu, 24 Aug 2017 10:46:10 +0200")
Message-ID: <878ti9nvbk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/16] qapi: Change data type of the
 FOO_lookup generated for enum FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Markus Armbruster <armbru@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Currently, a FOO_lookup is an array of strings terminated by a NULL
> sentinel.
>
> A future patch will generate enums with "holes".  NULL-termination
> will cease to work then.
>
> To prepare for that, store the length in the FOO_lookup by wrapping it
> in a struct and adding a member for the length.
>
> The sentinel will be dropped next.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20170822132255.23945-13-marcandre.lureau@redhat.com>
> [Basically redone]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Fixup for Windows (thanks, Patchew!)


>From 594a6c8eb29e728e9fb960d321ca2d17f9bd9cd1 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 11:48:46 +0200
Subject: [PATCH] fixup! qapi: Change data type of the FOO_lookup generated =
for
 enum FOO

---
 block/file-win32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index f2a1830..639221b 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -302,7 +302,8 @@ static bool get_aio_option(QemuOpts *opts, int flags, E=
rror **errp)
=20
     aio_default =3D (flags & BDRV_O_NATIVE_AIO) ? BLOCKDEV_AIO_OPTIONS_NAT=
IVE
                                               : BLOCKDEV_AIO_OPTIONS_THREA=
DS;
-    aio =3D qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts, =
"aio"),
+    aio =3D qapi_enum_parse(&BlockdevAioOptions_lookup,
+                          qemu_opt_get(opts, "aio"),
                           aio_default, errp);
=20
     switch (aio) {
--=20
2.7.5
