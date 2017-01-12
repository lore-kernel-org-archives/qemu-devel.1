Received: from eggs.gnu.org ([2001:4830:134:3::10]:52011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRkJq-000168-D2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRkJn-0001HL-8r
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:41:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRkJn-0001H5-2T
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:41:47 -0500
Date: Thu, 12 Jan 2017 16:41:43 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112184143.GS3565@thinpad.lan.raisama.net>
References: <20170112182417.9548-1-lersek@redhat.com>
	<20170112182417.9548-5-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112182417.9548-5-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 wave 1 4/4] fw-cfg: bump "x-file-slots"
 to 0x20 for 2.9+ machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Gabriel L. Somlo" <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Jan 12, 2017 at 07:24:17PM +0100, Laszlo Ersek wrote:
> More precisely, the "x-file-slots" count is bumped for all machine types
> that:
> (a) use fw_cfg, and
> (b) are not versioned (hence migration is not expected to work for them
>     across QEMU releases anyway), or have version 2.9.
> 
> This affects machine types implemented in the following source files:
> 
> - "hw/arm/virt.c". The "virt-*" machine type is versioned, and the <= 2.8
>   versions already depend on HW_COMPAT_2_8 (see commit e353aac51b944).
>   Therefore adding the "x-file-slots" compat values to HW_COMPAT_2_8
>   suffices.
> 
> - "hw/i386/pc.c". The "pc-i440fx-*" (including "pc-*") and "pc-q35-*"
>   machine types are versioned. Modifying HW_COMPAT_2_8 is sufficient here
>   too (see commit "pc: Add 2.9 machine-types"). The "isapc" machtype is
>   not versioned. The "xenfv" machine type, which uses fw_cfg for direct
>   kernel booting, is also not versioned.
> 
> - "hw/ppc/mac_newworld.c". The "mac99" machine type is not versioned.
> 
> - "hw/ppc/mac_oldworld.c". The "g3beige" machine type is not versioned.
> 
> - "hw/sparc/sun4m.c". None of the 9 machine types defined in this file
>   appear versioned.
> 
> - "hw/sparc64/sun4u.c". None of the 3 machine types defined in this file
>   appear versioned.
> 
> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Acked-by: Gabriel Somlo <somlo@cmu.edu>
> Tested-by: Gabriel Somlo <somlo@cmu.edu>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
