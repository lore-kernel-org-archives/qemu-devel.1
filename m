Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B72EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38350207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTuQnDrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38350207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOi5-0007jj-GJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.mc.li@gmail.com>)
 id 1jrOSt-00050j-Dq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:23:03 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vincent.mc.li@gmail.com>)
 id 1jrOSr-0005ei-Hz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:23:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id p1so3548591pls.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=Nw2HaGEG/PrRXeswlYbS7n308ZWghxL3g2iZGsLx+eU=;
 b=lTuQnDrHXCXbySaFCrBGKvRsQ0qMiNmn4boE4wKlZPO3vOT7/Gt4hW+/8aK1+xYbL/
 UPVSTr+J337j9LgxWrxEul13DsGF4K8OXVSOSx60xlJGwTeNr3bqPQLYi7BDPAewRqnf
 2n7mKg5F7VLt4NHinPAImPuEeO4kE5yRGfi9Cn1sBP+WtLj3Dwu7owCxJg8IMNeNojfQ
 SFYAsgZ2nBBitk90ycGEuEhXSuGqClSrBSzgmvD8aUtMDUE5uw95jF0Zq+Ts2yLP3bH/
 oHOPR0HnTeZ3GjeUKbsMy8GRXqUhlbxa3qnI0DYpjhEV2OGQqA4qtJQZOXGyrnYxPpHp
 FUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=Nw2HaGEG/PrRXeswlYbS7n308ZWghxL3g2iZGsLx+eU=;
 b=cWyrznNqBSLo8Riltlmg0PpFtUVlXK98KBJuXkvfM3W3QfErPBwbwwfheRykEigDgm
 CW/qrCHCiDqlZVVDH1G5R5J/mEHlSsKNA81jc09HTXmzbF8GhFVscNL21gx98YPFzI1n
 D8QboJGGvzfSOStWRQCRc+pOFyY4ZbYxM+ZFZqLroT+VnFyrRBHpQaRgNS2JvmBPS+id
 lPvZ32bPbDnJeByCuY52w33FV3NRoSPCY2vcockyYqZrQtXBoYZMVklGiKmZUWTXwTZA
 EhQwALQ6xLOe9EPwKo9RuFmg7czGsXnFIJ9CbtNtoZBSjyyTZ9msoRT0bhK7A/648Cjs
 /zUg==
X-Gm-Message-State: AOAM532Bzv8U7wUq4LJt2Oi+W0GncFJkdyFiOk1n0UbmDPXOXEd8KpSA
 2/9aHQuQqpbpnDt6mGKyEKk=
X-Google-Smtp-Source: ABdhPJzstVOjxf08xeFUZrYN3H+7KsJ6roAYFTbIVlAWYK1J5W4FXlYIQVlyTJCy8EwV+clXLx2h7A==
X-Received: by 2002:a17:902:8491:: with SMTP id
 c17mr23742426plo.262.1593793379335; 
 Fri, 03 Jul 2020 09:22:59 -0700 (PDT)
Received: from sin-l-00030390.olympus.f5net.com
 (c-71-231-121-172.hsd1.wa.comcast.net. [71.231.121.172])
 by smtp.gmail.com with ESMTPSA id a68sm11587433pje.35.2020.07.03.09.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:22:58 -0700 (PDT)
From: Vincent Li <vincent.mc.li@gmail.com>
X-Google-Original-From: Vincent Li <vli@gmail.com>
Date: Fri, 3 Jul 2020 09:22:57 -0700 (PDT)
X-X-Sender: vli@sea-ml-00029224.olympus.f5net.com
To: Jason Wang <jasowang@redhat.com>
Subject: Re: Question about virtio-net: implement RX RSS processing
In-Reply-To: <6657ac45-383a-4654-d5d4-be76a8fcfdfa@redhat.com>
Message-ID: <alpine.OSX.2.21.2007030921400.35758@sea-ml-00029224.olympus.f5net.com>
References: <alpine.OSX.2.21.2007020914350.260@sea-ml-00029224.olympus.f5net.com>
 <6657ac45-383a-4654-d5d4-be76a8fcfdfa@redhat.com>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1976117165-1593793378=:35758"
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=vincent.mc.li@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MALFORMED_FREEMAIL=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vincent Li <vincent.mc.li@gmail.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1976117165-1593793378=:35758
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


Thank you for the answers and I will study the vhost-net patches set you 
mentioned

On Fri, 3 Jul 2020, Jason Wang wrote:

> 
> On 2020/7/3 上午1:07, Vincent Li wrote:
> > Hi,
> > 
> > I noticed the [PULL V2 02/33] virtio-net: implement RX RSS processing
> > https://marc.info/?l=qemu-devel&m=159248675403246&w=2 and cloned
> > https://github.com/jasowang/qemu.git tags/net-pull-request for testing the
> > RX RSS feature, but I am not clear how to test this feature and see if it
> > meets my needs.
> 
> 
> Yuri may know more but I think the only driver that supports RSS is Windows
> driver currently.
> 
> 
> > 
> > I am running F-Stack Nginx applications
> > https://github.com/F-Stack/f-stack/tree/dev/app/nginx-1.16.1 in KVM guest,
> > F-Stack is FreeBSD TCP/IP stack ported to support DPDK, and F-Stack set
> > RSS mode as code below
> > https://github.com/F-Stack/f-stack/blob/dev/lib/ff_dpdk_if.c#L605
> > 
> >       /* Set RSS mode */
> >       uint64_t default_rss_hf = ETH_RSS_PROTO_MASK;
> >       port_conf.rxmode.mq_mode = ETH_MQ_RX_RSS;
> >       port_conf.rx_adv_conf.rss_conf.rss_hf = default_rss_hf;
> >       if (dev_info.hash_key_size == 52) {
> >           port_conf.rx_adv_conf.rss_conf.rss_key = default_rsskey_52bytes;
> >           port_conf.rx_adv_conf.rss_conf.rss_key_len = 52;
> >           use_rsskey_52bytes = 1;
> >       } else {
> >           port_conf.rx_adv_conf.rss_conf.rss_key = default_rsskey_40bytes;
> >           port_conf.rx_adv_conf.rss_conf.rss_key_len = 40;
> >       }
> >       port_conf.rx_adv_conf.rss_conf.rss_hf &=
> > dev_info.flow_type_rss_offloads;
> >       if (port_conf.rx_adv_conf.rss_conf.rss_hf != ETH_RSS_PROTO_MASK) {
> >           printf("Port %u modified RSS hash function based on hardware
> > support,"
> >           "requested:%#"PRIx64" configured:%#"PRIx64"\n",
> >           port_id, default_rss_hf, port_conf.rx_adv_conf.rss_conf.rss_hf);
> >       }
> > 
> > But  DPDK virtio PMD does not support RSS as below commit shows:
> > 
> > commit 13b3137f3b7c8f866947a9b34e06a8aec0d084f7
> > Author: Dilshod Urazov
> > Date:   Wed Oct 9 13:32:07 2019 +0100
> > 
> >      net/virtio: reject unsupported Rx multi-queue modes
> >           This driver supports none of DCB, RSS or VMDQ modes, therefore
> > must
> >      check and return error if configured incorrectly.
> >           Virtio can distribute Rx packets across multi-queue, but there is
> >      no controls (algorithm, redirection table, hash function) except
> >      number of Rx queues and ETH_MQ_RX_NONE is the best fit meaning
> >      no method is enforced on how to route packets to MQs.
> >           Fixes: c1f86306a026 ("virtio: add new driver")
> >      Cc: stable@dpdk.org
> >           Signed-off-by: Dilshod Urazov
> >      Signed-off-by: Andrew Rybchenko
> >      Reviewed-by: Maxime Coquelin
> > 
> > diff --git a/drivers/net/virtio/virtio_ethdev.c
> >             b/drivers/net/virtio/virtio_ethdev.c
> > index 0a2ed2e50..76bd40a3e 100644
> > --- a/drivers/net/virtio/virtio_ethdev.c
> > +++ b/drivers/net/virtio/virtio_ethdev.c
> > @@ -2066,6 +2066,13 @@ virtio_dev_configure(struct rte_eth_dev *dev)
> >          PMD_INIT_LOG(DEBUG, "configure");
> >          req_features = VIRTIO_PMD_DEFAULT_GUEST_FEATURES;
> >   +       if (rxmode->mq_mode != ETH_MQ_RX_NONE) {
> > +               PMD_DRV_LOG(ERR,
> > +                       "Unsupported Rx multi queue mode %d",
> > +                       rxmode->mq_mode);
> > +               return -EINVAL;
> > +       }
> > +
> >          if (dev->data->dev_conf.intr_conf.rxq) {
> >                  ret = virtio_init_device(dev, hw->req_guest_features);
> >                  if (ret < 0)
> > 
> > 
> > 
> > So the problem is I can't run F-Stack Applications in KVM/Qemu guest with
> > multi queue/vCPU/RSS  support, this problem seems apply to DPDK TCP
> > applications require multi queue/RSS support in KVM/Qemu guest, for
> > example mTCP https://github.com/mtcp-stack/mtcp I tested has similar
> > problem.
> > 
> > I am not clear on the picture of how everything work together for  this
> > virtio-net RSS feature.
> > 
> > I have read following blogs
> > 
> > https://www.redhat.com/en/blog/introduction-virtio-networking-and-vhost-net
> > https://www.redhat.com/en/blog/how-vhost-user-came-being-virtio-networking-and-dpdk
> > 
> > Someone told me that in order for DPDK frond end virtio PMD in guest support
> > RSS, the backend
> > also needs to support RSS, including vhost-net and vhost-user, it should
> > have nothing to do with this Qemu virtio-net RSS, is that correct?  if
> > correct, I have following questions:
> > 
> > 1, What is the use case for this Qemu virtio-net RSS?
> 
> 
> It's just RSS as what other device can provide for steering or balancing.
> 
> 
> > 2, How to test the use case?
> 
> 
> Need use windows guest.
> 
> 
> > 3, Are there any plan to improve vhost-net/vhost-user, DPDK virtio PMD to
> > support RSS?
> 
> 
> For vhost-net, Sameeh posted a eBPF based solution RFC[1], we need some one to
> carry on the work. It doesn't request any extension to vhost-net thanks to the
> steering eBPF support in tuntap.
> 
> For vhost-user, we need probably extend vhost-user protocols first.
> 
> You're welcome to contribute patches.
> 
> [1] https://patchwork.kernel.org/cover/10581921/
> 
> Thanks
> 
> 
> > 
> > For 3,  I think this is important for KVM/Qemu/OVS-DPDK/Vhost-net
> > environment for DPDK TCP/UDP applications.
> > 
> > Note I have no problem running F-Stack or mTCP applications in VMware ESXi
> > guest environment with multi queue/vCPU/RSS requirement since DPDK vmxnet3
> > PMD support RSS and I assume VMware ESXi backend support RSS, so it looks
> > VMware has
> > advantage over this.
> > 
> > Thank you for your patience to read this email
> > 
> > Regards,
> > 
> > Vincent
> > 
> 
> 
--0-1976117165-1593793378=:35758--

