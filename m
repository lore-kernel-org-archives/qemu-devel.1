Received: from eggs.gnu.org ([209.51.188.92]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmHOe-0002Ua-3j
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmHFp-000548-Lf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:03:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmHFo-00052t-JK
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:03:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CD997F3E8
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:03:32 +0000 (UTC)
Date: Wed, 23 Jan 2019 12:03:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123120326.GD5771@work-vm>
References: <20181114133139.27346-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181114133139.27346-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vmstate: constify SaveVMHandlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Queued

> ---
>  include/migration/register.h | 2 +-
>  migration/savevm.c           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/migration/register.h b/include/migration/register.=
h
> index d287f4c317..3d0b9833c6 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -72,7 +72,7 @@ int register_savevm_live(DeviceState *dev,
>                           const char *idstr,
>                           int instance_id,
>                           int version_id,
> -                         SaveVMHandlers *ops,
> +                         const SaveVMHandlers *ops,
>                           void *opaque);
> =20
>  void unregister_savevm(DeviceState *dev, const char *idstr, void *opaq=
ue);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 236b242642..00a054721a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -303,7 +303,7 @@ typedef struct SaveStateEntry {
>      int section_id;
>      /* section id read from the stream */
>      int load_section_id;
> -    SaveVMHandlers *ops;
> +    const SaveVMHandlers *ops;
>      const VMStateDescription *vmsd;
>      void *opaque;
>      CompatEntry *compat;
> @@ -614,7 +614,7 @@ int register_savevm_live(DeviceState *dev,
>                           const char *idstr,
>                           int instance_id,
>                           int version_id,
> -                         SaveVMHandlers *ops,
> +                         const SaveVMHandlers *ops,
>                           void *opaque)
>  {
>      SaveStateEntry *se;
> --=20
> 2.19.1.708.g4ede3d42df
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
