Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E48C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6164122D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="yIFHJOCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6164122D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Tdd-0004HB-Em
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZm-0007BT-KN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZl-0005po-FI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:10 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0TZl-0005nS-6l
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:09 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id D839B96F50;
 Wed, 21 Aug 2019 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4V2TkfQMmqe9F4xpIDy/kbJA4b4WXcmEZS3sT7nAis=;
 b=yIFHJOCES4jzCfh1jZBX6xkQ0Y9wANyHYJdMFN2wzxuAENfr2VnrystfCFYks4vonyLkVo
 mwF/8DpQ8WCsaDimrLi8yNA/E4VxcDz1Vt99fkyND1muDlSIL1/RJU7kDLB5A1bgJs1l71
 fJVdPZsxZkwFAzk1aojgeaYHsT/XVK4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:36 +0200
Message-Id: <20190821163341.16309-6-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4V2TkfQMmqe9F4xpIDy/kbJA4b4WXcmEZS3sT7nAis=;
 b=GEXU8aorDGiWJuJf50Um0oS+dynX4AvyqbN9D6uPhw3HDxdNKcdIRFsrZ66vtYDVtCXoOY
 VBQEalDqar+G9SUVxGrxsbAfFJQs8TYO+hzN7bkVNFTArkdmNZGKLwkhLJiPn6eBWSrJbe
 M2Bt49zj7epPDBjrDxAHPrvLOUIh6aY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405308; a=rsa-sha256; cv=none;
 b=sKc1fC0XgQy1JxuXhFGeD3fiNOdgToHbqQbW27D8ohZKb7SBfsG2Tga3pU8WtwLUUq69sg
 T8yhJkGBZeBBYzJet2mnNzSuPFb55tY1C9V18bYyb4e1Cng8y6IiB6kSUq023SO+J24scx
 a50gg3EOzo0WK6X3Vipl8g/pkl1gbLc=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 05/10] vl.c: replace deprecated
 qbus_reset_all registration
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace deprecated qbus_reset_all by resettable_cold_reset_fn for
the sysbus reset registration.

This does not impact the behavior: qbus_reset_all is already a wrapper
for the cold reset function.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 vl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index edd5390110..8df686b333 100644
--- a/vl.c
+++ b/vl.c
@@ -4422,7 +4422,15 @@ int main(int argc, char **argv, char **envp)
=20
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
-    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
+    /*
+     * TODO: If we had a main 'reset container' that the whole system
+     * lived in, we could reset that using the multi-phase reset
+     * APIs. For the moment, we just reset the sysbus, which will cause
+     * all devices hanging off it (and all their child buses, recursivel=
y)
+     * to be reset. Note that this will *not* reset any Device objects
+     * which are not attached to some part of the qbus tree!
+     */
+    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
=20
     if (rom_check_and_register_reset() !=3D 0) {
--=20
2.22.0


