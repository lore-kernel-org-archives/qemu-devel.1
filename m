Received: from eggs.gnu.org ([2001:4830:134:3::10]:45654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1emGG1-0002rH-2N
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1emGG0-00028c-7y
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:55:13 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1emGG0-000284-19
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:55:12 -0500
Received: by mail-wr0-x241.google.com with SMTP id u15so2712156wrg.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 01:55:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-2-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-2-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Feb 2018 10:55:10 +0100
Message-ID: <CAJ+F1CKPuytP6YDeVNP+duKcfyJGtA1bVY7efN8rJuo7bB2qgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/30] util/cutils: extract byte-based
 definitions into a new header: "qemu/cunits.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU <qemu-devel@nongnu.org>

On Thu, Feb 15, 2018 at 5:28 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> (added in 076b35b5a56)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Or osdep.h?

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/qemu/cunits.h | 11 +++++++++++
>  include/qemu/cutils.h |  8 +-------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>  create mode 100644 include/qemu/cunits.h
>
> diff --git a/include/qemu/cunits.h b/include/qemu/cunits.h
> new file mode 100644
> index 0000000000..c0207b7611
> --- /dev/null
> +++ b/include/qemu/cunits.h
> @@ -0,0 +1,11 @@
> +#ifndef QEMU_CUNITS_H
> +#define QEMU_CUNITS_H
> +
> +#define K_BYTE     (1ULL << 10)
> +#define M_BYTE     (1ULL << 20)
> +#define G_BYTE     (1ULL << 30)
> +#define T_BYTE     (1ULL << 40)
> +#define P_BYTE     (1ULL << 50)
> +#define E_BYTE     (1ULL << 60)
> +
> +#endif
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index f0878eaafa..01184a70b3 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -2,6 +2,7 @@
>  #define QEMU_CUTILS_H
>
>  #include "qemu/fprintf-fn.h"
> +#include "qemu/cunits.h"
>
>  /**
>   * pstrcpy:
> @@ -143,13 +144,6 @@ int qemu_strtosz(const char *nptr, char **end, uint6=
4_t *result);
>  int qemu_strtosz_MiB(const char *nptr, char **end, uint64_t *result);
>  int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result);
>
> -#define K_BYTE     (1ULL << 10)
> -#define M_BYTE     (1ULL << 20)
> -#define G_BYTE     (1ULL << 30)
> -#define T_BYTE     (1ULL << 40)
> -#define P_BYTE     (1ULL << 50)
> -#define E_BYTE     (1ULL << 60)
> -
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>
> --
> 2.16.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
