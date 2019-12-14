Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E219DC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 10:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05FB20700
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 10:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05FB20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig4wx-0001xR-Ta
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 05:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ig4wM-0001R1-00
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ig4wJ-0002oH-Oj
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:46:25 -0500
Received: from mail.ilande.co.uk ([46.43.2.167]:48408
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ig4wE-0001Sz-Tq; Sat, 14 Dec 2019 05:46:19 -0500
Received: from host86-191-82-191.range86-191.btcentralplus.com
 ([86.191.82.191] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ig4tx-0003f9-7q; Sat, 14 Dec 2019 10:43:57 +0000
To: bilalwasim676@gmail.com, qemu-devel@nongnu.org
References: <20191210140617.16656-1-bilalwasim676@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <21af53f8-a057-b9d4-c6ff-29c3f1df5d69@ilande.co.uk>
Date: Sat, 14 Dec 2019 10:43:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210140617.16656-1-bilalwasim676@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.191.82.191
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3] net/imx_fec: Adding support for MAC filtering in the
 FEC IP implementation.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.43.2.167
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/2019 14:06, bilalwasim676@gmail.com wrote:

> From: bwasim <bilalwasim676@gmail.com>
> 
> This addition ensures that the IP does NOT boot up in promiscuous mode
> by default, and so the software only receives the desired
> packets(Unicast, Broadcast, Unicast / Multicast hashed) by default.
> The software running on-top of QEMU can also modify these settings and
> disable reception of broadcast frames or make the IP receive all packets (PROM mode).
> This patch greatly reduces the number of packets received by the
> software running on-top of the QEMU model. Tested with the armv7-a SABRE_LITE machine.
> Testing included running a custom OS with IPv4 / IPv6 support. Hashing
> and filtering of packets is tested to work well. Skeleton taken from
> the CADENCE_GEM IP and hash generation algorithm from the Linux Kernel.
> 
> Signed-off-by: Bilal Wasim <bilalwasim676@gmail.com>
> ---
>  hw/net/imx_fec.c         | 109 ++++++++++++++++++++++++++++++++++++++-
>  include/hw/net/imx_fec.h |  10 ++++
>  2 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index bd99236864..d248f39fb0 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -419,6 +419,79 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
>      dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd));
>  }
>  
> +/*
> + * Calculate a FEC MAC Address hash index
> + */
> +static unsigned calc_mac_hash(const uint8_t *mac, uint8_t mac_length)
> +{
> +    uint32_t crc = net_crc32_le(mac, mac_length);
> +
> +    /*
> +     * only upper 6 bits (FEC_HASH_BITS) are used
> +     * which point to specific bit in the hash registers
> +     */
> +    return (crc >> (32 - FEC_HASH_BITS)) & 0x3f;
> +}

Is it worth keeping this in a separate function? This appears to be a standard hash
calculation and most other cards simply inline it like below:

> +/*
> + * fec_mac_address_filter:
> + * Accept or reject this destination address?
> + */
> +static int fec_mac_address_filter(IMXFECState *s, const uint8_t *packet)
> +{
> +    const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
> +    uint32_t addr1, addr2;
> +    uint8_t  hash;
> +
> +    /* Promiscuous mode? */
> +    if (s->regs[ENET_RCR] & ENET_RCR_PROM) {
> +        /* Accept all packets in promiscuous mode (even if bc_rej is set). */
> +        return FEC_RX_PROMISCUOUS_ACCEPT;
> +    }
> +
> +    /* Broadcast packet? */
> +    if (!memcmp(packet, broadcast_addr, 6)) {

ETH_ALEN?

> +        /* Reject broadcast packets? */
> +        if (s->regs[ENET_RCR] & ENET_RCR_BC_REJ) {
> +            return FEC_RX_REJECT;
> +        }
> +        /* Accept packets from broadcast address. */
> +        return FEC_RX_BROADCAST_ACCEPT;
> +    }
> +
> +    /* Accept packets -w- hash match? */
> +    hash = calc_mac_hash(packet, 6);

       hash = net_crc32_le(buf, ETH_ALEN) >> 26

> +    /* Accept packets -w- multicast hash match? */
> +    if ((packet[0] & 0x01) == 0x01) {
> +        /* Computed hash matches GAUR / GALR register ? */
> +        if (((hash < 32) && (s->regs[ENET_GALR] & (1 << hash)))
> +                || ((hash > 31) && (s->regs[ENET_GAUR] & (1 << (hash - 32))))) {
> +            /* Accept multicast hash enabled address. */
> +            return FEC_RX_MULTICAST_HASH_ACCEPT;
> +        }
> +    } else {
> +        /* Computed hash matches IAUR / IALR register ? */
> +        if (((hash < 32) && (s->regs[ENET_IALR] & (1 << hash)))
> +                || ((hash > 31) && (s->regs[ENET_IAUR] & (1 << (hash - 32))))) {
> +            /* Accept multicast hash enabled address. */
> +            return FEC_RX_UNICAST_HASH_ACCEPT;
> +        }
> +    }
> +
> +    /* Match Unicast address. */
> +    addr1  = g_htonl(s->regs[ENET_PALR]);
> +    addr2  = g_htonl(s->regs[ENET_PAUR]);
> +    if (!(memcmp(packet, (uint8_t *) &addr1, 4) ||
> +          memcmp(packet + 4, (uint8_t *) &addr2, 2))) {
> +        /* Accept packet because it matches my unicast address. */
> +        return FEC_RX_UNICAST_ACCEPT;
> +    }
> +
> +    /* Return -1 because we do NOT support MAC address filtering.. */
> +    return FEC_RX_REJECT;
> +}
> +
>  static void imx_eth_update(IMXFECState *s)
>  {
>      /*
> @@ -984,7 +1057,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>      case ENET_IALR:
>      case ENET_GAUR:
>      case ENET_GALR:
> -        /* TODO: implement MAC hash filtering.  */
> +        s->regs[index] |= value;
>          break;
>      case ENET_TFWR:
>          if (s->is_fec) {
> @@ -1066,8 +1139,15 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
>      uint32_t buf_addr;
>      uint8_t *crc_ptr;
>      unsigned int buf_len;
> +    int maf;
>      size_t size = len;
>  
> +    /* Is this destination MAC address "for us" ? */
> +    maf = fec_mac_address_filter(s, buf);
> +    if (maf == FEC_RX_REJECT) {
> +        return FEC_RX_REJECT;
> +    }
> +
>      FEC_PRINTF("len %d\n", (int)size);
>  
>      if (!s->regs[ENET_RDAR]) {
> @@ -1133,6 +1213,16 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
>          } else {
>              s->regs[ENET_EIR] |= ENET_INT_RXB;
>          }
> +
> +        /* Update descriptor based on the "maf" flag. */
> +        if (maf == FEC_RX_BROADCAST_ACCEPT) {
> +            /* The packet is destined for the "broadcast" address. */
> +            bd.flags |= ENET_BD_BC;
> +        } else if (maf == FEC_RX_MULTICAST_HASH_ACCEPT) {
> +            /* The packet is destined for a "multicast" address. */
> +            bd.flags |= ENET_BD_MC;
> +        }
> +
>          imx_fec_write_bd(&bd, addr);
>          /* Advance to the next descriptor.  */
>          if ((bd.flags & ENET_BD_W) != 0) {
> @@ -1159,8 +1249,15 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>      uint8_t *crc_ptr;
>      unsigned int buf_len;
>      size_t size = len;
> +    int maf;
>      bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
>  
> +    /* Is this destination MAC address "for us" ? */
> +    maf = fec_mac_address_filter(s, buf);
> +    if (maf == FEC_RX_REJECT) {
> +        return FEC_RX_REJECT;
> +    }
> +
>      FEC_PRINTF("len %d\n", (int)size);
>  
>      if (!s->regs[ENET_RDAR]) {
> @@ -1254,6 +1351,16 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>                  s->regs[ENET_EIR] |= ENET_INT_RXB;
>              }
>          }
> +
> +        /* Update descriptor based on the "maf" flag. */
> +        if (maf == FEC_RX_BROADCAST_ACCEPT) {
> +            /* The packet is destined for the "broadcast" address. */
> +            bd.flags |= ENET_BD_BC;
> +        } else if (maf == FEC_RX_MULTICAST_HASH_ACCEPT) {
> +            /* The packet is destined for a "multicast" address. */
> +            bd.flags |= ENET_BD_MC;
> +        }
> +
>          imx_enet_write_bd(&bd, addr);
>          /* Advance to the next descriptor.  */
>          if ((bd.flags & ENET_BD_W) != 0) {
> diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
> index 7b3faa4019..f9cfcf6af5 100644
> --- a/include/hw/net/imx_fec.h
> +++ b/include/hw/net/imx_fec.h
> @@ -275,4 +275,14 @@ typedef struct IMXFECState {
>      uint8_t frame[ENET_MAX_FRAME_SIZE];
>  } IMXFECState;
>  
> +/* FEC address filtering defines. */
> +#define FEC_RX_REJECT                   (-1)
> +#define FEC_RX_PROMISCUOUS_ACCEPT       (-2)
> +#define FEC_RX_BROADCAST_ACCEPT         (-3)
> +#define FEC_RX_MULTICAST_HASH_ACCEPT    (-4)
> +#define FEC_RX_UNICAST_HASH_ACCEPT      (-5)
> +#define FEC_RX_UNICAST_ACCEPT           (-6)
> +
> +#define FEC_HASH_BITS                    6    /* #bits in hash */

If you inline the hash calculation as above then this line is no longer required.

>  #endif

I've done some bits on QEMU networking however I'm not familiar with this particular
device which limits me somewhat for further review.


ATB,

Mark.

