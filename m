Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawzB-00005h-N0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawz6-0000yu-Mg
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fawz6-0000xi-HH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-6-f4bug@amsat.org>
Date: Thu, 05 Jul 2018 07:39:10 +0200
In-Reply-To: <20180704153919.12432-6-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Jul 2018 12:39:16
	-0300")
Message-ID: <87tvpeckch.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] tests/bios-tables-test: Remove useless
 casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Patch created mechanically by rerunning:
>
>   $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 4e24930c4b..c1ad1b3470 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -319,7 +319,7 @@ static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
>      ret =3D g_spawn_command_line_sync(command_line->str, &out, &out_err,=
 NULL, &error);
>      g_assert_no_error(error);
>      if (ret) {
> -        ret =3D g_file_get_contents(sdt->asl_file, (gchar **)&sdt->asl,
> +        ret =3D g_file_get_contents(sdt->asl_file, &sdt->asl,
>                                    &sdt->asl_len, &error);
>          g_assert(ret);
>          g_assert_no_error(error);

Reviewed-by: Markus Armbruster <armbru@redhat.com>
