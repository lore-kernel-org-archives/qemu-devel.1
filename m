Received: from eggs.gnu.org ([2001:4830:134:3::10]:51178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVXR-0003sI-5L
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVXM-0007Hm-7v
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:37:49 -0500
Received: from mail-ve1eur01hn0242.outbound.protection.outlook.com
	([104.47.1.242]:36009
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejVXL-0007Gs-Tq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:37:44 -0500
Date: Wed, 7 Feb 2018 22:37:27 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207193727.GA19541@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-23-rkagan@virtuozzo.com>
	<90a77ba5-1a16-a05e-f7b8-b409500dcc30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a77ba5-1a16-a05e-f7b8-b409500dcc30@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 22/34] i386: Hyper-V VMBus ACPI DSDT
 entry
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

On Wed, Feb 07, 2018 at 12:05:23PM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > From: Andrey Smetanin <asmetanin@virtuozzo.com>
> > 
> > Guest OS uses ACPI to discover vmbus presence.  Add a corresponding
> > entry to DSDT in case vmbus has been enabled.
> > 
> > Experimentally Windows guests were found to require this entry to
> > include two IRQ resources, so this patch adds two semi-arbitrarily
> > chosen ones (7 and 13).  This results, in particular, in parallel port
> > conflicting with vmbus.
> > 
> > TODO: discover and use spare IRQs to avoid conflicts.
> 
> Could they be level-triggered IRQs?

Dunno, I'll have to experiment.  There appears to be no *use* for them,
only their presence seems to matter.

> If so you could reuse 10 and 11
> which are used by PCI INTx.  Otherwise, the parallel port conflict is
> not a huge deal.
> 
> > Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
> 
> Somewhat messy SoB chain. :)

Yes that happens when the patches circulate within the team before being
posted outside.  Will fix when submitting.

Thanks,
Roman.
