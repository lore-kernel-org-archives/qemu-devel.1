Received: from eggs.gnu.org ([2001:4830:134:3::10]:45818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejV8G-0001Hy-GS
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejV8D-0008P9-B9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:11:48 -0500
Received: from mail-ve1eur01hn032e.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::32e]:10564
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejV8C-0008OC-Vt
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:11:45 -0500
Date: Wed, 7 Feb 2018 22:11:26 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207191126.GD18247@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-13-rkagan@virtuozzo.com>
	<ac191902-8f59-8064-f5cf-39bf79f4d035@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac191902-8f59-8064-f5cf-39bf79f4d035@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 12/34] hyperv: add synic event flag
 signaling
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

On Wed, Feb 07, 2018 at 11:58:58AM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > +/*
> > + * Set given event flag for a given sint on a given vcpu, and signal the sint.
> > + */
> > +int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno)
> 
> Any reason (e.g. something from the spec) not to spell "event" and
> "eventno" in full?

None beyond me being on the "shortest-comprehensible-name" camp :)

I thought "evt" was unambiguously parsed as "event", and "msg" as
"message".  Isn't it?

Thanks,
Roman.
