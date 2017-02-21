Received: from eggs.gnu.org ([2001:4830:134:3::10]:57339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgBHa-0004CW-Ic
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgBHZ-0005Xb-In
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:19:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgBHZ-0005Wq-DL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:19:09 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96DA33D95D
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:19:09 +0000 (UTC)
Date: Tue, 21 Feb 2017 14:19:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170221141904.GI2377@work-vm>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-31-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170221141451.28305-31-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 30/30] migration: fix id leak regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> This leak was introduced in commit
> 581f08bac22bdd5e081ae07f68071a0fc3c5c2c7.
>=20
> (it stands out quickly with ASAN once the rest of the leaks are also
> removed from make check with this series)

Oops yes.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>=20
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/savevm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 5ecd264134..87c7a00832 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -688,6 +688,7 @@ int vmstate_register_with_alias_id(DeviceState *dev=
, int instance_id,
> =20
>                  return -1;
>              }
> +            g_free(id);
> =20
>              se->compat =3D g_new0(CompatEntry, 1);
>              pstrcpy(se->compat->idstr, sizeof(se->compat->idstr), vmsd=
->name);
> --=20
> 2.11.0.295.gd7dffce1c.dirty
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
