Received: from eggs.gnu.org ([2001:4830:134:3::10]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ceqUZ-0005FK-Dz
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ceqUY-0000Pf-Hn
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:55:03 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ceqUY-0000P9-Ce
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:55:02 -0500
Received: by mail-ot0-x244.google.com with SMTP id l26so5740819ota.3
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 13:55:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170214185225.7994-5-ppandit@redhat.com>
References: <20170214185225.7994-1-ppandit@redhat.com>
	<20170214185225.7994-5-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Feb 2017 13:54:31 -0800
Message-ID: <CAKmqyKPUqrSH27vVnsn=oGRkaYQ_5X1tGJpc13A_wS1AdVV-HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 4/4] sd: sdhci: Remove block count
 enable check in single block transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, Feb 14, 2017 at 10:52 AM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In SDHCI protocol, the 'Block count enable' bit of the Transfer
> Mode register is relevant only in multi block transfers. We need
> not check it in single block transfers.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/sd/sdhci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 8ae75fe..05558d3 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -570,7 +570,6 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>  }
>
>  /* single block SDMA transfer */
> -
>  static void sdhci_sdma_transfer_single_block(SDHCIState *s)
>  {
>      int n;
> @@ -589,10 +588,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
>              sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
>          }
>      }
> -
> -    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> -        s->blkcnt--;
> -    }
> +    s->blkcnt--;
>
>      sdhci_end_transfer(s);
>  }
> --
> 2.9.3
>
