Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88874C35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5250F2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3mu4HSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5250F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpuu-0005FV-GA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1iwpu1-0004Nk-8V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1iwpu0-0004ey-0I
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:09:17 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1iwptz-0004eR-Pa
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:09:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so20886302wru.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=vunn4jij/PwSumUgbYGVfxlwmCM6KvyqwiShPczqBXY=;
 b=t3mu4HSJXw3GW904wYzhoI+X9JtHvFzzJ+BsmUID0NybxczduhDmIvFkO9MNd2X6Na
 QdKtkpvRPG0GD+ST520O/PleEXvEYoWHE+a4vYnY22eWvQlM5ZPhsj7CncYlpTLled7M
 kD/F9Y8dUjsdQMRgrX+gz8GnaRuIT9RPamJbuc9dHzCkwigPcXQurw7DiPBLzShcgKzQ
 8xZvBnqbZHbQB1gIXwSORj0V1fi6y8PTjy6moc/0RlyxD0Z+blbvTts3+AHlyVa4+LjT
 VOVkbpjp8sfYMCa5FcAxarteBgS42sMLEtRJH+b2qmXdImh4z8FMkigBC9fpONf5Nv71
 9mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=vunn4jij/PwSumUgbYGVfxlwmCM6KvyqwiShPczqBXY=;
 b=t6f/FW+0KuhZGmNlWs0AC+ytz4I1nP/SrHhtjjtzqNvLdCRvHTal8OrNOmCXkeXNpF
 cpzusNKl7oMcmNdTPlDgRh+7jo52OPKrHF5NcDb31GZlzyh7orvwzLNlCIOPAwpYQq7Z
 fF1SHy6P6aKmNnHjrypLfs/1LbMhVmsgyt+L8FxK5GZsRp4nE3vITukheeC51oDusCAT
 +RL1gLZO74CJemZ9Zndql+/JiyO41LFfsqnghjf18HIfcvykrtITXTg9WFz93xQQMOQ0
 e8W2sz+DXNsfnc3xie0NDkMQ4xH3FHNOr9vww0YmiIYaNf0nvRhnz23BU/CmIYnLuLkw
 kJfQ==
X-Gm-Message-State: APjAAAVaQWtr3B8Ipyw+81qTWDZli+PZjUhnXlkHd8hdJ9je0LQrEisz
 girYjO9Vzk/3f5/vek1u1gw=
X-Google-Smtp-Source: APXvYqwoHt4hldBIfQtoX5onSQ+N9RPbMIaCT2BOGRm3EhXO2aRTtbwPNUqe82w9uFRF/mgE1i9aGQ==
X-Received: by 2002:adf:df03:: with SMTP id y3mr36357718wrl.260.1580314154790; 
 Wed, 29 Jan 2020 08:09:14 -0800 (PST)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id o4sm3416167wrx.25.2020.01.29.08.09.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Jan 2020 08:09:14 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 1/2] NetRxPkt: Introduce support for additional hash types
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20200127115405.13459-1-yuri.benditovich@daynix.com>
Date: Wed, 29 Jan 2020 18:09:13 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <DDDADB15-A1C8-40E6-A595-6A516F6E5831@gmail.com>
References: <20200127115405.13459-1-yuri.benditovich@daynix.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 27 Jan 2020, at 13:54, Yuri Benditovich =
<yuri.benditovich@daynix.com> wrote:
>=20
> Add support for following hash types:
> IPV6 TCP with extension headers
> IPV4 UDP
> IPV6 UDP
> IPV6 UDP with extension headers
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>


Acked-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>


> ---
> hw/net/net_rx_pkt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> hw/net/net_rx_pkt.h |  6 +++++-
> hw/net/trace-events |  4 ++++
> 3 files changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index 98a5030ace..b2a06bd27d 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -307,6 +307,20 @@ _net_rx_rss_prepare_tcp(uint8_t *rss_input,
>                           &tcphdr->th_dport, sizeof(uint16_t));
> }
>=20
> +static inline void
> +_net_rx_rss_prepare_udp(uint8_t *rss_input,
> +                        struct NetRxPkt *pkt,
> +                        size_t *bytes_written)
> +{
> +    struct udp_header *udphdr =3D &pkt->l4hdr_info.hdr.udp;
> +
> +    _net_rx_rss_add_chunk(rss_input, bytes_written,
> +                          &udphdr->uh_sport, sizeof(uint16_t));
> +
> +    _net_rx_rss_add_chunk(rss_input, bytes_written,
> +                          &udphdr->uh_dport, sizeof(uint16_t));
> +}
> +
> uint32_t
> net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
>                          NetRxPktRssType type,
> @@ -347,6 +361,34 @@ net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
>         trace_net_rx_pkt_rss_ip6_ex();
>         _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, =
&rss_length);
>         break;
> +    case NetPktRssIpV6TcpEx:
> +        assert(pkt->isip6);
> +        assert(pkt->istcp);
> +        trace_net_rx_pkt_rss_ip6_ex_tcp();
> +        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, =
&rss_length);
> +        _net_rx_rss_prepare_tcp(&rss_input[0], pkt, &rss_length);
> +        break;
> +    case NetPktRssIpV4Udp:
> +        assert(pkt->isip4);
> +        assert(pkt->isudp);
> +        trace_net_rx_pkt_rss_ip4_udp();
> +        _net_rx_rss_prepare_ip4(&rss_input[0], pkt, &rss_length);
> +        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
> +        break;
> +    case NetPktRssIpV6Udp:
> +        assert(pkt->isip6);
> +        assert(pkt->isudp);
> +        trace_net_rx_pkt_rss_ip6_udp();
> +        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, false, =
&rss_length);
> +        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
> +        break;
> +    case NetPktRssIpV6UdpEx:
> +        assert(pkt->isip6);
> +        assert(pkt->isudp);
> +        trace_net_rx_pkt_rss_ip6_ex_udp();
> +        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, =
&rss_length);
> +        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
> +        break;
>     default:
>         assert(false);
>         break;
> diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
> index 7adf0fad51..048e3461f0 100644
> --- a/hw/net/net_rx_pkt.h
> +++ b/hw/net/net_rx_pkt.h
> @@ -133,7 +133,11 @@ typedef enum {
>     NetPktRssIpV4Tcp,
>     NetPktRssIpV6Tcp,
>     NetPktRssIpV6,
> -    NetPktRssIpV6Ex
> +    NetPktRssIpV6Ex,
> +    NetPktRssIpV6TcpEx,
> +    NetPktRssIpV4Udp,
> +    NetPktRssIpV6Udp,
> +    NetPktRssIpV6UdpEx,
> } NetRxPktRssType;
>=20
> /**
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 6f990ede87..73d4558f7e 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -92,9 +92,13 @@ net_rx_pkt_l3_csum_validate_csum(size_t l3hdr_off, =
uint32_t csl, uint32_t cntr,
>=20
> net_rx_pkt_rss_ip4(void) "Calculating IPv4 RSS  hash"
> net_rx_pkt_rss_ip4_tcp(void) "Calculating IPv4/TCP RSS  hash"
> +net_rx_pkt_rss_ip4_udp(void) "Calculating IPv4/UDP RSS  hash"
> net_rx_pkt_rss_ip6_tcp(void) "Calculating IPv6/TCP RSS  hash"
> +net_rx_pkt_rss_ip6_udp(void) "Calculating IPv6/UDP RSS  hash"
> net_rx_pkt_rss_ip6(void) "Calculating IPv6 RSS  hash"
> net_rx_pkt_rss_ip6_ex(void) "Calculating IPv6/EX RSS  hash"
> +net_rx_pkt_rss_ip6_ex_tcp(void) "Calculating IPv6/EX/TCP RSS  hash"
> +net_rx_pkt_rss_ip6_ex_udp(void) "Calculating IPv6/EX/UDP RSS  hash"
> net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash =
for %zu bytes: 0x%X"
> net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset) =
"Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
>=20
> --=20
> 2.17.1
>=20


