Received: from eggs.gnu.org ([209.51.188.92]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hIFrB-0005dQ-2k
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 13:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hIFe6-0004aB-2s
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 12:48:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hIFe5-0004ZG-Pj
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 12:48:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id b1so1836039wru.3
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 09:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190420091016.213160-1-fengli@smartx.com>
In-Reply-To: <20190420091016.213160-1-fengli@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 21 Apr 2019 18:48:37 +0200
Message-ID: <CAJ+F1CKz2=LpT1i1ES3MjfgBEeazqCWGdvaHfen1w-8UiBbdrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: fix bad vu_log_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Feng <lifeng1519@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, fengli@smartx.com

On Sat, Apr 20, 2019 at 11:11 AM Li Feng <lifeng1519@gmail.com> wrote:
>
> Mark dirty as page, the step of each call is 1.
>
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index e08d6c7b97..2689de6d1c 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -433,7 +433,7 @@ vu_log_write(VuDev *dev, uint64_t address, uint64_t l=
ength)
>      page =3D address / VHOST_LOG_PAGE;
>      while (page * VHOST_LOG_PAGE < address + length) {
>          vu_log_page(dev->log_table, page);
> -        page +=3D VHOST_LOG_PAGE;
> +        page +=3D 1;
>      }
>
>      vu_log_kick(dev);
> --
> 2.11.0
>
>


--=20
Marc-Andr=C3=A9 Lureau
