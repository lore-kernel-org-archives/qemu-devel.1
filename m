Received: from eggs.gnu.org ([2001:4830:134:3::10]:39392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAZvH-0001m3-33
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAZvC-0007Yd-4Y
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:18:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAZvB-0007Y6-Tb
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:18:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so9149036wmf.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:18:29 -0700 (PDT)
References: <1539260043-4264-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <309b17e0-0353-86b6-ed4f-e80b8a4ea384@redhat.com>
Date: Thu, 11 Oct 2018 14:18:21 +0200
MIME-Version: 1.0
In-Reply-To: <1539260043-4264-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] i440fx: use ARRAY_SIZE for pam_regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 11/10/2018 14:14, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org 
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Good cleanup!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/pci-host/piix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e608347c1..230d5d2ea3 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -142,7 +142,7 @@ static void i440fx_update_memory_mappings(PCII440FXState *d)
>      PCIDevice *pd = PCI_DEVICE(d);
>  
>      memory_region_transaction_begin();
> -    for (i = 0; i < 13; i++) {
> +    for (i = 0; i < ARRAY_SIZE(d->pam_regions); i++) {
>          pam_update(&d->pam_regions[i], i,
>                     pd->config[I440FX_PAM + (DIV_ROUND_UP(i, 2))]);
>      }
> @@ -401,7 +401,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>  
>      init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
>               &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
> -    for (i = 0; i < 12; ++i) {
> +    for (i = 0; i < ARRAY_SIZE(f->pam_regions) - 1; ++i) {
>          init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
>                   &f->pam_regions[i+1], PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE,
>                   PAM_EXPAN_SIZE);
> 
