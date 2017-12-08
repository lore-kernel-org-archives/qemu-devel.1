Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNG3R-0007Yk-54
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNG3M-00071e-9n
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:38:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNG3M-000714-3L
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:38:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 455C913AA2
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 10:38:47 +0000 (UTC)
Date: Fri, 8 Dec 2017 10:38:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171208103841.GF2403@work-vm>
References: <20171201125813.1437-1-quintela@redhat.com>
	<20171201125813.1437-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171201125813.1437-2-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] migration: free result string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reported-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(same as Marc-Andr=E9's)

> ---
>  tests/migration-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index be598d3257..799e24ebc6 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -358,13 +358,14 @@ static void migrate_check_parameter(QTestState *w=
ho, const char *parameter,
>                                      const char *value)
>  {
>      QDict *rsp, *rsp_return;
> -    const char *result;
> +    char *result;
> =20
>      rsp =3D wait_command(who, "{ 'execute': 'query-migrate-parameters'=
 }");
>      rsp_return =3D qdict_get_qdict(rsp, "return");
>      result =3D g_strdup_printf("%" PRId64,
>                               qdict_get_try_int(rsp_return,  parameter,=
 -1));
>      g_assert_cmpstr(result, =3D=3D, value);
> +    g_free(result);
>      QDECREF(rsp);
>  }
> =20
> --=20
> 2.14.3
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
