Received: from eggs.gnu.org ([209.51.188.92]:39487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkDgx-0008Cw-6z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkDgv-0001wb-CH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:51:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkDgv-0001qY-5D
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:51:05 -0500
Date: Thu, 17 Jan 2019 17:50:52 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190117195052.GG14807@habkost.net>
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
Cc: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, zhijianx.li@intel.com, philip.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

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

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Michael, should this go through your tree?

-- 
Eduardo
