Received: from eggs.gnu.org ([2001:4830:134:3::10]:38183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cimiM-0000LD-0t
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cimiK-0002fn-Sp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:41:34 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cimiK-0002eo-Gs
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:41:32 -0500
Received: by mail-lf0-x244.google.com with SMTP id r36so1636303lfi.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:41:32 -0800 (PST)
MIME-Version: 1.0
References: <1488289786-22754-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488289786-22754-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Feb 2017 18:41:20 +0000
Message-ID: <CAJ+F1C+3htdn9h9fP=Fj93HEXdirURnxorDJhG1DS_f+G960cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: add xres and yres properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Feb 28, 2017 at 6:45 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> So the default resolution is configurable.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/display/virtio-gpu.c        | 6 ++++--
>  include/hw/virtio/virtio-gpu.h | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 9b530ab..01bceb4 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1170,8 +1170,8 @@ static void virtio_gpu_device_realize(DeviceState
> *qdev, Error **errp)
>      virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
>                  g->config_size);
>
> -    g->req_state[0].width =3D 1024;
> -    g->req_state[0].height =3D 768;
> +    g->req_state[0].width =3D g->conf.xres;
> +    g->req_state[0].height =3D g->conf.yres;
>
>      if (virtio_gpu_virgl_enabled(g->conf)) {
>          /* use larger control queue in 3d mode */
> @@ -1291,6 +1291,8 @@ static Property virtio_gpu_properties[] =3D {
>      DEFINE_PROP_BIT("stats", VirtIOGPU, conf.flags,
>                      VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>  #endif
> +    DEFINE_PROP_UINT32("xres", VirtIOGPU, conf.xres, 1024),
> +    DEFINE_PROP_UINT32("yres", VirtIOGPU, conf.yres, 768),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> index f3a98a3..f3ffdce 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -72,6 +72,8 @@ struct virtio_gpu_conf {
>      uint64_t max_hostmem;
>      uint32_t max_outputs;
>      uint32_t flags;
> +    uint32_t xres;
> +    uint32_t yres;
>  };
>
>  struct virtio_gpu_ctrl_command {
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
