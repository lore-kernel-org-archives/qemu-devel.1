Received: from eggs.gnu.org ([2001:4830:134:3::10]:37522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNdv-0001a7-TN
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNdq-00028R-W7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:11:59 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:38300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNdq-000285-Ob
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:11:54 -0500
Received: by mail-wr0-f170.google.com with SMTP id t94so569346wrc.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:11:54 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-26-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61ab4454-9aa3-7291-8b54-bcaee1f74bf0@redhat.com>
Date: Wed, 7 Feb 2018 12:11:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-26-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 25/34] scsi: add Hyper-V/VMBus SCSI
 controller
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
> +    blk_io_plug(d->conf.blk);
> +    if (scsi_req_enqueue(sreq)) {
> +        scsi_req_continue(sreq);
> +    }
> +    blk_io_unplug(d->conf.blk);

Is plug/unplug really useful?

Paolo
