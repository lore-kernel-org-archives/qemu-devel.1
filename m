Received: from eggs.gnu.org ([2001:4830:134:3::10]:50081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2sW-0007uS-54
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2sS-00018k-9m
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:56:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fb2sR-00015X-UQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:56:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-12-marcandre.lureau@redhat.com>
Date: Thu, 05 Jul 2018 13:56:46 +0200
In-Reply-To: <20180326150916.9602-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 26 Mar 2018 17:08:49 +0200")
Message-ID: <877em999q9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/38] tests: change /0.15/* tests to
 /qmp/*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Presumably 0.15 was the version it was first introduced, but
> qmp keeps evolving. There is no point in having that version
> as test prefix, 'qmp' makes more sense here.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/test-qmp-cmds.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index 93fbbb1b73..b49e9dd029 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -273,11 +273,11 @@ int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>=20=20
> -    g_test_add_func("/0.15/dispatch_cmd", test_dispatch_cmd);
> -    g_test_add_func("/0.15/dispatch_cmd_failure", test_dispatch_cmd_fail=
ure);
> -    g_test_add_func("/0.15/dispatch_cmd_io", test_dispatch_cmd_io);
> -    g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
> -    g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
> +    g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
> +    g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_failu=
re);
> +    g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
> +    g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
> +    g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
>=20=20
>      test_qmp_init_marshal(&qmp_commands);
>      g_test_run();

Reviewed-by: Markus Armbruster <armbru@redhat.com>
