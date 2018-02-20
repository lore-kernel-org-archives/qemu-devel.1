Received: from eggs.gnu.org ([2001:4830:134:3::10]:33844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoCgg-00078W-Tu
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoCgd-0002hV-Mt
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:30:46 -0500
Date: Tue, 20 Feb 2018 18:30:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180220183022.GQ6021@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<7fa4ce574074b3baf702b628a7e1fce647305ce1.1519150239.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fa4ce574074b3baf702b628a7e1fce647305ce1.1519150239.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 2/2] pc-bios: Added u-boot-sam460 firmware
 binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Feb 20, 2018 at 06:57:43PM +0100, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  Makefile                           |   2 +-
>  pc-bios/u-boot-sam460-20100605.bin | Bin 0 -> 524288 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  create mode 100755 pc-bios/u-boot-sam460-20100605.bin
> 
> diff --git a/Makefile b/Makefile
> index 6434d6c..b0c16b3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -661,7 +661,7 @@ multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin \
>  s390-ccw.img s390-netboot.img \
>  spapr-rtas.bin slof.bin skiboot.lid \
>  palcode-clipper \
> -u-boot.e500 \
> +u-boot.e500 u-boot-sam460-20100605.bin \
>  qemu_vga.ndrv \
>  hppa-firmware.img
>  else
> diff --git a/pc-bios/u-boot-sam460-20100605.bin b/pc-bios/u-boot-sam460-20100605.bin
> new file mode 100755

IIUC, you also need to provide glue in roms/Makefile to build the
u-boot-sam460-20100605.bin from the submodule content. Presumably
you can largely copy what's done for u-boot.e500 there.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
