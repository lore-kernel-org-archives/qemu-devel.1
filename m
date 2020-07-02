Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C073206BE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATVgMRzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C073206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2xi-0003dN-IU
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.mc.li@gmail.com>)
 id 1jr2g9-0006P8-LG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:07:17 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vincent.mc.li@gmail.com>)
 id 1jr2g6-00009u-2f
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:07:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id w19so863420ply.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:user-agent:mime-version;
 bh=eounZF97POuDpcNpC87VXF7s2ZlFi1rW0HaHSCyxdVg=;
 b=ATVgMRzg15F538aTMSViWjSIf0wIc4REeL31qphq14lchyu6lZm5UUegLu7CaoNbtH
 FANC59ZcZ9Zgi/XE7je0JC+17q0BSEU0VlXhPiiQotKKAJYezusgEnyONPtPm0yHx4ix
 cq/iuGr3AiKs4VhVM0lRcK2ECLsrRx43ad0PaXOi7W8fgbXWCzcXGRLBzSHvusT1bLPe
 IRDuIaFxo1Lt4PguehKRmmUjOC+HifRUjSEvuBy3BSzW5o9rgSafL2NwNNsq62pP2q3H
 bpncIHxpXzxhpBZeModqc7STz9XsygDoFI0mWE0EsBwh1GonDJD+OjX4/3zOHM7ZBgMd
 hjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
 :mime-version;
 bh=eounZF97POuDpcNpC87VXF7s2ZlFi1rW0HaHSCyxdVg=;
 b=qdyqNaymPziMC+ACfnnRjMNjckw3ASXC219DqfYdmtPYqg5z73mb+Kapz3HJE/WsRp
 HcXpUtuqO9VS4TFGqOIHNNH18sedN3km+FEY9h1TFHyJ/gtOY3XU3evgyhRlETqT+w+F
 0xGR+uJ+GglbpRcHSJwMdQO0ZyuuhH7Y65pxtQ/Sur0XqppqeI0yu6mmqXLvSymWitbf
 yCGoZOQY0HJS2q7tVRmAyHMyx/KXU4OU3EKLrwsX/LqjRtckXB8IzVgsVEJUHdKpoKHY
 r9SOOHEa4AUSmCp2m6WAy+nMe8gdrEqkH3M2J2HFzY6QdD8Ubw+RDD2Zx10yQIdfB/5+
 OJKg==
X-Gm-Message-State: AOAM532sP9A3r0+ljP5qWCQQf0WGRBMoUNU4qlmASQCXRUtto0dO6ZFA
 Rpr4nQYyspPO7yPz/IC+t5pv8Ts3
X-Google-Smtp-Source: ABdhPJxGf4nYoOPt6qLBySIoBGJP2L+UqTgtgn0fj/VwzY5aEjdc7t6t1p7Bue+d0oOAbVvbFrAfHw==
X-Received: by 2002:a17:90b:3685:: with SMTP id
 mj5mr26974876pjb.123.1593709631568; 
 Thu, 02 Jul 2020 10:07:11 -0700 (PDT)
Received: from sin-l-00030390.olympus.f5net.com
 (c-71-231-121-172.hsd1.wa.comcast.net. [71.231.121.172])
 by smtp.gmail.com with ESMTPSA id r8sm9244803pfg.147.2020.07.02.10.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:07:10 -0700 (PDT)
From: Vincent Li <vincent.mc.li@gmail.com>
X-Google-Original-From: Vincent Li <vli@gmail.com>
Date: Thu, 2 Jul 2020 10:07:09 -0700 (PDT)
X-X-Sender: vli@sea-ml-00029224.olympus.f5net.com
To: qemu-devel@nongnu.org
Subject: Question about virtio-net: implement RX RSS processing
Message-ID: <alpine.OSX.2.21.2007020914350.260@sea-ml-00029224.olympus.f5net.com>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=vincent.mc.li@gmail.com; helo=mail-pl1-x642.google.com
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
X-Mailman-Approved-At: Thu, 02 Jul 2020 13:24:30 -0400
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

I noticed the [PULL V2 02/33] virtio-net: implement RX RSS processing 
https://marc.info/?l=qemu-devel&m=159248675403246&w=2 and cloned  
https://github.com/jasowang/qemu.git tags/net-pull-request for testing the 
RX RSS feature, but I am not clear how to test this feature and see if it 
meets my needs.

I am running F-Stack Nginx applications 
https://github.com/F-Stack/f-stack/tree/dev/app/nginx-1.16.1 in KVM guest, 
F-Stack is FreeBSD TCP/IP stack ported to support DPDK, and F-Stack set 
RSS mode as code below 
https://github.com/F-Stack/f-stack/blob/dev/lib/ff_dpdk_if.c#L605

     /* Set RSS mode */
     uint64_t default_rss_hf = ETH_RSS_PROTO_MASK;
     port_conf.rxmode.mq_mode = ETH_MQ_RX_RSS;
     port_conf.rx_adv_conf.rss_conf.rss_hf = default_rss_hf;
     if (dev_info.hash_key_size == 52) {
         port_conf.rx_adv_conf.rss_conf.rss_key = default_rsskey_52bytes;
         port_conf.rx_adv_conf.rss_conf.rss_key_len = 52;
         use_rsskey_52bytes = 1;
     } else {
         port_conf.rx_adv_conf.rss_conf.rss_key = default_rsskey_40bytes;
         port_conf.rx_adv_conf.rss_conf.rss_key_len = 40;
     }
     port_conf.rx_adv_conf.rss_conf.rss_hf &= dev_info.flow_type_rss_offloads;
     if (port_conf.rx_adv_conf.rss_conf.rss_hf != ETH_RSS_PROTO_MASK) {
         printf("Port %u modified RSS hash function based on hardware support,"
         "requested:%#"PRIx64" configured:%#"PRIx64"\n",
         port_id, default_rss_hf, port_conf.rx_adv_conf.rss_conf.rss_hf);
     }

But  DPDK virtio PMD does not support RSS as below commit shows:

commit 13b3137f3b7c8f866947a9b34e06a8aec0d084f7
Author: Dilshod Urazov 
Date:   Wed Oct 9 13:32:07 2019 +0100

    net/virtio: reject unsupported Rx multi-queue modes
    
    This driver supports none of DCB, RSS or VMDQ modes, therefore must
    check and return error if configured incorrectly.
    
    Virtio can distribute Rx packets across multi-queue, but there is
    no controls (algorithm, redirection table, hash function) except
    number of Rx queues and ETH_MQ_RX_NONE is the best fit meaning
    no method is enforced on how to route packets to MQs.
    
    Fixes: c1f86306a026 ("virtio: add new driver")
    Cc: stable@dpdk.org
    
    Signed-off-by: Dilshod Urazov 
    Signed-off-by: Andrew Rybchenko 
    Reviewed-by: Maxime Coquelin 

diff --git a/drivers/net/virtio/virtio_ethdev.c 
           b/drivers/net/virtio/virtio_ethdev.c
index 0a2ed2e50..76bd40a3e 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -2066,6 +2066,13 @@ virtio_dev_configure(struct rte_eth_dev *dev)
        PMD_INIT_LOG(DEBUG, "configure");
        req_features = VIRTIO_PMD_DEFAULT_GUEST_FEATURES;
 
+       if (rxmode->mq_mode != ETH_MQ_RX_NONE) {
+               PMD_DRV_LOG(ERR,
+                       "Unsupported Rx multi queue mode %d",
+                       rxmode->mq_mode);
+               return -EINVAL;
+       }
+
        if (dev->data->dev_conf.intr_conf.rxq) {
                ret = virtio_init_device(dev, hw->req_guest_features);
                if (ret < 0)



So the problem is I can't run F-Stack Applications in KVM/Qemu guest with 
multi queue/vCPU/RSS  support, this problem seems apply to DPDK TCP 
applications require multi queue/RSS support in KVM/Qemu guest, for 
example mTCP https://github.com/mtcp-stack/mtcp I tested has similar 
problem.

I am not clear on the picture of how everything work together for  this 
virtio-net RSS feature.

I have read following blogs

https://www.redhat.com/en/blog/introduction-virtio-networking-and-vhost-net
https://www.redhat.com/en/blog/how-vhost-user-came-being-virtio-networking-and-dpdk

Someone told me that in order for DPDK frond end virtio PMD in guest support RSS, the backend 
also needs to support RSS, including vhost-net and vhost-user, it should 
have nothing to do with this Qemu virtio-net RSS, is that correct?  if 
correct, I have following questions:

1, What is the use case for this Qemu virtio-net RSS?
2, How to test the use case?
3, Are there any plan to improve vhost-net/vhost-user, DPDK virtio PMD to support RSS?

For 3,  I think this is important for KVM/Qemu/OVS-DPDK/Vhost-net environment for DPDK TCP/UDP applications. 

Note I have no problem running F-Stack or mTCP applications in VMware ESXi 
guest environment with multi queue/vCPU/RSS requirement since DPDK vmxnet3 
PMD support RSS and I assume VMware ESXi backend support RSS, so it looks VMware has 
advantage over this.

Thank you for your patience to read this email 

Regards,

Vincent     

