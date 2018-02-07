Received: from eggs.gnu.org ([2001:4830:134:3::10]:39010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNkV-00068i-4N
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNkQ-0006Sx-7k
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:18:47 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNkP-0006SL-TT
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:18:42 -0500
Received: by mail-wr0-f176.google.com with SMTP id i56so585970wra.7
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:18:41 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-34-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aad05cf2-fe8e-5d0a-a47c-2be496af39da@redhat.com>
Date: Wed, 7 Feb 2018 12:18:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-34-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 33/34] vmbus: add support for rom files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> In order to leverage third-party drivers for VMBus devices in firmware
> (in particular, there's a case with iPXE driver for hv-net in SeaBIOS
> and OVMF), introduce an infrastructure to supply such drivers as option
> ROMs.
> 
> To make it easy for the firmware to locate such ROMs, they are stored in
> fw_cfg with names "vmbus/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.rom" for
> default class ROMs (where xxx... is the class GUID) and
> "vmbus/dev/yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy.rom" for per-device
> (i.e. specified via .romfile property) ROMs (where yyy... is the device
> instance GUID).
> 
> The format and the calling convention for the ROMs is out of scope for
> this patch: QEMU doesn't try to interpret them.

Out of curiosity, do you have a SCSI driver for SeaBIOS and/or OVMF?

Thanks,

Paolo
