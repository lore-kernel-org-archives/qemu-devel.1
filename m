Received: from eggs.gnu.org ([2001:4830:134:3::10]:40673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNdxv-0002gM-N0
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNdxs-0003um-KG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:43:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529062838.20556-1-clg@kaod.org>
	<20180529062838.20556-5-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd33aebe-d1f1-20ff-45ae-642c3906edfe@amsat.org>
Date: Tue, 29 May 2018 09:42:55 -0300
MIME-Version: 1.0
In-Reply-To: <20180529062838.20556-5-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] slirp/ncsi: fix "Get Version ID"
 payload length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 03:28 AM, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  slirp/ncsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
> index d12ba3e494b0..02d0e9def3e8 100644
> --- a/slirp/ncsi.c
> +++ b/slirp/ncsi.c
> @@ -60,7 +60,7 @@ static const struct ncsi_rsp_handler {
>          { NCSI_PKT_RSP_EGMF,    4, NULL },
>          { NCSI_PKT_RSP_DGMF,    4, NULL },
>          { NCSI_PKT_RSP_SNFC,    4, NULL },
> -        { NCSI_PKT_RSP_GVI,    36, NULL },
> +        { NCSI_PKT_RSP_GVI,    40, NULL },

sizeof(ncsi_rsp_gvi_pkt) - sizeof(ncsi_rsp_pkt_hdr) = 40, ok.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          { NCSI_PKT_RSP_GC,     32, ncsi_rsp_handler_gc },
>          { NCSI_PKT_RSP_GP,     -1, NULL },
>          { NCSI_PKT_RSP_GCPS,  172, NULL },
> 
