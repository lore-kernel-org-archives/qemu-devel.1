Received: from eggs.gnu.org ([209.51.188.92]:49337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLlf7-0002PZ-Au
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLlf4-0003TZ-6o
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:36:25 -0400
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<002f222d86322a66276de39cb29796acffe384c1.1556666645.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3ff5539c-ee8c-336e-9a15-182834f1686c@vivier.eu>
Date: Wed, 1 May 2019 11:35:50 +0200
MIME-Version: 1.0
In-Reply-To: <002f222d86322a66276de39cb29796acffe384c1.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Le 01/05/2019 à 01:28, Alistair Francis a écrit :
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘strncpy’,
>     inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  util/qemu-sockets.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9705051690..8c3322958f 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -829,7 +829,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>      struct sockaddr_un un;
>      int sock, fd;
>      char *pathbuf = NULL;
> -    const char *path;
> +    const char *path QEMU_NONSTRING;

Do we need this with memcpy()?

Thanks,
Laurent
