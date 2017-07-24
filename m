Received: from eggs.gnu.org ([2001:4830:134:3::10]:56473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZgsY-0002EK-JA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZgsV-0002iW-Dn
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZgsV-0002iD-74
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:10:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 495697AEBE
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 17:10:42 +0000 (UTC)
References: <20170720100046.4424-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48a5c773-8104-f589-a4d1-3fd9f4687e47@redhat.com>
Date: Mon, 24 Jul 2017 19:10:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170720100046.4424-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char-fd: remove useless chr pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 20/07/2017 12:00, Marc-Andr=C3=A9 Lureau wrote:
> Apparently unused since it was introduced in commit
> a29753f8aa79a34a324afebe340182a51a5aef11. Now, it can be trivially
> accessed by CHARDEV() of self.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char-fd.h | 2 +-
>  chardev/char-fd.c         | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
> index 55ae5b47b0..e7c2b176f9 100644
> --- a/include/chardev/char-fd.h
> +++ b/include/chardev/char-fd.h
> @@ -29,7 +29,7 @@
> =20
>  typedef struct FDChardev {
>      Chardev parent;
> -    Chardev *chr;
> +
>      QIOChannel *ioc_in, *ioc_out;
>      int max_size;
>  } FDChardev;
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index 1584a3de20..6a62a545f2 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -141,7 +141,6 @@ void qemu_chr_open_fd(Chardev *chr,
>      qio_channel_set_name(QIO_CHANNEL(s->ioc_out), name);
>      g_free(name);
>      qemu_set_nonblock(fd_out);
> -    s->chr =3D chr;
>  }
> =20
>  static void char_fd_class_init(ObjectClass *oc, void *data)
>=20

Queued for 2.10 as it's a trivial dead code removal.

Paolo
