Received: from eggs.gnu.org ([2001:4830:134:3::10]:48339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eOTLb-0004hc-T2
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eOTLX-0008WF-GO
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:02:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eOTLX-0008Uj-A8
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:02:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171211072110.9058-1-lprosek@redhat.com>
	<20171211072110.9058-5-lprosek@redhat.com>
Date: Mon, 11 Dec 2017 20:02:29 +0100
In-Reply-To: <20171211072110.9058-5-lprosek@redhat.com> (Ladi Prosek's message
	of "Mon, 11 Dec 2017 08:21:10 +0100")
Message-ID: <87vahdxf3u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 4/4] ivshmem: Disable irqfd on device
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, geoff@hostfission.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

Ladi Prosek <lprosek@redhat.com> writes:

> The effects of ivshmem_enable_irqfd() was not undone on device reset.
>
> This manifested as:
> ivshmem_add_kvm_msi_virq: Assertion `!s->msi_vectors[vector].pdev' failed.
>
> when irqfd was enabled before reset and then enabled again after reset, making
> ivshmem_enable_irqfd() run for the second time.
>
> To reproduce, run:
>
>   ivshmem-server
>
> and QEMU with:
>
>   -device ivshmem-doorbell,chardev=iv
>   -chardev socket,path=/tmp/ivshmem_socket,id=iv
>
> then install the Windows driver, at the time of writing available at:
>
> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem
>
> and crash-reboot the guest by inducing a BSOD.
>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
