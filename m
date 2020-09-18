Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA00C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006AC23119
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006AC23119
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNQv-0006dU-Ow
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7S-0004kO-FY; Fri, 18 Sep 2020 16:36:34 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7N-0004wX-Qq; Fri, 18 Sep 2020 16:36:34 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id DF1EF5801F2;
 Fri, 18 Sep 2020 16:36:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 gn31c3w5iM1EbPGIq2NOqpzeSr7S+7R7lzk+sfWK6ss=; b=NYkvGjTLBb3+AeqS
 2vP3rgkW15STPs93Y03/0nuO1a8ailXml3mAKV/7JLtHYK7fySPJyzaD36w19HuT
 4Jzl6aKnQro3A5Lj9bkmGHE5vIdKXpPWmjOp94ajD745m56wD4Le+DoyBmpsfQah
 g5n3JXNtZmQVNF+fCdcaaKe21Czuc2jp6ww50irsmo4wt2alPVPyX3gL0V6whrb4
 vQkflNQE6Wyf9dSO4xivjbMpDjyzdOsp2FucKEuUO2oHWbev4Og1+ga4chlOrnuS
 lSW3Q57jbcPJjREcJF/MJpFT9Hun28boTm6Qf2YGcBaTC+w4UO+ZnyrHhZxSGGFK
 9k9kCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=gn31c3w5iM1EbPGIq2NOqpzeSr7S+7R7lzk+sfWK6
 ss=; b=XHfUxDw/uPRWmpC1zswEw2UUb4W5DGocav0nnpbJLTckYHYbsUvNhQkHX
 h17lcPwAOX45eLFKKzUDix17bmGmjpLvlUg5r0kObTzx9K346xN/QJyLEyf7uF2r
 RWVgpA9B4UeV1XhWhIK8/N3chrUHfFvg3CF1ax7GNOiWf3mjPP+lF9j9t4mYqtW0
 zGLUokNkn5pjLcrAfHZqgZIBRJ5CB4AiUiOWFCKsW86bg8e2rTJUVmb0hsJNbfOp
 JQ/Uy+afXdo1JxlcAAyQb6ZS0AIwlkx3FbyCmAy8iTR3bqVXuyXN/W0fWEAqt/QL
 A3Z+L/y0akSv59FQHxCIWclQj15tQ==
X-ME-Sender: <xms:SxplX6GALP5UJdF-bOzSQjhCHbtdhSu02ylf6sAaEbGKBevWT4PhCA>
 <xme:SxplX7WG5a4BdNy3PNTV7-EMx44yPN9Yzv7MVouvRC5Nkzs9oW6T8-lxtgZT3SyvN
 0PWSrQXQxnEQeR-Ako>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepteevuedugeevieehgeeileeufeetvddtkeetfeelgeehudfhjeeuledvhfff
 tdegnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:SxplX0JR_coxAWc0KgUIFV2CAZUur5xgSiLXBnVRGke7JUd3lsw3Yg>
 <xmx:SxplX0FRmG5tOCtFDOxK55XWvnoaeA3ZWLGDICNx_Act7OeloIbcaQ>
 <xmx:SxplXwXDCnIPJK9baXaZyp06HRJ2FofkDIYDLlqUZ499X0FVgvpIGA>
 <xmx:SxplX0oOi05u6q0ewVnMQQDKiDVgwsS4vRIlp2RzeZp6MnvXhPKsT-1mBQY>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 212DA306467E;
 Fri, 18 Sep 2020 16:36:26 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/17] pci: pass along the return value of dma_memory_rw
Date: Fri, 18 Sep 2020 22:36:06 +0200
Message-Id: <20200918203621.602915-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918203621.602915-1-its@irrelevant.dk>
References: <20200918203621.602915-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Some devices might want to know the return value of dma_memory_rw, so
pass it along instead of ignoring it.

There are no existing users of the return value, so this patch should be
safe.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 include/hw/pci/pci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c13ae1f8580b..0ff3feec1573 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -785,8 +785,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
-    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
-    return 0;
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
-- 
2.28.0


