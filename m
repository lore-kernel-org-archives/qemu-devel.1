Received: from eggs.gnu.org ([2001:4830:134:3::10]:46860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSs1q-0002ID-Al
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSs1n-0007Pn-1i
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSs1m-0007P9-RI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:40:06 -0400
Date: Wed, 5 Jul 2017 17:39:59 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2126188994.14377452.1499290799856.JavaMail.zimbra@redhat.com>
In-Reply-To: <04db742e-e15f-9743-caee-028b2f88aa0d@virtuozzo.com>
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1499263324-15184-4-git-send-email-anton.nefedov@virtuozzo.com>
	<8885ec44-52fc-6457-2d45-828e753aa9a0@redhat.com>
	<04db742e-e15f-9743-caee-028b2f88aa0d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/13] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, marcandre lureau <marcandre.lureau@redhat.com>, amit@kernel.org, mst@redhat.com


> So instead we'll need to use proper locks in each of the front-ends?

Hi,

the only front-end actually writing from multiple threads is the monitor.
You can skip everything else, as it will be locked on the "big QEMU lock".

Paolo

> Or do you mean that it can be skipped for the most of them? I don't know
> about all possible threading cases.
> e.g. for serial/virtio-serial? Will they always share the same thread
> with hmp/qmp driven chardev-change command? And won't yield and hotswap
> in the middle of some write handler?
> 
> /Anton
> 
