Received: from eggs.gnu.org ([2001:4830:134:3::10]:44943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Wwe-0002yu-Fo
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Wwa-0006ZP-J0
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:34:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Wwa-0006Z2-EI
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B33F11555C
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 18:34:07 +0000 (UTC)
References: <20180326172041.21009-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <887d47b3-9243-4088-4449-f92f1f3c2302@redhat.com>
Date: Mon, 26 Mar 2018 13:33:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180326172041.21009-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qmp-test: fix response leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com

On 03/26/2018 12:20 PM, Marc-Andr=C3=A9 Lureau wrote:
> Apparently introduced in commit a4f90923b520f1dc0a768634877eb412e5052c2=
6.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qmp-test.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

I'll queue this through my qapi tree, unless applying Peter's for-2.12=20
patches fixes it differently.

>=20
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 558e83540c..8de99a4727 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -90,6 +90,7 @@ static void test_qmp_protocol(void)
>       test_version(qdict_get(q, "version"));
>       capabilities =3D qdict_get_qlist(q, "capabilities");
>       g_assert(capabilities && qlist_empty(capabilities));
> +    QDECREF(resp);
>  =20
>       /* Test valid command before handshake */
>       resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
