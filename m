Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA57C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6460320758
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HVjVCybu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6460320758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxOZZ-0006lC-Is
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 01:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYW-0005hW-Nn; Mon, 20 Jul 2020 01:41:40 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35337 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYT-0005w3-TO; Mon, 20 Jul 2020 01:41:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B99Zd5tm9z9sRN; Mon, 20 Jul 2020 15:41:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595223689;
 bh=GRhVhfoQfc+mGBRWEkJexw+nAj42hew1pHivUA4/MQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HVjVCybuClqL3U6/9ekQp/gmLjeRm/lL2srvLJ0qM+vqFxfV9cbREa5sOqxyIaegS
 mMZBQWXh5b+S6j/Smrjv3oq8TFtMWRsCL1EFfQzUXkqNoN0Uv1Wn8wLyq6sx4xmYvG
 hojf7ogAMS3XEtyP0ebOn18eaHoSAu0m6cAdAQS8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 1/4] ppc/pnv: Make PSI device types not user creatable
Date: Mon, 20 Jul 2020 15:41:23 +1000
Message-Id: <20200720054126.258032-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720054126.258032-1-david@gibson.dropbear.id.au>
References: <20200720054126.258032-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

QEMU aborts with -device pnv-psi-POWER8:

$ qemu-system-ppc64 -device pnv-psi-POWER8
qemu-system-ppc64: hw/intc/xics.c:605: ics_realize: Assertion
`ics->xics' failed.
Aborted (core dumped)

The Processor Service Interface Controller is an internal device.
It should only be instantiated by the chip, which takes care of
configuring the link required by the ICS object in the case of
POWER8. It doesn't make sense for a user to specify it on the
command line.

Note that the PSI model for POWER8 was added 3 yrs ago but the
devices weren't available on the command line because of a bug
that was fixed by recent commit 2f35254aa0 ("pnv/psi: Correct
the pnv-psi* devices not to be sysbus devices").

Fixes: 54f59d786c ("ppc/pnv: Add cut down PSI bridge model and hookup external interrupt")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159413975752.169116.5808968580649255382.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5bdeec700e..6a479cac53 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -929,6 +929,7 @@ static void pnv_psi_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV PSI Controller";
     device_class_set_props(dc, pnv_psi_properties);
     dc->reset = pnv_psi_reset;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo pnv_psi_info = {
-- 
2.26.2


