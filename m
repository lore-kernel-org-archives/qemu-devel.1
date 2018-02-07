Received: from eggs.gnu.org ([2001:4830:134:3::10]:49502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVQZ-0004td-Or
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVQS-0007bR-7A
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:30:43 -0500
Received: from mail-db5eur01hn0216.outbound.protection.outlook.com
	([104.47.2.216]:51200
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejVQR-0007a1-Lp
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:30:36 -0500
Date: Wed, 7 Feb 2018 22:30:18 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207192823.GF18247@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-22-rkagan@virtuozzo.com>
	<f7e37a67-b1fc-c4cf-a7d1-a958b3b84f5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e37a67-b1fc-c4cf-a7d1-a958b3b84f5c@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 21/34] vmbus: build configuration
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

On Wed, Feb 07, 2018 at 12:04:01PM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
> > 
> > Add option to configure and makefiles to enable building vmbus support
> > (default to "on" on Linux and "off" otherwise).
> 
> Maybe default to on if KVM is supported?  Could it just be
> 
> CONFIG_VMBUS=$(CONFIG_KVM)
> 
> in default-configs/ instead of having a configure option?

Then there won't be an obvious way to turn it off, will there be?

> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> 
> Missing Evgeny's SoB.

Ouch.  Will fix when submitting for inclusion.

Thanks,
Roman.
