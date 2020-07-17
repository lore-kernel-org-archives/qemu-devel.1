Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92561C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5221D20787
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSroWR2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5221D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwEeN-0002Au-JW
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 20:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jwEdq-0001kt-4C
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 20:54:22 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jwEdo-0002IU-G5
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 20:54:21 -0400
Received: by mail-ot1-x342.google.com with SMTP id e90so5720072ote.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7gZOlB576AUusftg2pqZ5wF43SGLFl0fw0tw/PBuByM=;
 b=YSroWR2Z6VbcDM82m7OB6/Q0hlS3rdaivv7DVYx6NIAd9z6BgzId048I/Oq5Ir2IkJ
 NW/FsqYwxygt+PoPNmL0u9Z2mNNT47mZ75EB1xLVUzM7noxTu2tL9Kf/NJ7F6MYuSKh1
 qAC76Z8DlW/4TCVnjTLXcnhH5NIQ0owYTXrX4/D2MEXwVFgBn19f+6SrAtsuaAJFjk+f
 apwxWWGuQULgvs5t2oQJ91vBRRbOCdYHNRh1zdTERX/XHsYbnWs40fT52OVmyTXGGa98
 B2ufEQwVsb+wqJniz8EbcqFWbxIqM8MIh3LcythAMbjFPPOFCiflq0m6r9IULjJZysGR
 4NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7gZOlB576AUusftg2pqZ5wF43SGLFl0fw0tw/PBuByM=;
 b=htcINUJpnGH+tR6t/OjqtC4mDhhA+i9KVWTR7fkYjR+298L+1coxXyLnfBh/EoGCrw
 ak/38DrpGM9VPyYokFdq+QJRDLfYDx0ZQfIjxUQTuYTIIcWG45XSb/7QJL88zhz0R3oa
 1/2yKzhIs0dtRnl7gsGWqbotbOlJDnwd2uy/qfTsscg53fw7JIvCu238g4YDaXfjkxj5
 yQucdXToGS8NDvKQXN01dYLaBI6qA46WzQ3ui0N6E6Zny/aPaj+MVDxif5wK6/MuJNIu
 1RnSGcJDW51UEWYkfMONkDgjFU8m218QvmMrILhpvzCyAcGilP3x9J4skGKEfSe+z7Jh
 4Nng==
X-Gm-Message-State: AOAM533nu+5SEZ+5i6sbllkM2J9W19P6BjATqZRf43Ql0TU2DDCqpeGW
 gJ5T/NtL1RoDwXy2IjG6CrFSd80e7fOMwPD/FIQ=
X-Google-Smtp-Source: ABdhPJya8+HqdcFAjK/82mAm2eaTThq5UcBmf/OJ6QzsVN8oa6iXj7WDwP8TYAA0TANE0dfx7kXS+MIYN2Xzh0ImQk0=
X-Received: by 2002:a9d:787:: with SMTP id 7mr6672907oto.333.1594947259030;
 Thu, 16 Jul 2020 17:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200716192335.1212638-1-ppandit@redhat.com>
In-Reply-To: <20200716192335.1212638-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 17 Jul 2020 08:53:42 +0800
Message-ID: <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
Subject: Re: [PATCH] net: check payload length limit for all frames
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8817=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:26=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While sending packets, the check that packet 'payload_len'
> is within 64kB limit, seems to happen only for GSO frames.
> It may lead to use-after-free or out-of-bounds access like
> issues when sending non-GSO frames. Check the 'payload_len'
> limit for all packets, irrespective of the gso type.
>

Hello Prasad,
Which issue are you trying to solve, any reference linking?

I also send a patch related this part and also a UAF.

Thanks,
Li Qiang

> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/net/net_tx_pkt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 162f802dd7..e66998a8f9 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -607,12 +607,10 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClien=
tState *nc)
>       * Since underlying infrastructure does not support IP datagrams lon=
ger
>       * than 64K we should drop such packets and don't even try to send
>       */
> -    if (VIRTIO_NET_HDR_GSO_NONE !=3D pkt->virt_hdr.gso_type) {
> -        if (pkt->payload_len >
> -            ETH_MAX_IP_DGRAM_LEN -
> -            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
> -            return false;
> -        }
> +    if (pkt->payload_len >
> +        ETH_MAX_IP_DGRAM_LEN -
> +        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
> +        return false;
>      }
>
>      if (pkt->has_virt_hdr ||
> --
> 2.26.2
>
>

