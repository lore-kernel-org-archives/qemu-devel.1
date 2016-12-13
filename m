Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGkOx-00030t-8i
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGkOs-0006ug-Of
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:33:39 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cGkOs-0006uW-KK
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:33:34 -0500
Received: by mail-io0-f169.google.com with SMTP id 136so45506657iou.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 02:33:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <58188cae.4a6ec20a.3d2d1.aff2@mx.google.com>
References: <58188cae.4a6ec20a.3d2d1.aff2@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Dec 2016 18:32:33 +0800
Message-ID: <CAKXe6SJDJNTJG24pT3KLpjH_yTjMbLW1B9pjDJi1rzcXqb=Mig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix information leak in capset
 get dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

Ping!

2016-11-01 20:37 GMT+08:00 Li Qiang <liq3ea@gmail.com>:

> From: Li Qiang <liqiang6-s@360.cn>
>
> In virgl_cmd_get_capset function, it uses g_malloc to allocate
> a response struct to the guest. As the 'resp'struct hasn't been full
> initialized it will lead the 'resp->padding' field to the guest.
> Use g_malloc0 to avoid this.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/display/virtio-gpu-3d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 23f39de..d98b140 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -371,7 +371,7 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>
>      virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
>                                 &max_size);
> -    resp = g_malloc(sizeof(*resp) + max_size);
> +    resp = g_malloc0(sizeof(*resp) + max_size);
>
>      resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
>      virgl_renderer_fill_caps(gc.capset_id,
> --
> 1.8.3.1
>
>
