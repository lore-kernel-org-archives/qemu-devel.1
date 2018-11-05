Received: from eggs.gnu.org ([2001:4830:134:3::10]:42673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJcvY-0007Wq-2j
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJcvT-0008GQ-U6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:20:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gJcvT-00083O-K7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:20:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D756C3082E02
	for <qemu-devel@nongnu.org>; Mon,  5 Nov 2018 11:20:10 +0000 (UTC)
References: <20181030123526.26415-1-kchamart@redhat.com>
	<20181030123526.26415-3-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <10e3b401-92fc-f096-9e7e-b08223408ce9@redhat.com>
Date: Mon, 5 Nov 2018 12:20:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181030123526.26415-3-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] Deprecate HMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com

On 2018-10-30 13:35, Kashyap Chamarthy wrote:
> Since we're deprecating the QMP `cpu-add`, let's deprecate its HMP
> equivalent, too.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  hmp-commands.hx | 6 ++++--
>  hmp.c           | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index db0c681f74..ba71558c25 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1849,14 +1849,16 @@ ETEXI
>          .name       =3D "cpu-add",
>          .args_type  =3D "id:i",
>          .params     =3D "id",
> -        .help       =3D "add cpu",
> +        .help       =3D "add cpu (deprecated, use device_add instead)"=
,
>          .cmd        =3D hmp_cpu_add,
>      },
> =20
>  STEXI
>  @item cpu-add @var{id}
>  @findex cpu-add
> -Add CPU with id @var{id}
> +Add CPU with id @var{id}.  This command is deprecated, please
> ++use @code{device_add} instead. For details, refer to
> +'docs/cpu-hotplug.rst'.
>  ETEXI
> =20
>      {
> diff --git a/hmp.c b/hmp.c
> index 4975fa56b0..c3f3db7795 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2353,6 +2353,8 @@ void hmp_cpu_add(Monitor *mon, const QDict *qdict=
)
>      int cpuid;
>      Error *err =3D NULL;
> =20
> +    error_report("cpu_add is deprecated, please use device_add instead=
");
> +
>      cpuid =3D qdict_get_int(qdict, "id");
>      qmp_cpu_add(cpuid, &err);
>      hmp_handle_error(mon, &err);
>=20

I think you should also mention this explicitly in qemu-deprecated.texi,
too.

 Thomas
