Received: from eggs.gnu.org ([2001:4830:134:3::10]:36763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fc2pe-00039l-B9
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fc2pZ-0003KC-CJ
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:06:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39856 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fc2pZ-0003I2-6Q
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7F1F87A76
	for <qemu-devel@nongnu.org>; Sun,  8 Jul 2018 06:05:53 +0000 (UTC)
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-4-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4d42f681-44aa-0ea7-a7eb-bb3cd8240e0e@redhat.com>
Date: Sun, 8 Jul 2018 08:05:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180706105753.26700-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/27] tests: change /0.15/* tests to
 /qmp/*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 06.07.2018 12:57, Marc-Andr=C3=A9 Lureau wrote:
> Presumably 0.15 was the version it was first introduced, but
> qmp keeps evolving. There is no point in having that version
> as test prefix, 'qmp' makes more sense here.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20180326150916.9602-12-marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qmp-cmds.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index ba41a6161e..ab414fa0c9 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -286,11 +286,11 @@ int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> =20
> -    g_test_add_func("/0.15/dispatch_cmd", test_dispatch_cmd);
> -    g_test_add_func("/0.15/dispatch_cmd_failure", test_dispatch_cmd_fa=
ilure);
> -    g_test_add_func("/0.15/dispatch_cmd_io", test_dispatch_cmd_io);
> -    g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
> -    g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
> +    g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
> +    g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_fai=
lure);
> +    g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
> +    g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
> +    g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
> =20
>      test_qmp_init_marshal(&qmp_commands);
>      g_test_run();
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
