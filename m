Received: from eggs.gnu.org ([2001:4830:134:3::10]:44309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fmh49-0007PA-Sz
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fmh45-0004y9-TT
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:05:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fmh45-0004wa-M9
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:04:57 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-3-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f8d53890-79ea-f1f7-3110-386e7eea1c5a@redhat.com>
Date: Mon, 6 Aug 2018 17:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-3-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/34] tests/qgraph: rename qpci_init_pc
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> Rename qpci_init_pc in qpci_new_pc, since the function actually
> allocates a new QPCIBusPC and initialize it.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/e1000e-test.c       | 2 +-
>  tests/i440fx-test.c       | 2 +-
>  tests/ide-test.c          | 2 +-
>  tests/libqos/ahci.c       | 2 +-
>  tests/libqos/libqos-pc.c  | 2 +-
>  tests/libqos/pci-pc.c     | 2 +-
>  tests/libqos/pci-pc.h     | 9 ++++++++-
>  tests/q35-test.c          | 4 ++--
>  tests/rtl8139-test.c      | 2 +-
>  tests/sdhci-test.c        | 2 +-
>  tests/tco-test.c          | 2 +-
>  tests/usb-hcd-ehci-test.c | 2 +-
>  tests/vhost-user-test.c   | 2 +-
>  13 files changed, 21 insertions(+), 14 deletions(-)
> 
...
> diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
> index a9c1aceaa7..72b3eb46f5 100644
> --- a/tests/libqos/libqos-pc.c
> +++ b/tests/libqos/libqos-pc.c
> @@ -6,7 +6,7 @@
>  static QOSOps qos_ops = {
>      .init_allocator = pc_alloc_init_flags,
>      .uninit_allocator = pc_alloc_uninit,
> -    .qpci_init = qpci_init_pc,
> +    .qpci_init = qpci_pc_new,
>      .qpci_free = qpci_free_pc,
>      .shutdown = qtest_pc_shutdown,
>  };

I think you should also rename the "qpci_init" field to "qpci_new".
And as we have "qpci_free_pc", it should be "qpci_new_pc", and you
should do the same for qpci_init_spapr -> qpci_new_spapr.

Thanks,
Laurent
