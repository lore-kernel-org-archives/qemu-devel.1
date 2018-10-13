Received: from eggs.gnu.org ([2001:4830:134:3::10]:42096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBEzq-0003Yz-6p
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 04:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBEzn-0002Bx-3l
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 04:10:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gBEzm-0002B3-SO
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 04:09:59 -0400
References: <20181013055103.51451-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3df5813c-2a9e-968f-4f4a-475aedd69110@redhat.com>
Date: Sat, 13 Oct 2018 10:09:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181013055103.51451-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: edu: drop DO_UPCAST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: qemu-devel@nongnu.org

On 13/10/2018 07:51, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/misc/edu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 0687ffd343..cdcf550dd7 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -342,7 +342,7 @@ static void *edu_fact_thread(void *opaque)
>  
>  static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>  {
> -    EduState *edu = DO_UPCAST(EduState, pdev, pdev);
> +    EduState *edu = EDU(pdev);
>      uint8_t *pci_conf = pdev->config;
>  
>      pci_config_set_interrupt_pin(pci_conf, 1);
> @@ -365,7 +365,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>  
>  static void pci_edu_uninit(PCIDevice *pdev)
>  {
> -    EduState *edu = DO_UPCAST(EduState, pdev, pdev);
> +    EduState *edu = EDU(pdev);
>  
>      qemu_mutex_lock(&edu->thr_mutex);
>      edu->stopping = true;
> 

Queued, thanks.

Paolo
