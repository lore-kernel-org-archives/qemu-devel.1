Received: from eggs.gnu.org ([2001:4830:134:3::10]:48941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHmB-0002O8-Di
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHmA-0005C3-HY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:57:27 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306134402.997-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b55b5536-5db9-a396-a35e-12b1218b37aa@amsat.org>
Date: Tue, 6 Mar 2018 15:57:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180306134402.997-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] misc,
 ide: remove use of HWADDR_PRIx in trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 03/06/2018 10:44 AM, Daniel P. Berrangé wrote:
> The trace events all use a uint64_t data type, so should be using the
> corresponding PRIx64 format, not HWADDR_PRIx which is intended for use
> with the 'hwaddr' type.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ide/trace-events  | 4 ++--
>  hw/misc/trace-events | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
> index 0c39cabe72..5c0e59ec42 100644
> --- a/hw/ide/trace-events
> +++ b/hw/ide/trace-events
> @@ -108,8 +108,8 @@ ahci_dma_prepare_buf_fail(void *s, int port) "ahci(%p)[%d]: sglist population fa
>  ahci_dma_rw_buf(void *s, int port, int l) "ahci(%p)[%d] len=0x%x"
>  ahci_cmd_done(void *s, int port) "ahci(%p)[%d]: cmd done"
>  ahci_reset(void *s) "ahci(%p): HBA reset"
> -allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): read a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
> -allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): write a=%p addr=0x%"HWADDR_PRIx" val=0x%"PRIx64", size=%d"
> +allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): read a=%p addr=0x%"PRIx64" val=0x%"PRIx64", size=%d"
> +allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, unsigned size) "ahci(%p): write a=%p addr=0x%"PRIx64" val=0x%"PRIx64", size=%d"
>  
>  # Warning: Verbose
>  handle_reg_h2d_fis_dump(void *s, int port, const char *fis) "ahci(%p)[%d]: %s"
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 562d9ed005..ec5a9f0da1 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -69,13 +69,13 @@ mps2_fpgaio_reset(void) "MPS2 FPGAIO: reset"
>  mps2_fpgaio_leds(char led1, char led0) "MPS2 FPGAIO LEDs: %c%c"
>  
>  # hw/misc/msf2-sysreg.c
> -msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sysreg write: addr 0x%08" HWADDR_PRIx " data 0x%" PRIx32 " prev 0x%" PRIx32
> -msf2_sysreg_read(uint64_t offset, uint32_t val) "msf2-sysreg read: addr 0x%08" HWADDR_PRIx " data 0x%08" PRIx32
> +msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sysreg write: addr 0x%08" PRIx64 " data 0x%" PRIx32 " prev 0x%" PRIx32
> +msf2_sysreg_read(uint64_t offset, uint32_t val) "msf2-sysreg read: addr 0x%08" PRIx64 " data 0x%08" PRIx32
>  msf2_sysreg_write_pll_status(void) "Invalid write to read only PLL status register"
>  
>  #hw/misc/imx7_gpr.c
> -imx7_gpr_read(uint64_t offset) "addr 0x%08" HWADDR_PRIx
> -imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" HWADDR_PRIx "value 0x%08" HWADDR_PRIx
> +imx7_gpr_read(uint64_t offset) "addr 0x%08" PRIx64
> +imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx64
>  
>  # hw/misc/mos6522.c
>  mos6522_set_counter(int index, unsigned int val) "T%d.counter=%d"
> 
