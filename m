Received: from eggs.gnu.org ([2001:4830:134:3::10]:40578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg5Xf-0004kO-60
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg5Xd-0006eu-LA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:11:23 -0500
MIME-Version: 1.0
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-2-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-2-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 08:11:08 +0000
Message-ID: <CAJ+F1CLHy-gH4vfKGpgp441gdxtwvmasbKL4kjrrtbsfuGXGBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/8] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org

On Tue, Feb 21, 2017 at 6:49 AM Eric Blake <eblake@redhat.com> wrote:

> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Comparison symbol is misused. It may lead to memory corruption.
> Introduced in commit 7d3123e.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
> [eblake: add CVE details]
> Signed-off-by: Eric Blake <eblake@redhat.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  nbd/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index ffb0743..0d16cd1 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size)
>      char small[1024];
>      char *buffer;
>
> -    buffer =3D sizeof(small) < size ? small : g_malloc(MIN(65536, size))=
;
> +    buffer =3D sizeof(small) > size ? small : g_malloc(MIN(65536, size))=
;
>      while (size > 0) {
>          ssize_t count =3D read_sync(ioc, buffer, MIN(65536, size));
>
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
