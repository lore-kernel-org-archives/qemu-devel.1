Received: from eggs.gnu.org ([2001:4830:134:3::10]:54255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB27A-0005kQ-4o
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB276-0006fe-Uh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:24:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gB276-0006f3-O6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:24:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so13827624wmc.5
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:24:39 -0700 (PDT)
References: <153936155938.28040.11513367417790075721.stgit@gimli.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d2698d9d-51e0-764d-a699-367e54508dd4@redhat.com>
Date: Fri, 12 Oct 2018 20:24:37 +0200
MIME-Version: 1.0
In-Reply-To: <153936155938.28040.11513367417790075721.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Makefile: Install new vgabios binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 12/10/2018 18:26, Alex Williamson wrote:
> Difficult to make use of if not installed
> 
> Fixes: cd1bfd5ef336 ("seabios: update bios and vgabios binaries")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
>  Makefile |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index 1144d6e3ba0e..f2947186a4c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -802,6 +802,7 @@ bepo    cz
>  ifdef INSTALL_BLOBS
>  BLOBS=bios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
>  vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
> +vgabios-ramfb.bin vgabios-bochs-display.bin \
>  ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin \
>  pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
>  pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
> 
> 
