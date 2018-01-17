Received: from eggs.gnu.org ([2001:4830:134:3::10]:57521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1eblKE-0003tJ-UD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1eblKB-0002DO-T5
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:52:11 -0500
Date: Wed, 17 Jan 2018 11:52:04 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180117105204.GA25971@toto>
References: <cover.1516144891.git.alistair.francis@xilinx.com>
	<d1049a00a3c00d8310584f7732492a2064a982ae.1516144891.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1049a00a3c00d8310584f7732492a2064a982ae.1516144891.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/9] microblaze: boot.c: Don't try to
 find NULL pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org

On Tue, Jan 16, 2018 at 03:22:20PM -0800, Alistair Francis wrote:
> Previously if no device tree was passed to microblaze_load_kernel() then
> qemu_find_file() would try to find a NULL pointer. To avoid this put a
> check around qemu_find_file().
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
> 
>  hw/microblaze/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index 457a08a2fe..35bfeda7aa 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -124,7 +124,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
>      kernel_cmdline = qemu_opt_get(machine_opts, "append");
>      dtb_arg = qemu_opt_get(machine_opts, "dtb");
>      /* default to pcbios dtb as passed by machine_init */
> -    if (!dtb_arg) {
> +    if (!dtb_arg && dtb_filename) {
>          filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
>      }
> 
> --
> 2.14.1
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
