Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB98C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DDA2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSRvw2Ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DDA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifITH-0000Oz-Co
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 02:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1ifIS1-00086u-3a
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 01:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1ifIRy-0005DT-Sk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 01:59:53 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:37431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1ifIRy-0005Bh-NA; Thu, 12 Dec 2019 01:59:50 -0500
Received: by mail-qv1-xf44.google.com with SMTP id t7so546189qve.4;
 Wed, 11 Dec 2019 22:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/vGTej3K5tmtqUYcv3LSFifKkGOFV9scq9HXRHw1agQ=;
 b=kSRvw2KoKQIl0pjSejjCpF0ryhTOhvtfFMsI7eTIqUJxjWR9St8A4HUgjc3lCMFxZy
 W6Uorx6uSzDU+JQLE+GGTfb/NhbrBftOfcv17/wvbdKopjIa9x9IVmUiHYJZXtDY/RMu
 fvrOBL4gyNIMfrHiawnOt7r1Usx+wsry0XaGKcJGz6KwGIDK28otWdhY2dy3ZfN4bN8X
 l6nqYQwE0wS8x5LiJXqbwKo2M+boQhWzU1TjjRZpEzdpwKzWhqkCkoT4ywvciVohizZX
 0EAVA0fI5TWpy3wm+zliuYE10X6Sj1CJkR2SetX2p/i2eaU4T72A5T/hgT5z6kwsUXuG
 TmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/vGTej3K5tmtqUYcv3LSFifKkGOFV9scq9HXRHw1agQ=;
 b=bVYVWrUyoXD6nEXosDPC5hW/BEFuO0ImcNQKgJRH/AmBlmIOBxeTfp56Zt68BBUAfj
 Ep8NjjelwHTvDBCtbhfPHTHw5ZulT8hnWNtrqVobcQhqbs+KdK4xpi1qEHdvcB8Uvqcb
 rvFxY6VNx6oeBVokMPpvhwyrVdDB0IhoGLI2XUCzzXa2B+6X9ac3Aaz6TyDiTw6Dxs4i
 bq3PyHlO/+iy3nFdiZJCBoH4cupt3GfjGIdTi5gzhE8d08lQN9LEMiXaEeNCZuLTY2Gx
 Wwp8i1oY3+IwptjUTEUWxWO9eOD92tnwsUg2SrnOtKjIGjAkLzcUXxtchGcBpzpD+DCc
 9vXQ==
X-Gm-Message-State: APjAAAXbl8a4UAcHOGIurZXLTurt/+7Ck0oFDDyy0ntV+PaRxwnyZP3I
 f2JgFsIIbFsJhm5E/RoWeC1MghS5ZfLy80tEYY+MnA==
X-Google-Smtp-Source: APXvYqxZm/BOVXF9EAicY8Ps4EKfOimZEtCeHtoaHhuZhsmC5qejFZFRQUh1VGlRLzEIf1zaqjUCsmEVygwYYr6l7lI=
X-Received: by 2002:a05:6214:14e5:: with SMTP id
 k5mr6584112qvw.192.1576133989516; 
 Wed, 11 Dec 2019 22:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20191210140617.16656-1-bilalwasim676@gmail.com>
In-Reply-To: <20191210140617.16656-1-bilalwasim676@gmail.com>
From: Bilal Wasim <bilalwasim676@gmail.com>
Date: Thu, 12 Dec 2019 11:59:36 +0500
Message-ID: <CAHKB+ODaDEHLKk5qobvoL=dR5O2nSuH3NOcJ+q7KZZMTWKoJ1Q@mail.gmail.com>
Subject: Re: [PATCH v3] net/imx_fec: Adding support for MAC filtering in the
 FEC IP implementation.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000904c1905997c4a91"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 qemu-arm@nongnu.org, philmd@redhat.com, mark.cave-ayland@ilande.co.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000904c1905997c4a91
Content-Type: text/plain; charset="UTF-8"

Hi Jason, Mark,

Can you please review this patch..

--Bilal

On Tue, 10 Dec 2019, 19:06 , <bilalwasim676@gmail.com> wrote:

> From: bwasim <bilalwasim676@gmail.com>
>
> This addition ensures that the IP does NOT boot up in promiscuous mode
> by default, and so the software only receives the desired
> packets(Unicast, Broadcast, Unicast / Multicast hashed) by default.
> The software running on-top of QEMU can also modify these settings and
> disable reception of broadcast frames or make the IP receive all packets
> (PROM mode).
> This patch greatly reduces the number of packets received by the
> software running on-top of the QEMU model. Tested with the armv7-a
> SABRE_LITE machine.
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
> @@ -419,6 +419,79 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd,
> dma_addr_t addr)
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
> +
> +/*
> + * fec_mac_address_filter:
> + * Accept or reject this destination address?
> + */
> +static int fec_mac_address_filter(IMXFECState *s, const uint8_t *packet)
> +{
> +    const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
> };
> +    uint32_t addr1, addr2;
> +    uint8_t  hash;
> +
> +    /* Promiscuous mode? */
> +    if (s->regs[ENET_RCR] & ENET_RCR_PROM) {
> +        /* Accept all packets in promiscuous mode (even if bc_rej is
> set). */
> +        return FEC_RX_PROMISCUOUS_ACCEPT;
> +    }
> +
> +    /* Broadcast packet? */
> +    if (!memcmp(packet, broadcast_addr, 6)) {
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
> +
> +    /* Accept packets -w- multicast hash match? */
> +    if ((packet[0] & 0x01) == 0x01) {
> +        /* Computed hash matches GAUR / GALR register ? */
> +        if (((hash < 32) && (s->regs[ENET_GALR] & (1 << hash)))
> +                || ((hash > 31) && (s->regs[ENET_GAUR] & (1 << (hash -
> 32))))) {
> +            /* Accept multicast hash enabled address. */
> +            return FEC_RX_MULTICAST_HASH_ACCEPT;
> +        }
> +    } else {
> +        /* Computed hash matches IAUR / IALR register ? */
> +        if (((hash < 32) && (s->regs[ENET_IALR] & (1 << hash)))
> +                || ((hash > 31) && (s->regs[ENET_IAUR] & (1 << (hash -
> 32))))) {
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
> @@ -984,7 +1057,7 @@ static void imx_eth_write(void *opaque, hwaddr
> offset, uint64_t value,
>      case ENET_IALR:
>      case ENET_GAUR:
>      case ENET_GALR:
> -        /* TODO: implement MAC hash filtering.  */
> +        s->regs[index] |= value;
>          break;
>      case ENET_TFWR:
>          if (s->is_fec) {
> @@ -1066,8 +1139,15 @@ static ssize_t imx_fec_receive(NetClientState *nc,
> const uint8_t *buf,
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
> @@ -1133,6 +1213,16 @@ static ssize_t imx_fec_receive(NetClientState *nc,
> const uint8_t *buf,
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
> @@ -1159,8 +1249,15 @@ static ssize_t imx_enet_receive(NetClientState *nc,
> const uint8_t *buf,
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
> @@ -1254,6 +1351,16 @@ static ssize_t imx_enet_receive(NetClientState *nc,
> const uint8_t *buf,
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
> +
>  #endif
> --
> 2.19.1.windows.1
>
>

--000000000000904c1905997c4a91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Jason, Mark,=C2=A0<div dir=3D"auto"><br></div><div dir=
=3D"auto">Can you please review this patch..=C2=A0</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">--Bilal</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 10 Dec 2019, 19:06 , &lt;<a=
 href=3D"mailto:bilalwasim676@gmail.com">bilalwasim676@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">From: bwasim &lt;<a href=3D"ma=
ilto:bilalwasim676@gmail.com" target=3D"_blank" rel=3D"noreferrer">bilalwas=
im676@gmail.com</a>&gt;<br>
<br>
This addition ensures that the IP does NOT boot up in promiscuous mode<br>
by default, and so the software only receives the desired<br>
packets(Unicast, Broadcast, Unicast / Multicast hashed) by default.<br>
The software running on-top of QEMU can also modify these settings and<br>
disable reception of broadcast frames or make the IP receive all packets (P=
ROM mode).<br>
This patch greatly reduces the number of packets received by the<br>
software running on-top of the QEMU model. Tested with the armv7-a SABRE_LI=
TE machine.<br>
Testing included running a custom OS with IPv4 / IPv6 support. Hashing<br>
and filtering of packets is tested to work well. Skeleton taken from<br>
the CADENCE_GEM IP and hash generation algorithm from the Linux Kernel.<br>
<br>
Signed-off-by: Bilal Wasim &lt;<a href=3D"mailto:bilalwasim676@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">bilalwasim676@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/net/imx_fec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 109 +++++++++++++=
+++++++++++++++++++++++++-<br>
=C2=A0include/hw/net/imx_fec.h |=C2=A0 10 ++++<br>
=C2=A02 files changed, 118 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c<br>
index bd99236864..d248f39fb0 100644<br>
--- a/hw/net/imx_fec.c<br>
+++ b/hw/net/imx_fec.c<br>
@@ -419,6 +419,79 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_=
addr_t addr)<br>
=C2=A0 =C2=A0 =C2=A0dma_memory_write(&amp;address_space_memory, addr, bd, s=
izeof(*bd));<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Calculate a FEC MAC Address hash index<br>
+ */<br>
+static unsigned calc_mac_hash(const uint8_t *mac, uint8_t mac_length)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t crc =3D net_crc32_le(mac, mac_length);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* only upper 6 bits (FEC_HASH_BITS) are used<br>
+=C2=A0 =C2=A0 =C2=A0* which point to specific bit in the hash registers<br=
>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 return (crc &gt;&gt; (32 - FEC_HASH_BITS)) &amp; 0x3f;<br>
+}<br>
+<br>
+/*<br>
+ * fec_mac_address_filter:<br>
+ * Accept or reject this destination address?<br>
+ */<br>
+static int fec_mac_address_filter(IMXFECState *s, const uint8_t *packet)<b=
r>
+{<br>
+=C2=A0 =C2=A0 const uint8_t broadcast_addr[] =3D { 0xFF, 0xFF, 0xFF, 0xFF,=
 0xFF, 0xFF };<br>
+=C2=A0 =C2=A0 uint32_t addr1, addr2;<br>
+=C2=A0 =C2=A0 uint8_t=C2=A0 hash;<br>
+<br>
+=C2=A0 =C2=A0 /* Promiscuous mode? */<br>
+=C2=A0 =C2=A0 if (s-&gt;regs[ENET_RCR] &amp; ENET_RCR_PROM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Accept all packets in promiscuous mode (eve=
n if bc_rej is set). */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_PROMISCUOUS_ACCEPT;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Broadcast packet? */<br>
+=C2=A0 =C2=A0 if (!memcmp(packet, broadcast_addr, 6)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reject broadcast packets? */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regs[ENET_RCR] &amp; ENET_RCR_BC_REJ=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_REJECT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Accept packets from broadcast address. */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_BROADCAST_ACCEPT;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Accept packets -w- hash match? */<br>
+=C2=A0 =C2=A0 hash =3D calc_mac_hash(packet, 6);<br>
+<br>
+=C2=A0 =C2=A0 /* Accept packets -w- multicast hash match? */<br>
+=C2=A0 =C2=A0 if ((packet[0] &amp; 0x01) =3D=3D 0x01) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Computed hash matches GAUR / GALR register =
? */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((hash &lt; 32) &amp;&amp; (s-&gt;regs[ENE=
T_GALR] &amp; (1 &lt;&lt; hash)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || ((hash &gt; 31)=
 &amp;&amp; (s-&gt;regs[ENET_GAUR] &amp; (1 &lt;&lt; (hash - 32))))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Accept multicast hash enabled=
 address. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_MULTICAST_HASH_ACC=
EPT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Computed hash matches IAUR / IALR register =
? */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((hash &lt; 32) &amp;&amp; (s-&gt;regs[ENE=
T_IALR] &amp; (1 &lt;&lt; hash)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || ((hash &gt; 31)=
 &amp;&amp; (s-&gt;regs[ENET_IAUR] &amp; (1 &lt;&lt; (hash - 32))))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Accept multicast hash enabled=
 address. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_UNICAST_HASH_ACCEP=
T;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Match Unicast address. */<br>
+=C2=A0 =C2=A0 addr1=C2=A0 =3D g_htonl(s-&gt;regs[ENET_PALR]);<br>
+=C2=A0 =C2=A0 addr2=C2=A0 =3D g_htonl(s-&gt;regs[ENET_PAUR]);<br>
+=C2=A0 =C2=A0 if (!(memcmp(packet, (uint8_t *) &amp;addr1, 4) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcmp(packet + 4, (uint8_t *) &amp;add=
r2, 2))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Accept packet because it matches my unicast=
 address. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_UNICAST_ACCEPT;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Return -1 because we do NOT support MAC address filtering=
.. */<br>
+=C2=A0 =C2=A0 return FEC_RX_REJECT;<br>
+}<br>
+<br>
=C2=A0static void imx_eth_update(IMXFECState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -984,7 +1057,7 @@ static void imx_eth_write(void *opaque, hwaddr offset,=
 uint64_t value,<br>
=C2=A0 =C2=A0 =C2=A0case ENET_IALR:<br>
=C2=A0 =C2=A0 =C2=A0case ENET_GAUR:<br>
=C2=A0 =C2=A0 =C2=A0case ENET_GALR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: implement MAC hash filtering.=C2=A0 *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[index] |=3D value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case ENET_TFWR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;is_fec) {<br>
@@ -1066,8 +1139,15 @@ static ssize_t imx_fec_receive(NetClientState *nc, c=
onst uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0uint32_t buf_addr;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *crc_ptr;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int buf_len;<br>
+=C2=A0 =C2=A0 int maf;<br>
=C2=A0 =C2=A0 =C2=A0size_t size =3D len;<br>
<br>
+=C2=A0 =C2=A0 /* Is this destination MAC address &quot;for us&quot; ? */<b=
r>
+=C2=A0 =C2=A0 maf =3D fec_mac_address_filter(s, buf);<br>
+=C2=A0 =C2=A0 if (maf =3D=3D FEC_RX_REJECT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_REJECT;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0FEC_PRINTF(&quot;len %d\n&quot;, (int)size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!s-&gt;regs[ENET_RDAR]) {<br>
@@ -1133,6 +1213,16 @@ static ssize_t imx_fec_receive(NetClientState *nc, c=
onst uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[ENET_EIR] |=3D E=
NET_INT_RXB;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Update descriptor based on the &quot;maf&qu=
ot; flag. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (maf =3D=3D FEC_RX_BROADCAST_ACCEPT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The packet is destined for th=
e &quot;broadcast&quot; address. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bd.flags |=3D ENET_BD_BC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (maf =3D=3D FEC_RX_MULTICAST_HASH_AC=
CEPT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The packet is destined for a =
&quot;multicast&quot; address. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bd.flags |=3D ENET_BD_MC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0imx_fec_write_bd(&amp;bd, addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Advance to the next descriptor.=C2=A0 =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((bd.flags &amp; ENET_BD_W) !=3D 0) {<=
br>
@@ -1159,8 +1249,15 @@ static ssize_t imx_enet_receive(NetClientState *nc, =
const uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *crc_ptr;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int buf_len;<br>
=C2=A0 =C2=A0 =C2=A0size_t size =3D len;<br>
+=C2=A0 =C2=A0 int maf;<br>
=C2=A0 =C2=A0 =C2=A0bool shift16 =3D s-&gt;regs[ENET_RACC] &amp; ENET_RACC_=
SHIFT16;<br>
<br>
+=C2=A0 =C2=A0 /* Is this destination MAC address &quot;for us&quot; ? */<b=
r>
+=C2=A0 =C2=A0 maf =3D fec_mac_address_filter(s, buf);<br>
+=C2=A0 =C2=A0 if (maf =3D=3D FEC_RX_REJECT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return FEC_RX_REJECT;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0FEC_PRINTF(&quot;len %d\n&quot;, (int)size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!s-&gt;regs[ENET_RDAR]) {<br>
@@ -1254,6 +1351,16 @@ static ssize_t imx_enet_receive(NetClientState *nc, =
const uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[EN=
ET_EIR] |=3D ENET_INT_RXB;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Update descriptor based on the &quot;maf&qu=
ot; flag. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (maf =3D=3D FEC_RX_BROADCAST_ACCEPT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The packet is destined for th=
e &quot;broadcast&quot; address. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bd.flags |=3D ENET_BD_BC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (maf =3D=3D FEC_RX_MULTICAST_HASH_AC=
CEPT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The packet is destined for a =
&quot;multicast&quot; address. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bd.flags |=3D ENET_BD_MC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0imx_enet_write_bd(&amp;bd, addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Advance to the next descriptor.=C2=A0 =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((bd.flags &amp; ENET_BD_W) !=3D 0) {<=
br>
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h<br>
index 7b3faa4019..f9cfcf6af5 100644<br>
--- a/include/hw/net/imx_fec.h<br>
+++ b/include/hw/net/imx_fec.h<br>
@@ -275,4 +275,14 @@ typedef struct IMXFECState {<br>
=C2=A0 =C2=A0 =C2=A0uint8_t frame[ENET_MAX_FRAME_SIZE];<br>
=C2=A0} IMXFECState;<br>
<br>
+/* FEC address filtering defines. */<br>
+#define FEC_RX_REJECT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(-1)<br>
+#define FEC_RX_PROMISCUOUS_ACCEPT=C2=A0 =C2=A0 =C2=A0 =C2=A0(-2)<br>
+#define FEC_RX_BROADCAST_ACCEPT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(-3)<br>
+#define FEC_RX_MULTICAST_HASH_ACCEPT=C2=A0 =C2=A0 (-4)<br>
+#define FEC_RX_UNICAST_HASH_ACCEPT=C2=A0 =C2=A0 =C2=A0 (-5)<br>
+#define FEC_RX_UNICAST_ACCEPT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(-6)=
<br>
+<br>
+#define FEC_HASH_BITS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 6=C2=A0 =C2=A0 /* #bits in hash */<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.19.1.windows.1<br>
<br>
</blockquote></div>

--000000000000904c1905997c4a91--

