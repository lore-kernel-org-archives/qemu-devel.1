Received: from eggs.gnu.org ([2001:4830:134:3::10]:41274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRNKL-00052M-CS
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 14:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRNKK-0007y9-Gj
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 14:13:21 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:41597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRNKK-0007xq-Av
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 14:13:20 -0500
Received: by mail-it0-x244.google.com with SMTP id x28so4002567ita.0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 11:13:20 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171217125457.3429-5-marcel@redhat.com>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-5-marcel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 16:13:18 -0300
Message-ID: <CAAdtpL5XgR5wvJzfLHdtdR00fm9VPU50yycG-pdeL4i8-9Hsmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Yuval Shaia <yuval.shaia@oracle.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi Marcel, Yuval,

On Sun, Dec 17, 2017 at 9:54 AM, Marcel Apfelbaum <marcel@redhat.com> wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
>
> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
> It works with its Linux Kernel driver AS IS, no need for any special guest
> modifications.
>
> While it complies with the VMware device, it can also communicate with bare
> metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
> can work with Soft-RoCE (rxe).
>
> It does not require the whole guest RAM to be pinned allowing memory
> over-commit and, even if not implemented yet, migration support will be
> possible with some HW assistance.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
[...]
>  28 files changed, 5132 insertions(+), 4 deletions(-)
>  create mode 100644 hw/net/pvrdma/pvrdma.h
>  create mode 100644 hw/net/pvrdma/pvrdma_backend.c
>  create mode 100644 hw/net/pvrdma/pvrdma_backend.h
>  create mode 100644 hw/net/pvrdma/pvrdma_backend_defs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_cmd.c
>  create mode 100644 hw/net/pvrdma/pvrdma_defs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_dev_api.h
>  create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.c
>  create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.h
>  create mode 100644 hw/net/pvrdma/pvrdma_ib_verbs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_main.c
>  create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.c
>  create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.h
>  create mode 100644 hw/net/pvrdma/pvrdma_ring.h
>  create mode 100644 hw/net/pvrdma/pvrdma_rm.c
>  create mode 100644 hw/net/pvrdma/pvrdma_rm.h
>  create mode 100644 hw/net/pvrdma/pvrdma_rm_defs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_types.h
>  create mode 100644 hw/net/pvrdma/pvrdma_utils.c
>  create mode 100644 hw/net/pvrdma/pvrdma_utils.h
>  create mode 100644 hw/net/pvrdma/trace-events
[...]

Since we already have a hw/xenpv/ directory, can we place these files
into hw/vmwarepv/ rather than hw/net/pvrdma/?

A smarter move might be to create a hw/pv/ dir and have hw/pv/{xen,vmware}.

Regards,

Phil.
