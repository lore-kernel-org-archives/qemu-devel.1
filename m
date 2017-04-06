Received: from eggs.gnu.org ([2001:4830:134:3::10]:34937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cw4tC-0001x1-68
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cw4tB-0003pz-73
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:43:42 -0400
Date: Thu, 6 Apr 2017 12:43:36 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170406104336.GA28959@redhat>
References: <20170403114044.15762-1-lvivier@redhat.com>
	<ef70b4ab-f71a-8235-dc63-ae34097436af@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ef70b4ab-f71a-8235-dc63-ae34097436af@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] virtio-gpu: replace
 PIXMAN_* by PIXMAN_BE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Mon, Apr 03, 2017 at 09:28:02AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 04/03/2017 08:40 AM, Laurent Vivier wrote:
> > This avoids a "#ifdef HOST_WORDS_BIGENDIAN" and this is the purpose
> > of PIXMAN_BE_* macros.
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>

Reviewed-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>

>=20
> > ---
> >  hw/display/virtio-gpu.c | 35 ++++++++---------------------------
> >  1 file changed, 8 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 9b530ab..7befcef 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -258,41 +258,22 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
> >  static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_fo=
rmat)
> >  {
> >      switch (virtio_gpu_format) {
> > -#ifdef HOST_WORDS_BIGENDIAN
> >      case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> > -        return PIXMAN_b8g8r8x8;
> > +        return PIXMAN_BE_b8g8r8x8;
> >      case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
> > -        return PIXMAN_b8g8r8a8;
> > +        return PIXMAN_BE_b8g8r8a8;
> >      case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
> > -        return PIXMAN_x8r8g8b8;
> > +        return PIXMAN_BE_x8r8g8b8;
> >      case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
> > -        return PIXMAN_a8r8g8b8;
> > +        return PIXMAN_BE_a8r8g8b8;
> >      case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
> > -        return PIXMAN_r8g8b8x8;
> > +        return PIXMAN_BE_r8g8b8x8;
> >      case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
> > -        return PIXMAN_r8g8b8a8;
> > +        return PIXMAN_BE_r8g8b8a8;
> >      case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
> > -        return PIXMAN_x8b8g8r8;
> > +        return PIXMAN_BE_x8b8g8r8;
> >      case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
> > -        return PIXMAN_a8b8g8r8;
> > -#else
> > -    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> > -        return PIXMAN_x8r8g8b8;
> > -    case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
> > -        return PIXMAN_a8r8g8b8;
> > -    case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
> > -        return PIXMAN_b8g8r8x8;
> > -    case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
> > -        return PIXMAN_b8g8r8a8;
> > -    case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
> > -        return PIXMAN_x8b8g8r8;
> > -    case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
> > -        return PIXMAN_a8b8g8r8;
> > -    case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
> > -        return PIXMAN_r8g8b8x8;
> > -    case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
> > -        return PIXMAN_r8g8b8a8;
> > -#endif
> > +        return PIXMAN_BE_a8b8g8r8;
> >      default:
> >          return 0;
> >      }
> >=20
