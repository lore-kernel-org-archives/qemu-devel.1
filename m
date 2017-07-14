Received: from eggs.gnu.org ([2001:4830:134:3::10]:43918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW2v5-0008HR-TP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW2v1-0003W3-UL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:54:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW2v1-0003Vp-Nx
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:54:15 -0400
Date: Fri, 14 Jul 2017 17:53:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170714175350.40954793@nial.brq.redhat.com>
In-Reply-To: <1500025208-14827-2-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500025208-14827-2-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv9 1/3] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

On Fri, 14 Jul 2017 10:40:06 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> This will enable the fw_cfg device to be placed anywhere within the QOM tree
> regardless of its machine location.
> 
> Note that we also add a comment to document the behaviour that we return NULL to
> indicate failure where either no fw_cfg device or multiple fw_cfg devices are
> found.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/nvram/fw_cfg.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 99bdbc2..ac52b50 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1017,7 +1017,8 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
>  
>  FWCfgState *fw_cfg_find(void)
>  {
> -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
> +    /* Returns NULL unless there is exactly one fw_cfg device */
> +    return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
>  }
>  
>  static void fw_cfg_class_init(ObjectClass *klass, void *data)
