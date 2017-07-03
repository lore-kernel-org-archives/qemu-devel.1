Received: from eggs.gnu.org ([2001:4830:134:3::10]:53210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dRxru-00016c-IM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dRxrq-0008Tq-7S
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dRxrq-0008Tb-0g
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:42:06 -0400
Date: Mon, 3 Jul 2017 11:42:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170703114200.67a39ecb@nial.brq.redhat.com>
In-Reply-To: <1498745240-30658-4-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-4-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv7 3/6] fw_cfg: switch fw_cfg_find() to
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

On Thu, 29 Jun 2017 15:07:17 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> This will enable the fw_cfg device to be placed anywhere within the QOM tree
> regardless of its machine location.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 99bdbc2..0fe7404 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1017,7 +1017,7 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
>  
>  FWCfgState *fw_cfg_find(void)
>  {
> -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
> +    return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
I insist on using ambiguous argument

see why it's needed
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg460692.html

>  }
>  
>  static void fw_cfg_class_init(ObjectClass *klass, void *data)
