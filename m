Received: from eggs.gnu.org ([2001:4830:134:3::10]:54581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVadX-0002CX-23
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVadT-0000nn-E9
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:10:03 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:32985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cVadT-0000mn-5P
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:09:59 -0500
Received: by mail-yw0-x241.google.com with SMTP id u68so16370346ywg.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 01:09:59 -0800 (PST)
MIME-Version: 1.0
References: <5884626f.5b2f6b0a.1bfff.3037@mx.google.com>
In-Reply-To: <5884626f.5b2f6b0a.1bfff.3037@mx.google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 23 Jan 2017 09:09:47 +0000
Message-ID: <CAJ+F1CKhvUs20FAQGeKf-FmC1xLa+J_sgxW6sULv8VzxuL-dMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix memory leak in set scanout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

On Sun, Jan 22, 2017 at 11:43 AM Li Qiang <liq3ea@gmail.com> wrote:

> From: Li Qiang <liqiang6-s@360.cn>
>
> In virtio_gpu_set_scanout function, when creating the 'rect'
> its refcount is set to 2, by pixman_image_create_bits and
> qemu_create_displaysurface_pixman function. This can lead
> a memory leak issues. This patch avoid this issue.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  hw/display/virtio-gpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 7a15c61..4aecea3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -608,6 +608,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>              cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>              return;
>          }
> +        pixman_image_unref(rect);
>          dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con,
> scanout->ds);
>      }
>
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
