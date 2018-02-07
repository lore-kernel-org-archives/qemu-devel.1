Received: from eggs.gnu.org ([2001:4830:134:3::10]:47490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVFq-0006pj-1w
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVFm-0007Tm-Ta
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:19:38 -0500
Received: from mail-he1eur01hn0211.outbound.protection.outlook.com
	([104.47.0.211]:3034
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejVFm-0007Q3-5Z
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:19:34 -0500
Date: Wed, 7 Feb 2018 22:19:15 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207191915.GE18247@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-19-rkagan@virtuozzo.com>
	<4d74329a-8797-a476-60ff-539f95245131@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d74329a-8797-a476-60ff-539f95245131@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 18/34] hyperv: add support for
 KVM_HYPERV_EVENTFD
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

On Wed, Feb 07, 2018 at 12:01:41PM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > When setting up a notifier for Hyper-V event connection, attempt to use
> > the KVM-assisted one first, and fall back to userspace handling of the
> > hypercall if the kernel doesn't provide the requested feature.
> > 
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> 
> As before, I wouldn't mind dropping userspace SIGNAL_EVENT altogether.

That would mean not allowing vmbus stuff on a range of otherwise usable
kernels, including 4.14 which AFAIK has been declared LTS.
Note that HYPERV_EVENTFD hasn't even landed in the mainline kernel yet
(with any luck it'll make 4.16).

> It would probably end up in bitrot.

Like every compatibilty code...

Thanks,
Roman.
