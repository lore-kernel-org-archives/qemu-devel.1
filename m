Received: from eggs.gnu.org ([2001:4830:134:3::10]:57247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVtY-0002Iq-UY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVtV-0006PY-Th
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:00:41 -0500
Received: from mail-db5eur01hn0225.outbound.protection.outlook.com
	([104.47.2.225]:21504
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejVtU-0006K7-OH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:00:37 -0500
Date: Wed, 7 Feb 2018 23:00:24 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207200024.GD19541@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-26-rkagan@virtuozzo.com>
	<61ab4454-9aa3-7291-8b54-bcaee1f74bf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ab4454-9aa3-7291-8b54-bcaee1f74bf0@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On Wed, Feb 07, 2018 at 12:11:50PM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > +    blk_io_plug(d->conf.blk);
> > +    if (scsi_req_enqueue(sreq)) {
> > +        scsi_req_continue(sreq);
> > +    }
> > +    blk_io_unplug(d->conf.blk);
> 
> Is plug/unplug really useful?

I guess no.  Must have been copied mindlessly from somewhere.

Thanks,
Roman.
