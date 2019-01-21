Received: from eggs.gnu.org ([209.51.188.92]:47718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glVJn-0005bj-E0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 03:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glVAN-0000x1-5W
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 03:42:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1glVAM-0000vz-W3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 03:42:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so22328083wrw.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 00:42:46 -0800 (PST)
Date: Mon, 21 Jan 2019 09:42:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190121084241.wvqjkq2pfbnktqp4@steredhat>
References: <1547729344-3895-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1547729344-3895-5-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547729344-3895-5-git-send-email-lizhijian@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/4] i386: allow to load initrd below 4
 GB for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, philip.li@intel.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com, Richard Henderson <rth@twiddle.net>

On Thu, Jan 17, 2019 at 08:49:04PM +0800, Li Zhijian wrote:
> Since linux commit: cf8fa920cb42 ("i386: handle an initrd in highmem (version 2)")
> linux has supported initrd up to 4 GB, but the header field
> ramdisk_max is still set to 2 GB to avoid "possible bootloader bugs".
> 
> When use '-kernel vmlinux -initrd initrd.cgz' to launch a VM,
> the firmware(it could be linuxboot_dma.bin) helps to read initrd
> contents into guest memory(below ramdisk_max) and jump to kernel.
> that's similar with what bootloader does, like grub.
> 
> In addition, initrd_max is uint32_t simply because QEMU doesn't support
> the 64-bit boot protocol (specifically the ext_ramdisk_image field).
> 
> Therefore here just limit initrd_max to UINT32_MAX simply as well to
> allow initrd to be loaded below 4 GB.
> 
> NOTE: it's possible that linux protocol within [0x208, 0x20c]
> supports up to 4 GB initrd as well.
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> ---
> V6: update comments
> V5: udpate comments and changelog
> V3: correct grammar and check XLF_CAN_BE_LOADED_ABOVE_4G first (Michael S. Tsirkin)
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/i386/pc.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
