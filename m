Received: from eggs.gnu.org ([209.51.188.92]:40249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2w6w-0006up-Dd
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2w6u-0003tR-Qb
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:55:18 -0400
References: <20190309181920.30553-1-philmd@redhat.com>
	<20190309181920.30553-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <33a2a087-1552-dbbc-ba62-470046e31ff9@vivier.eu>
Date: Sun, 10 Mar 2019 11:55:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190309181920.30553-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw/arm/virt: Remove null-check in
 virt_build_smbios()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 09/03/2019 19:19, Philippe Mathieu-Daudé wrote:
> Since commit 578f3c7b0835 ("arm: add fw_cfg to "virt" board",
> 2014-12-22), the machvirt_init() unconditionally creates the
> fw_cfg object.  Later, commit c30e15658b1b ("smbios: implement
> smbios support for mach-virt", 2015-09-07) added a superfluous
> null-check on it.
> Remove this superfluous check.
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Corrected commit reference (Laszlo)
> v3: Dropped 'Fixes:' (Markus)
> ---
>  hw/arm/virt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7f66ddad89..377e95a4cd 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1281,10 +1281,6 @@ static void virt_build_smbios(VirtMachineState *vms)
>      size_t smbios_tables_len, smbios_anchor_len;
>      const char *product = "QEMU Virtual Machine";
>  
> -    if (!vms->fw_cfg) {
> -        return;
> -    }
> -
>      if (kvm_enabled()) {
>          product = "KVM Virtual Machine";
>      }
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
