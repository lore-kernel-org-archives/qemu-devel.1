Received: from eggs.gnu.org ([209.51.188.92]:39270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gjrHg-0001Su-E3
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gjrHe-0003cl-Ip
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:55:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gjrHe-0003Xr-4O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:55:30 -0500
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-3-git-send-email-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ecdb9ce5-278d-5ee0-3d7a-dff108cb9849@redhat.com>
Date: Wed, 16 Jan 2019 20:55:23 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] tests/libqos: rename qpci_init_pc and
 qpci_init_spapr functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

On 15/01/2019 19:19, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> Rename qpci_init_pc in qpci_pc_new and qpci_init_spapr in qpci_spapr_new,
> since theese function actually allocate a new pci struct and initialize it.
> Changed QOSOps field name from qpci_init to qpci_new.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/e1000e-test.c         | 2 +-
>   tests/i440fx-test.c         | 2 +-
>   tests/ide-test.c            | 2 +-
>   tests/libqos/ahci.c         | 2 +-
>   tests/libqos/libqos-pc.c    | 2 +-
>   tests/libqos/libqos-spapr.c | 2 +-
>   tests/libqos/libqos.c       | 2 +-
>   tests/libqos/libqos.h       | 2 +-
>   tests/libqos/pci-pc.c       | 2 +-
>   tests/libqos/pci-pc.h       | 9 ++++++++-
>   tests/libqos/pci-spapr.c    | 2 +-
>   tests/libqos/pci-spapr.h    | 2 +-
>   tests/q35-test.c            | 4 ++--
>   tests/rtl8139-test.c        | 2 +-
>   tests/sdhci-test.c          | 2 +-
>   tests/tco-test.c            | 2 +-
>   tests/usb-hcd-ehci-test.c   | 2 +-
>   tests/vhost-user-test.c     | 2 +-
>   18 files changed, 26 insertions(+), 19 deletions(-)

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
