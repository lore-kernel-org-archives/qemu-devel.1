Received: from eggs.gnu.org ([2001:4830:134:3::10]:46217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbKSf-00046J-83
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbKSc-0003hO-3z
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:06:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cbKSb-0003fF-V9
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:06:30 -0500
Date: Wed, 8 Feb 2017 10:36:20 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAKmqyKO4naDbnYVV8eBkXJ+TBxxjwCTUN8D=VqAu3e2K=Zre6w@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702081034380.17258@wniryva>
References: <20170131122416.10284-1-ppandit@redhat.com>
	<CAFEAcA_GoD3h2tfM7R5mBQPV9V4bCkA5oKL9EYXiaGq2Gbd3DQ@mail.gmail.com>
	<alpine.LFD.2.20.1702080036340.11236@wniryva>
	<CAKmqyKO4naDbnYVV8eBkXJ+TBxxjwCTUN8D=VqAu3e2K=Zre6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 0/2] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jiang Xin <jiangxin1@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>, Wjjzhang <wjjzhang@tencent.com>

+-- On Tue, 7 Feb 2017, Alistair Francis wrote --+
| > ===
| > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
| > index d921423..7f3d547 100644
| > --- a/hw/sd/sdhci.c
| > +++ b/hw/sd/sdhci.c
| > @@ -1019,7 +1019,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val,
| > unsigned size)
| >          /* Writing to last byte of sdmasysad might trigger transfer */
| >          if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt
| > &&
| >                  s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
| > -            sdhci_sdma_transfer_multi_blocks(s);
| > +            if (!(s->trnmod & SDHC_TRNS_MULTI)) {
| > +                sdhci_sdma_transfer_single_block(s);
| > +            } else {
| > +                sdhci_sdma_transfer_multi_blocks(s);
| > +            }
| >          }
| >          break;
| >      case SDHC_BLKSIZE:
| > ===
| 
| Should this be a third patch or is this in a different series?

  Yes, a third patch in the series; If it is required.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
