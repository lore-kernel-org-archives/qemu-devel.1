Received: from eggs.gnu.org ([209.51.188.92]:35114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3KKO-00036m-IN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3KKN-0006v2-Ns
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3KKN-0006tl-8r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:46:47 -0400
References: <20190311091256.18385-1-david.abdurachmanov@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a511bc68-f700-a155-0fbd-51ed30b2a0dc@redhat.com>
Date: Mon, 11 Mar 2019 13:46:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190311091256.18385-1-david.abdurachmanov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] riscv/Kconfig: enable PCI_DEVICES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Abdurachmanov <david.abdurachmanov@gmail.com>, qemu-devel@nongnu.org, alistair.francis@wdc.com, palmer@sifive.com, Paolo Bonzini <pbonzini@redhat.com>

On 11/03/2019 10.12, David Abdurachmanov wrote:
> Re-enable PCI_DEVICES for RISC-V.
> The patch is based on other <arch>/Kconfig.
> 
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> Fixes: 82a230d5a303 ("riscv-softmmu.mak: replace CONFIG_* with Kconfig "select" directives")
> ---
>  hw/riscv/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e0ee3043a6..8c7fc1f31d 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -26,6 +26,9 @@ config SPIKE
>  
>  config RISCV_VIRT
>      bool
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
> +    select PCI
>      select HART
>      select SERIAL
>      select VIRTIO_MMIO
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
