Received: from eggs.gnu.org ([2001:4830:134:3::10]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAWjV-00023s-Kk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAWjQ-00029e-NR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:17:25 -0400
References: <20170516001150.11508-1-f4bug@amsat.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c84e4ef1-586b-6bb8-0a29-52d14dd7bd81@redhat.com>
Date: Tue, 16 May 2017 09:17:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170516001150.11508-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] oslib: strip trailing '\n'
 from error_setg() string argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>

On 16/05/2017 02:11, Philippe Mathieu-Daud=C3=A9 wrote:
> spotted by Coccinelle script scripts/coccinelle/err-bad-newline.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  util/oslib-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4d9189e9ef..7ca02f0103 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -447,7 +447,7 @@ void os_mem_prealloc(int fd, char *area, size_t mem=
ory, int smp_cpus,
>      /* touch pages simultaneously */
>      if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
>          error_setg(errp, "os_mem_prealloc: Insufficient free host memo=
ry "
> -            "pages available to allocate guest RAM\n");
> +            "pages available to allocate guest RAM");
>      }
> =20
>      ret =3D sigaction(SIGBUS, &oldact, NULL);
>=20
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
