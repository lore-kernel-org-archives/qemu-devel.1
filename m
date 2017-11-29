Received: from eggs.gnu.org ([2001:4830:134:3::10]:44402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eK5rW-0003rm-Gy
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eK5rR-0006cl-H6
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:09:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eK5rR-0006bX-AT
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:09:25 -0500
Date: Wed, 29 Nov 2017 15:09:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171129170918.GA3037@localhost.localdomain>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<5A1E43A6.1010607@huawei.com>
	<20171129104122.GY3037@localhost.localdomain>
	<5A1EA0DB.60303@huawei.com> <20171129133524.GA2279@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129133524.GA2279@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "Longpeng (Mike)" <longpeng2@huawei.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, zhaoshenglong <zhaoshenglong@huawei.com>

On Wed, Nov 29, 2017 at 04:35:25PM +0300, Roman Kagan wrote:
> > On 2017/11/29 18:41, Eduardo Habkost wrote:
[...]
> > > IMO, the long term solution is to make Linux guests not misbehave
> > > when we stop lying about the L3 cache.  Maybe we could provide a
> > > "IPIs are expensive, please avoid them" hint in the KVM CPUID
> > > leaf?
> 
> We already have it, it's the hypervisor bit ;)  Seriously, I'm unaware
> of hypervisors where IPIs aren't expensive.

Sounds good enough to me, if we can convince the Linux kernel
maintainers that it should avoid IPIs under all hypervisors.

-- 
Eduardo
