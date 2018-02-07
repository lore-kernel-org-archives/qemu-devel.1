Received: from eggs.gnu.org ([2001:4830:134:3::10]:53173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVfy-0000tj-Cc
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVfu-00072L-G9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:46:38 -0500
Received: from mail-db5eur01hn0220.outbound.protection.outlook.com
	([104.47.2.220]:2596
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejVfu-000711-3p
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:46:34 -0500
Date: Wed, 7 Feb 2018 22:46:16 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207194616.GC19541@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-34-rkagan@virtuozzo.com>
	<aad05cf2-fe8e-5d0a-a47c-2be496af39da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad05cf2-fe8e-5d0a-a47c-2be496af39da@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 33/34] vmbus: add support for rom files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On Wed, Feb 07, 2018 at 12:18:38PM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > In order to leverage third-party drivers for VMBus devices in firmware
> > (in particular, there's a case with iPXE driver for hv-net in SeaBIOS
> > and OVMF), introduce an infrastructure to supply such drivers as option
> > ROMs.
> > 
> > To make it easy for the firmware to locate such ROMs, they are stored in
> > fw_cfg with names "vmbus/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.rom" for
> > default class ROMs (where xxx... is the class GUID) and
> > "vmbus/dev/yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy.rom" for per-device
> > (i.e. specified via .romfile property) ROMs (where yyy... is the device
> > instance GUID).
> > 
> > The format and the calling convention for the ROMs is out of scope for
> > this patch: QEMU doesn't try to interpret them.
> 
> Out of curiosity, do you have a SCSI driver for SeaBIOS and/or OVMF?

Yes, both, can be found at https://src.openvz.org/scm/up/seabios.git and
https://src.openvz.org/scm/up/edk2.git respectively (I mentioned that in
the cover letter).

Roman.
