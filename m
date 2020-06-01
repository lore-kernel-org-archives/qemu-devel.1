Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB962C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E82F206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="WLyNRlCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E82F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfmzI-0003Uc-UF
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jfmyZ-0002af-Ow
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:07:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jfmyX-0000PQ-Gj
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:07:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so415120wro.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qRJz98LO4syBJpBzOguMNeQxHeKu/VmuUE0086lmh1A=;
 b=WLyNRlCdmw4/AprKinbq9q/E+4NsVImREYu1Cp+BC0Jyo4dverPAKNZf53VXZ9fdXg
 0aB/ZKFnDsAj43A+mi0pJlkXkj7jkHMEOjylQIFm04PYSNmqkzQ91jdzNFHJJi4wyytp
 sL4NjFXPotpIEiW5vs8FTHpWOdzuMNmacmKQvPMDsULZ1sum1Pa9c7muETHftWTMsfCz
 y9MwUnuVT58g93ImhO5QwlvQIbp4S5Xui3KVoW4p1vdf8q7cMj27a+rN6ROimGhLHSXq
 +yMYNYwrb7sJrsJX20yq160E+yWO5CPfmlSyXsG9lPNnrwyDxzB+05hgdpB+zmf7bXaD
 1G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qRJz98LO4syBJpBzOguMNeQxHeKu/VmuUE0086lmh1A=;
 b=kFQpZVfoflx3+Nmp6sRzSoKcouw9Ik1BIjWyjd7AtogllceT7C3vRgbMiRAHYhRyDb
 jxKdGR60bWn7uDA7lhBnj2wu7j2jT47bhyrv70Kj5Y5r1KyNCfSDIXFHkQ62PLSa0JxF
 Wguvx+aj8P9aIXJvwRAHYD4m/21y0yL1vyvQ8/GoMigHz/7XzDk9BGrwcyLFWbWSn1j2
 NEk8TO39z2N8mdMb/Ut7NFGhfkCKvGtKA5a8lYDLIIDS1tg/5P718iZexCIPUtvOwhvU
 OWvRH1QBmvjfjUo8fcSV4054OgAJQsSOftwnfR5JGqi22ihjBOnpYEdxAzxVfNNhlNEd
 KFwg==
X-Gm-Message-State: AOAM530QBKiCJACHSh+OaPUqRD4drdKIwylYqqVqWbY5p/hBcuwJ1dZh
 oDHtI44uzlW9BtCZXfQbNba8RRycD1x0i/t7qGFprg==
X-Google-Smtp-Source: ABdhPJx9aJxuRwTR2R+ECn03rQhPbg9BHGsTI9zmSMu4dgGq3sHs1ln/XyZU69Bjo5BC8VZrrLlK5yJHtZhmP0xnNrk=
X-Received: by 2002:a5d:4488:: with SMTP id j8mr21793309wrq.242.1591027663282; 
 Mon, 01 Jun 2020 09:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200507192541.1046225-1-andrew@daynix.com>
 <20200507192541.1046225-2-andrew@daynix.com>
 <1d1ac6c5-db3c-8610-1df0-2ff36ab39b4e@redhat.com>
In-Reply-To: <1d1ac6c5-db3c-8610-1df0-2ff36ab39b4e@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 1 Jun 2020 19:36:00 +0300
Message-ID: <CABcq3pHQ7vhb2PE+beYHkip2M8Rzb8rfK_KtoVe1eOLbaCt8Qg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/net: Added basic IPv6 fragmentation. Fixed IPv6
 payload length. Fixed CSO for IPv6.
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b2b5fd05a707fe14"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=andrew@daynix.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b2b5fd05a707fe14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Please introduce a separate patch to do this.

Ok, I'll split the patch.

> Did you mean the headeroom might not be enough?
>
Technically, yes - extensions increase L3 header size. If there are a lot
of them, total packet len may be greater then MTU after adding
fragmentation extension. Qemu calculates payload len for fragment only for
L4.

> Need be verbose on this.
>
Ok, technically, what OS expects is that the device will do segmentation,
so each packet may have different sizes. For backends with vheader, we need
just one packet with proper payload size. For fragmentation, size is
recalculated.

> What did "unsafe" suffix meant here?
>
We adding fragmentation extension for IPv6 L3 to the end of the buffer. So,
there is should be enough memory for that - we chacked it before calling
the function.

> Let's just implement the allocation here.
>
This is 'rare' case, L3 header buffer is allocated with NetTxPkt structure
and equals to ETH_MAX_IP_DGRAM_LEN =3D 0xFFFF - which is more than enough. =
To
'reallocate' the memory, we need to refactor NetTxPkt structure and
routine, which is maybe done in the future. For now, I think we need basic
IPv6 fragmentation.

> Please introduce a macro with comment for this magic number.
>
Ok, 0x71656d75 - it's string 'qemu'. We just need some number for packet
identification, it's unique for every fragmented packet series.

On Fri, May 29, 2020 at 12:11 PM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/5/8 =E4=B8=8A=E5=8D=883:25, andrew@daynix.com wrote:
> > From: Andrew Melnychenko <andrew@daynix.com>
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1708065
> > Overall, there was an issue that big frames of IPv6 doesn't sent.
> > With network backend with 'virtual header' - there was an issue
> > in 'plen' field. Overall, during TSO, 'plen' would be changed,
> > but with 'vheader' this field should be set to the size of the
> > payload itself instead of '0'.
> > For software offload - there is added basic IPv6 fragmentation.
>
>
> Please introduce a separate patch to do this.
>
>
> > Also fixed checksum offload for IPv6.
>
>
> And another patch for this.
>
>
> > The basic IPv6 fragmentation - adding 'frag' extension to
> > the packet, overall shares some logic with IPv4. It works,
> > but there are still issues with a combination of
> > extensions - in the future, it would require refactoring
> > work to implement workflow with IPv6 and extension.
>
>
> Did you mean the headeroom might not be enough?
>
>
> > e1000e driver doesn't set the 'plen' field for IPv6 for big packets
> > if TSO is enabled. "Jumbo option" isn't added yet, until
> > qemu supports packets greater than 64K.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   hw/net/net_tx_pkt.c | 54 ++++++++++++++++++++++++---
> >   hw/net/net_tx_pkt.h |  7 ++++
> >   include/net/eth.h   | 15 ++++++--
> >   net/eth.c           | 89 ++++++++++++++++++++++++++++++++++++++++++--=
-
> >   4 files changed, 151 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> > index 162f802dd7..895effecb9 100644
> > --- a/hw/net/net_tx_pkt.c
> > +++ b/hw/net/net_tx_pkt.c
> > @@ -468,8 +468,8 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt
> *pkt)
> >       /* num of iovec without vhdr */
> >       uint32_t iov_len =3D pkt->payload_frags + NET_TX_PKT_PL_START_FRA=
G -
> 1;
> >       uint16_t csl;
> > -    struct ip_header *iphdr;
> >       size_t csum_offset =3D pkt->virt_hdr.csum_start +
> pkt->virt_hdr.csum_offset;
> > +    uint16_t l3_proto =3D eth_get_l3_proto(iov, 1, iov->iov_len);
> >
> >       /* Put zero to checksum field */
> >       iov_from_buf(iov, iov_len, csum_offset, &csum, sizeof csum);
> > @@ -477,9 +477,18 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt
> *pkt)
> >       /* Calculate L4 TCP/UDP checksum */
> >       csl =3D pkt->payload_len;
> >
> > +    csum_cntr =3D 0;
> > +    cso =3D 0;
> >       /* add pseudo header to csum */
> > -    iphdr =3D pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base;
> > -    csum_cntr =3D eth_calc_ip4_pseudo_hdr_csum(iphdr, csl, &cso);
> > +    if (l3_proto =3D=3D ETH_P_IP) {
> > +        csum_cntr =3D eth_calc_ip4_pseudo_hdr_csum(
> > +                pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
> > +                csl, &cso);
> > +    } else if (l3_proto =3D=3D ETH_P_IPV6) {
> > +        csum_cntr =3D eth_calc_ip6_pseudo_hdr_csum(
> > +                pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
> > +                csl, pkt->l4proto, &cso);
> > +    }
> >
> >       /* data checksum */
> >       csum_cntr +=3D
> > @@ -580,10 +589,11 @@ static bool net_tx_pkt_do_sw_fragmentation(struct
> NetTxPkt *pkt,
> >
> >           more_frags =3D (fragment_offset + fragment_len <
> pkt->payload_len);
> >
> > -        eth_setup_ip4_fragmentation(l2_iov_base, l2_iov_len,
> l3_iov_base,
> > -            l3_iov_len, fragment_len, fragment_offset, more_frags);
> > +        eth_setup_ip_fragmentation(l2_iov_base, l2_iov_len, l3_iov_bas=
e,
> > +            &l3_iov_len, ETH_MAX_IP_DGRAM_LEN,
> > +            fragment_len, fragment_offset, more_frags);
> >
> > -        eth_fix_ip4_checksum(l3_iov_base, l3_iov_len);
> > +        fragment[NET_TX_PKT_FRAGMENT_L3_HDR_POS].iov_len =3D l3_iov_le=
n;
> >
> >           net_tx_pkt_sendv(pkt, nc, fragment, dst_idx);
> >
> > @@ -617,6 +627,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt,
> NetClientState *nc)
> >
> >       if (pkt->has_virt_hdr ||
> >           pkt->virt_hdr.gso_type =3D=3D VIRTIO_NET_HDR_GSO_NONE) {
> > +        net_tx_pkt_fix_ip6_payload_len(pkt);
> >           net_tx_pkt_sendv(pkt, nc, pkt->vec,
> >               pkt->payload_frags + NET_TX_PKT_PL_START_FRAG);
> >           return true;
> > @@ -635,3 +646,34 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt=
,
> NetClientState *nc)
> >
> >       return res;
> >   }
> > +
> > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
> > +{
> > +    /*
> > +     * If ipv6 payload length field is 0 - then there should be
> Hop-by-Hop
> > +     * option for packets greater than 65,535.
> > +     * For packets with payload less than 65,535: fix 'plen' field.
> > +     * For now, qemu drops every packet with size greater 64K
> > +     * (see net_tx_pkt_send()) so, there is no reason to add jumbo
> option to ip6
> > +     * hop-by-hop extension if it's missed
> > +     */
> > +
> > +    struct iovec *l2 =3D &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
> > +    if (eth_get_l3_proto(l2, 1, l2->iov_len) =3D=3D ETH_P_IPV6) {
> > +        struct ip6_header *ip6 =3D (struct ip6_header *) pkt->l3_hdr;
> > +        /*
> > +         * TODO: if qemu would support >64K packets - add jumbo option
> check
> > +         * something like that:
> > +         * 'if (ip6->ip6_plen =3D=3D 0 && !has_jumbo_option(ip6)) {'
> > +         */
> > +        if (ip6->ip6_plen =3D=3D 0) {
> > +            if (pkt->payload_len <=3D ETH_MAX_IP_DGRAM_LEN) {
> > +                ip6->ip6_plen =3D htons(pkt->payload_len);
> > +            }
> > +            /*
> > +             * TODO: if qemu would support >64K packets
> > +             * add jumbo option for packets greater then 65,535 bytes
> > +             */
> > +        }
> > +    }
> > +}
> > diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> > index 212ecc62fc..912d56ef13 100644
> > --- a/hw/net/net_tx_pkt.h
> > +++ b/hw/net/net_tx_pkt.h
> > @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
> >   */
> >   bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
> >
> > +/**
> > + * Fix IPv6 'plen' field.
> > + *
>
>
> Need be verbose on this.
>
>
> > + * @pkt            packet
> > + */
> > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
> > +
> >   #endif
> > diff --git a/include/net/eth.h b/include/net/eth.h
> > index 7f45c678e7..05c75ac9fc 100644
> > --- a/include/net/eth.h
> > +++ b/include/net/eth.h
> > @@ -139,6 +139,14 @@ struct ip6_ext_hdr_routing {
> >       uint8_t     rsvd[4];
> >   };
> >
> > +struct ip6_ext_hdr_fragment {
> > +    uint8_t     nxt;
> > +    uint8_t     res0;
> > +    uint16_t    off;
> > +    uint32_t    id;
> > +};
> > +
> > +
> >   struct ip6_option_hdr {
> >   #define IP6_OPT_PAD1   (0x00)
> >   #define IP6_OPT_HOME   (0xC9)
> > @@ -186,6 +194,7 @@ struct tcp_hdr {
> >
> >   #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
> >   #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
> > +#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
> >
> >   #define PKT_GET_ETH_HDR(p)        \
> >       ((struct eth_header *)(p))
> > @@ -398,9 +407,9 @@ void eth_get_protocols(const struct iovec *iov, int
> iovcnt,
> >                          eth_ip4_hdr_info *ip4hdr_info,
> >                          eth_l4_hdr_info  *l4hdr_info);
> >
> > -void eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
> > -                                 void *l3hdr, size_t l3hdr_len,
> > -                                 size_t l3payload_len,
> > +void eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
> > +                                 void *l3hdr, size_t *l3hdr_len,
> > +                                 size_t l3hdr_max_len, size_t
> l3payload_len,
> >                                    size_t frag_offset, bool more_frags)=
;
> >
> >   void
> > diff --git a/net/eth.c b/net/eth.c
> > index 0c1d413ee2..21ec5dc33d 100644
> > --- a/net/eth.c
> > +++ b/net/eth.c
> > @@ -314,10 +314,62 @@ eth_strip_vlan_ex(const struct iovec *iov, int
> iovcnt, size_t iovoff,
> >       return 0;
> >   }
> >
> > +static bool eth_is_ip6_extension_header_type(uint8_t hdr_type);
> > +
> > +static void *eth_ip6_find_ext(struct ip6_header *ip6, uint8_t ext_type=
)
> > +{
> > +    uint8_t curr_ext_hdr_type =3D ip6->ip6_nxt;
> > +    struct ip6_ext_hdr *ext_hdr =3D (struct ip6_ext_hdr *)(ip6 + 1);
> > +    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
> > +        if (curr_ext_hdr_type =3D=3D ext_type) {
> > +            return ext_hdr;
> > +        }
> > +        curr_ext_hdr_type =3D ext_hdr->ip6r_nxt;
> > +        ext_hdr =3D (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
> > +                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +/*
> > + * To add an extension - there is should be
> > + * enough memory 'behind' the ip6 header.
> > + */
> > +static void *eth_ip6_add_ext_nonsafe(struct ip6_header *ip6, uint8_t
> ext_type)
> > +{
>
>
> What did "unsafe" suffix meant here?
>
>
> > +    uint8_t curr_ext_hdr_type =3D ip6->ip6_nxt;
> > +    struct ip6_ext_hdr *ext_hdr =3D (struct ip6_ext_hdr *)(ip6 + 1);
> > +    struct ip6_ext_hdr *ext_hdr_prev =3D NULL;
> > +
> > +    if (!eth_is_ip6_extension_header_type(curr_ext_hdr_type)) {
> > +        ext_hdr->ip6r_nxt =3D ip6->ip6_nxt;
> > +        ip6->ip6_nxt =3D ext_type;
> > +        return ext_hdr;
> > +    }
> > +
> > +    ext_hdr_prev =3D ext_hdr;
> > +    curr_ext_hdr_type =3D ext_hdr->ip6r_nxt;
> > +    ext_hdr =3D (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
> > +            + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
> > +
> > +    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
> > +        ext_hdr_prev =3D ext_hdr;
> > +        curr_ext_hdr_type =3D ext_hdr->ip6r_nxt;
> > +        ext_hdr =3D (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
> > +                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
> > +    }
> > +
> > +    ext_hdr->ip6r_nxt =3D ext_hdr_prev->ip6r_nxt;
> > +    ext_hdr_prev->ip6r_nxt =3D ext_type;
> > +
> > +    return ext_hdr;
> > +}
> > +
> >   void
> > -eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
> > -                            void *l3hdr, size_t l3hdr_len,
> > -                            size_t l3payload_len,
> > +eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
> > +                            void *l3hdr, size_t *l3hdr_len,
> > +                            size_t l3hdr_max_len, size_t l3payload_len=
,
> >                               size_t frag_offset, bool more_frags)
> >   {
> >       const struct iovec l2vec =3D {
> > @@ -325,7 +377,9 @@ eth_setup_ip4_fragmentation(const void *l2hdr,
> size_t l2hdr_len,
> >           .iov_len =3D l2hdr_len
> >       };
> >
> > -    if (eth_get_l3_proto(&l2vec, 1, l2hdr_len) =3D=3D ETH_P_IP) {
> > +    uint16_t l3_proto =3D eth_get_l3_proto(&l2vec, 1, l2hdr_len);
> > +
> > +    if (l3_proto =3D=3D ETH_P_IP) {
> >           uint16_t orig_flags;
> >           struct ip_header *iphdr =3D (struct ip_header *) l3hdr;
> >           uint16_t frag_off_units =3D frag_offset / IP_FRAG_UNIT_SIZE;
> > @@ -337,7 +391,32 @@ eth_setup_ip4_fragmentation(const void *l2hdr,
> size_t l2hdr_len,
> >           orig_flags =3D be16_to_cpu(iphdr->ip_off) & ~(IP_OFFMASK|IP_M=
F);
> >           new_ip_off =3D frag_off_units | orig_flags  | (more_frags ?
> IP_MF : 0);
> >           iphdr->ip_off =3D cpu_to_be16(new_ip_off);
> > -        iphdr->ip_len =3D cpu_to_be16(l3payload_len + l3hdr_len);
> > +        iphdr->ip_len =3D cpu_to_be16(l3payload_len + *l3hdr_len);
> > +
> > +        eth_fix_ip4_checksum(l3hdr, *l3hdr_len);
> > +    } else if (l3_proto =3D=3D ETH_P_IPV6) {
> > +        struct ip6_header *ip6 =3D (struct ip6_header *) l3hdr;
> > +
> > +        struct ip6_ext_hdr_fragment *frag_ext =3D NULL;
> > +
> > +        /* Find frag extension */
> > +        frag_ext =3D eth_ip6_find_ext(ip6, IP6_FRAGMENT);
> > +        if (frag_ext =3D=3D NULL) {
> > +            /* No frag extension? Add one */
> > +            if (*l3hdr_len + sizeof(*frag_ext) > l3hdr_max_len) {
> > +                return; /* TODO: request to reallocate l3hdr */
>
>
> Let's just implement the allocation here.
>
>
> > +            }
> > +            frag_ext =3D eth_ip6_add_ext_nonsafe(ip6, IP6_FRAGMENT);
> > +            *l3hdr_len +=3D sizeof(*frag_ext);
> > +            static uint32_t s_id =3D 0x71656d75; /* 'qemu' */
>
>
> Please introduce a macro with comment for this magic number.
>
> Thanks
>
>
> > +            frag_ext->id =3D cpu_to_be32(s_id);
> > +            ++s_id;
> > +        }
> > +
> > +        frag_ext->off =3D cpu_to_be16((frag_offset / IP_FRAG_UNIT_SIZE=
)
> << 3
> > +                | (uint16_t)!!more_frags);
> > +
> > +        ip6->ip6_plen =3D cpu_to_be16(l3payload_len + *l3hdr_len -
> sizeof(*ip6));
> >       }
> >   }
> >
>
>

--000000000000b2b5fd05a707fe14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">Please i=
ntroduce a separate patch to do this.</blockquote><div>Ok, I&#39;ll split t=
he patch.=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><div=
>Did you mean the headeroom might not be enough?</div></blockquote><div>Tec=
hnically, yes - extensions increase L3 header size. If there are a lot of t=
hem, total packet len may be greater then MTU after adding fragmentation ex=
tension. Qemu calculates payload len for fragment only for L4.</div><blockq=
uote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex" class=3D"gmail_quote"><div>Need be verbose on this.</d=
iv></blockquote><div>Ok, technically, what OS expects is that the device wi=
ll do segmentation, so each packet may have different sizes. For backends w=
ith vheader, we need just one packet with proper payload size. For fragment=
ation, size is recalculated.</div><blockquote style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmai=
l_quote"><div>What did &quot;unsafe&quot; suffix meant here?</div></blockqu=
ote><div>We adding fragmentation extension for IPv6 L3 to the end of the bu=
ffer. So, there is should be enough memory for that - we chacked it before =
calling the function. <br></div><blockquote style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_=
quote"><div>Let&#39;s just implement the allocation here.</div></blockquote=
><div>This is &#39;rare&#39; case, L3 header buffer is allocated with NetTx=
Pkt structure and equals to ETH_MAX_IP_DGRAM_LEN =3D 0xFFFF - which is more=
 than enough. To &#39;reallocate&#39; the memory, we need to refactor NetTx=
Pkt structure and routine, which is maybe done in the future. For now, I th=
ink we need basic IPv6 fragmentation.</div><blockquote style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" clas=
s=3D"gmail_quote"><div>Please introduce a macro with comment for this magic=
 number.</div></blockquote><div>Ok, <span class=3D"gmail-im">0x71656d75 - i=
t&#39;s string &#39;qemu&#39;. We just need some number for packet identifi=
cation, it&#39;s unique for every fragmented packet series.<br></span></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Fri, May 29, 2020 at 12:11 PM Jason Wang &lt;<a href=3D"mailto:jasowang=
@redhat.com">jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
On 2020/5/8 =E4=B8=8A=E5=8D=883:25, <a href=3D"mailto:andrew@daynix.com" ta=
rget=3D"_blank">andrew@daynix.com</a> wrote:<br>
&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" targ=
et=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt;<br>
&gt; Buglink: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1708=
065" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D1708065</a><br>
&gt; Overall, there was an issue that big frames of IPv6 doesn&#39;t sent.<=
br>
&gt; With network backend with &#39;virtual header&#39; - there was an issu=
e<br>
&gt; in &#39;plen&#39; field. Overall, during TSO, &#39;plen&#39; would be =
changed,<br>
&gt; but with &#39;vheader&#39; this field should be set to the size of the=
<br>
&gt; payload itself instead of &#39;0&#39;.<br>
&gt; For software offload - there is added basic IPv6 fragmentation.<br>
<br>
<br>
Please introduce a separate patch to do this.<br>
<br>
<br>
&gt; Also fixed checksum offload for IPv6.<br>
<br>
<br>
And another patch for this.<br>
<br>
<br>
&gt; The basic IPv6 fragmentation - adding &#39;frag&#39; extension to<br>
&gt; the packet, overall shares some logic with IPv4. It works,<br>
&gt; but there are still issues with a combination of<br>
&gt; extensions - in the future, it would require refactoring<br>
&gt; work to implement workflow with IPv6 and extension.<br>
<br>
<br>
Did you mean the headeroom might not be enough?<br>
<br>
<br>
&gt; e1000e driver doesn&#39;t set the &#39;plen&#39; field for IPv6 for bi=
g packets<br>
&gt; if TSO is enabled. &quot;Jumbo option&quot; isn&#39;t added yet, until=
<br>
&gt; qemu supports packets greater than 64K.<br>
&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/net_tx_pkt.c | 54 ++++++++++++++++++++++++---<br>
&gt;=C2=A0 =C2=A0hw/net/net_tx_pkt.h |=C2=A0 7 ++++<br>
&gt;=C2=A0 =C2=A0include/net/eth.h=C2=A0 =C2=A0| 15 ++++++--<br>
&gt;=C2=A0 =C2=A0net/eth.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 89 +++=
+++++++++++++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 =C2=A04 files changed, 151 insertions(+), 14 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c<br>
&gt; index 162f802dd7..895effecb9 100644<br>
&gt; --- a/hw/net/net_tx_pkt.c<br>
&gt; +++ b/hw/net/net_tx_pkt.c<br>
&gt; @@ -468,8 +468,8 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt =
*pkt)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* num of iovec without vhdr */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t iov_len =3D pkt-&gt;payload_frags +=
 NET_TX_PKT_PL_START_FRAG - 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t csl;<br>
&gt; -=C2=A0 =C2=A0 struct ip_header *iphdr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t csum_offset =3D pkt-&gt;virt_hdr.csum=
_start + pkt-&gt;virt_hdr.csum_offset;<br>
&gt; +=C2=A0 =C2=A0 uint16_t l3_proto =3D eth_get_l3_proto(iov, 1, iov-&gt;=
iov_len);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Put zero to checksum field */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0iov_from_buf(iov, iov_len, csum_offset, &amp=
;csum, sizeof csum);<br>
&gt; @@ -477,9 +477,18 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt=
 *pkt)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Calculate L4 TCP/UDP checksum */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0csl =3D pkt-&gt;payload_len;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 csum_cntr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 cso =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* add pseudo header to csum */<br>
&gt; -=C2=A0 =C2=A0 iphdr =3D pkt-&gt;vec[NET_TX_PKT_L3HDR_FRAG].iov_base;<=
br>
&gt; -=C2=A0 =C2=A0 csum_cntr =3D eth_calc_ip4_pseudo_hdr_csum(iphdr, csl, =
&amp;cso);<br>
&gt; +=C2=A0 =C2=A0 if (l3_proto =3D=3D ETH_P_IP) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 csum_cntr =3D eth_calc_ip4_pseudo_hdr_csu=
m(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;vec[N=
ET_TX_PKT_L3HDR_FRAG].iov_base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csl, &amp;cso=
);<br>
&gt; +=C2=A0 =C2=A0 } else if (l3_proto =3D=3D ETH_P_IPV6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 csum_cntr =3D eth_calc_ip6_pseudo_hdr_csu=
m(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;vec[N=
ET_TX_PKT_L3HDR_FRAG].iov_base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csl, pkt-&gt;=
l4proto, &amp;cso);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* data checksum */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0csum_cntr +=3D<br>
&gt; @@ -580,10 +589,11 @@ static bool net_tx_pkt_do_sw_fragmentation(struc=
t NetTxPkt *pkt,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0more_frags =3D (fragment_offse=
t + fragment_len &lt; pkt-&gt;payload_len);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_setup_ip4_fragmentation(l2_iov_base, =
l2_iov_len, l3_iov_base,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l3_iov_len, fragment_len, f=
ragment_offset, more_frags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_setup_ip_fragmentation(l2_iov_base, l=
2_iov_len, l3_iov_base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;l3_iov_len, ETH_MAX_IP=
_DGRAM_LEN,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fragment_len, fragment_offs=
et, more_frags);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_fix_ip4_checksum(l3_iov_base, l3_iov_=
len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fragment[NET_TX_PKT_FRAGMENT_L3_HDR_POS].=
iov_len =3D l3_iov_len;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0net_tx_pkt_sendv(pkt, nc, frag=
ment, dst_idx);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -617,6 +627,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClie=
ntState *nc)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pkt-&gt;has_virt_hdr ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt-&gt;virt_hdr.gso_type =3D=
=3D VIRTIO_NET_HDR_GSO_NONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 net_tx_pkt_fix_ip6_payload_len(pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0net_tx_pkt_sendv(pkt, nc, pkt-=
&gt;vec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt-&gt;payload_=
frags + NET_TX_PKT_PL_START_FRAG);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt; @@ -635,3 +646,34 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pk=
t, NetClientState *nc)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If ipv6 payload length field is 0 - then there =
should be Hop-by-Hop<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* option for packets greater than 65,535.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For packets with payload less than 65,535: fix =
&#39;plen&#39; field.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For now, qemu drops every packet with size grea=
ter 64K<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (see net_tx_pkt_send()) so, there is no reason =
to add jumbo option to ip6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* hop-by-hop extension if it&#39;s missed<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 struct iovec *l2 =3D &amp;pkt-&gt;vec[NET_TX_PKT_L2HDR_=
FRAG];<br>
&gt; +=C2=A0 =C2=A0 if (eth_get_l3_proto(l2, 1, l2-&gt;iov_len) =3D=3D ETH_=
P_IPV6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ip6_header *ip6 =3D (struct ip6_he=
ader *) pkt-&gt;l3_hdr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: if qemu would support &gt;6=
4K packets - add jumbo option check<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* something like that:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* &#39;if (ip6-&gt;ip6_plen =3D=3D =
0 &amp;&amp; !has_jumbo_option(ip6)) {&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ip6-&gt;ip6_plen =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pkt-&gt;payload_len &lt=
;=3D ETH_MAX_IP_DGRAM_LEN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip6-&gt;ip6_p=
len =3D htons(pkt-&gt;payload_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: if qemu would=
 support &gt;64K packets<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* add jumbo option fo=
r packets greater then 65,535 bytes<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h<br>
&gt; index 212ecc62fc..912d56ef13 100644<br>
&gt; --- a/hw/net/net_tx_pkt.h<br>
&gt; +++ b/hw/net/net_tx_pkt.h<br>
&gt; @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * Fix IPv6 &#39;plen&#39; field.<br>
&gt; + *<br>
<br>
<br>
Need be verbose on this.<br>
<br>
<br>
&gt; + * @pkt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet<br>
&gt; + */<br>
&gt; +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; diff --git a/include/net/eth.h b/include/net/eth.h<br>
&gt; index 7f45c678e7..05c75ac9fc 100644<br>
&gt; --- a/include/net/eth.h<br>
&gt; +++ b/include/net/eth.h<br>
&gt; @@ -139,6 +139,14 @@ struct ip6_ext_hdr_routing {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 =C2=A0 =C2=A0rsvd[4];<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +struct ip6_ext_hdr_fragment {<br>
&gt; +=C2=A0 =C2=A0 uint8_t=C2=A0 =C2=A0 =C2=A0nxt;<br>
&gt; +=C2=A0 =C2=A0 uint8_t=C2=A0 =C2=A0 =C2=A0res0;<br>
&gt; +=C2=A0 =C2=A0 uint16_t=C2=A0 =C2=A0 off;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 id;<br>
&gt; +};<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0struct ip6_option_hdr {<br>
&gt;=C2=A0 =C2=A0#define IP6_OPT_PAD1=C2=A0 =C2=A0(0x00)<br>
&gt;=C2=A0 =C2=A0#define IP6_OPT_HOME=C2=A0 =C2=A0(0xC9)<br>
&gt; @@ -186,6 +194,7 @@ struct tcp_hdr {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define ip6_nxt=C2=A0 =C2=A0 =C2=A0 ip6_ctlun.ip6_un1.ip6_=
un1_nxt<br>
&gt;=C2=A0 =C2=A0#define ip6_ecn_acc=C2=A0 ip6_ctlun.ip6_un3.ip6_un3_ecn<br=
>
&gt; +#define ip6_plen=C2=A0 =C2=A0 =C2=A0ip6_ctlun.ip6_un1.ip6_un1_plen<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define PKT_GET_ETH_HDR(p)=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0((struct eth_header *)(p))<br>
&gt; @@ -398,9 +407,9 @@ void eth_get_protocols(const struct iovec *iov, in=
t iovcnt,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 eth_ip4_hdr_info *ip4hdr_info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 eth_l4_hdr_info=C2=A0 *l4hdr_info);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -void eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *l3hdr, size_t l3hdr_=
len,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t l3payload_len,<br>
&gt; +void eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *l3hdr, size_t *l3hdr=
_len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t l3hdr_max_len, size=
_t l3payload_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t frag_offset,=
 bool more_frags);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void<br>
&gt; diff --git a/net/eth.c b/net/eth.c<br>
&gt; index 0c1d413ee2..21ec5dc33d 100644<br>
&gt; --- a/net/eth.c<br>
&gt; +++ b/net/eth.c<br>
&gt; @@ -314,10 +314,62 @@ eth_strip_vlan_ex(const struct iovec *iov, int i=
ovcnt, size_t iovoff,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static bool eth_is_ip6_extension_header_type(uint8_t hdr_type);<br>
&gt; +<br>
&gt; +static void *eth_ip6_find_ext(struct ip6_header *ip6, uint8_t ext_typ=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t curr_ext_hdr_type =3D ip6-&gt;ip6_nxt;<br>
&gt; +=C2=A0 =C2=A0 struct ip6_ext_hdr *ext_hdr =3D (struct ip6_ext_hdr *)(=
ip6 + 1);<br>
&gt; +=C2=A0 =C2=A0 for (; eth_is_ip6_extension_header_type(curr_ext_hdr_ty=
pe);) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (curr_ext_hdr_type =3D=3D ext_type) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ext_hdr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_ext_hdr_type =3D ext_hdr-&gt;ip6r_nx=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_hdr =3D (struct ip6_ext_hdr *)(((uint=
8_t *)ext_hdr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + (ext_hdr-&g=
t;ip6r_len + 1) * IP6_EXT_GRANULARITY);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * To add an extension - there is should be<br>
&gt; + * enough memory &#39;behind&#39; the ip6 header.<br>
&gt; + */<br>
&gt; +static void *eth_ip6_add_ext_nonsafe(struct ip6_header *ip6, uint8_t =
ext_type)<br>
&gt; +{<br>
<br>
<br>
What did &quot;unsafe&quot; suffix meant here?<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 uint8_t curr_ext_hdr_type =3D ip6-&gt;ip6_nxt;<br>
&gt; +=C2=A0 =C2=A0 struct ip6_ext_hdr *ext_hdr =3D (struct ip6_ext_hdr *)(=
ip6 + 1);<br>
&gt; +=C2=A0 =C2=A0 struct ip6_ext_hdr *ext_hdr_prev =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!eth_is_ip6_extension_header_type(curr_ext_hdr_type=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_hdr-&gt;ip6r_nxt =3D ip6-&gt;ip6_nxt;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ip6-&gt;ip6_nxt =3D ext_type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ext_hdr;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ext_hdr_prev =3D ext_hdr;<br>
&gt; +=C2=A0 =C2=A0 curr_ext_hdr_type =3D ext_hdr-&gt;ip6r_nxt;<br>
&gt; +=C2=A0 =C2=A0 ext_hdr =3D (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + (ext_hdr-&gt;ip6r_len + 1=
) * IP6_EXT_GRANULARITY);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (; eth_is_ip6_extension_header_type(curr_ext_hdr_ty=
pe);) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_hdr_prev =3D ext_hdr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_ext_hdr_type =3D ext_hdr-&gt;ip6r_nx=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_hdr =3D (struct ip6_ext_hdr *)(((uint=
8_t *)ext_hdr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + (ext_hdr-&g=
t;ip6r_len + 1) * IP6_EXT_GRANULARITY);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ext_hdr-&gt;ip6r_nxt =3D ext_hdr_prev-&gt;ip6r_nxt;<br>
&gt; +=C2=A0 =C2=A0 ext_hdr_prev-&gt;ip6r_nxt =3D ext_type;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ext_hdr;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0void<br>
&gt; -eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *l3hdr, size_t l3hdr_len,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t l3payload_len,<br>
&gt; +eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *l3hdr, size_t *l3hdr_len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t l3hdr_max_len, size_t l3payload_len,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t frag_offset, bool more_frag=
s)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct iovec l2vec =3D {<br>
&gt; @@ -325,7 +377,9 @@ eth_setup_ip4_fragmentation(const void *l2hdr, siz=
e_t l2hdr_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_len =3D l2hdr_len<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (eth_get_l3_proto(&amp;l2vec, 1, l2hdr_len) =3D=3D E=
TH_P_IP) {<br>
&gt; +=C2=A0 =C2=A0 uint16_t l3_proto =3D eth_get_l3_proto(&amp;l2vec, 1, l=
2hdr_len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (l3_proto =3D=3D ETH_P_IP) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t orig_flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ip_header *iphdr =3D (s=
truct ip_header *) l3hdr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t frag_off_units =3D fr=
ag_offset / IP_FRAG_UNIT_SIZE;<br>
&gt; @@ -337,7 +391,32 @@ eth_setup_ip4_fragmentation(const void *l2hdr, si=
ze_t l2hdr_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0orig_flags =3D be16_to_cpu(iph=
dr-&gt;ip_off) &amp; ~(IP_OFFMASK|IP_MF);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_ip_off =3D frag_off_units =
| orig_flags=C2=A0 | (more_frags ? IP_MF : 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iphdr-&gt;ip_off =3D cpu_to_be=
16(new_ip_off);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 iphdr-&gt;ip_len =3D cpu_to_be16(l3payloa=
d_len + l3hdr_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iphdr-&gt;ip_len =3D cpu_to_be16(l3payloa=
d_len + *l3hdr_len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_fix_ip4_checksum(l3hdr, *l3hdr_len);<=
br>
&gt; +=C2=A0 =C2=A0 } else if (l3_proto =3D=3D ETH_P_IPV6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ip6_header *ip6 =3D (struct ip6_he=
ader *) l3hdr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ip6_ext_hdr_fragment *frag_ext =3D=
 NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Find frag extension */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 frag_ext =3D eth_ip6_find_ext(ip6, IP6_FR=
AGMENT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (frag_ext =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No frag extension? Add o=
ne */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*l3hdr_len + sizeof(*fr=
ag_ext) &gt; l3hdr_max_len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* TO=
DO: request to reallocate l3hdr */<br>
<br>
<br>
Let&#39;s just implement the allocation here.<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frag_ext =3D eth_ip6_add_ex=
t_nonsafe(ip6, IP6_FRAGMENT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *l3hdr_len +=3D sizeof(*fra=
g_ext);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static uint32_t s_id =3D 0x=
71656d75; /* &#39;qemu&#39; */<br>
<br>
<br>
Please introduce a macro with comment for this magic number.<br>
<br>
Thanks<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frag_ext-&gt;id =3D cpu_to_=
be32(s_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++s_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 frag_ext-&gt;off =3D cpu_to_be16((frag_of=
fset / IP_FRAG_UNIT_SIZE) &lt;&lt; 3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (uint16_t)!=
!more_frags);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ip6-&gt;ip6_plen =3D cpu_to_be16(l3payloa=
d_len + *l3hdr_len - sizeof(*ip6));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--000000000000b2b5fd05a707fe14--

