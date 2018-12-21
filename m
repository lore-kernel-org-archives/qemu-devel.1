Received: from eggs.gnu.org ([2001:4830:134:3::10]:49733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLhS-00046d-M5
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaLhP-0005ov-C8
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gaLhP-0005o5-4s
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:22:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 394AEB0837
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:22:46 +0000 (UTC)
Date: Fri, 21 Dec 2018 15:22:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181221152244.7d976b04@redhat.com>
In-Reply-To: <20181221090410.27250-6-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 05/28] hw: remove SET_MACHINE_COMPAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On Fri, 21 Dec 2018 13:03:47 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> No longer needed.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/boards.h | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f02d5a1bbd..f743d9d4a4 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -287,16 +287,4 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
> =20
> -#define SET_MACHINE_COMPAT(m, compat) \
> -    do {                              \
> -        int i;                        \
> -        if (!m->compat_props) { \
> -            m->compat_props =3D g_array_new(false, false, sizeof(void *)=
); \
> -        } \
> -        for (i =3D 0; i < G_N_ELEMENTS(compat); i++) {          \
> -            GlobalProperty *prop =3D &compat[i];          \
> -            g_array_append_val(m->compat_props, prop); \
> -        }                                              \
> -    } while (0)
> -
>  #endif
