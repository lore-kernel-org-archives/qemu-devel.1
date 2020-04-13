Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4FEC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D365206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+oQffKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D365206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO5pi-0008W0-9K
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 16:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1jO5ou-0007fr-Rr
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1jO5ot-0001jk-VN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:36:40 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:38979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1jO5ot-0001jT-RH; Mon, 13 Apr 2020 16:36:39 -0400
Received: by mail-qk1-x743.google.com with SMTP id b62so10956249qkf.6;
 Mon, 13 Apr 2020 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=74N17PX5gAPwPcIqFsP4IDLijznu0Gv0TdDGYOhArUk=;
 b=R+oQffKB19d2vKMjhDGtJ4C20YRVPtbnH0B54KAEGaqyQ9VMg+V1EbAGeSm+T3/D12
 bZUWtwJC/Ppcaoii6iOlKpQ4ZarVgcmEY1CpYzd6Ui/W7+Ud4XHqsPofepeCcoTgqFC+
 Te98GgfiqPIs9sHz0m6A+g8JSv9ioBNO5CPfcBkUu7ZkSZ7R3CGiK6LIbE3cjxV3kRy2
 iZmNYBi+xaqO0i+Cl7uvjF8ujetIo7T/ZNRM8QNIkjgOgrz5Tu5hb4/xHUmpallKu5AE
 94/0zq4DwQ2+PP4hDaMuar+4a/JTWSBm9cvgsrshbpiycF/DQeum8ON8Fot6eME3rH7e
 /NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=74N17PX5gAPwPcIqFsP4IDLijznu0Gv0TdDGYOhArUk=;
 b=juo1htTS/2ATgvNInmvwO0QoVZu9pKNDQpXJ5HctYPzRNp8XnjjrTNkUqgz5XB9vk2
 eo8IFfdv7PE4/wgEnnVG+smXgGkY3cM4BTgP/mUQYlyvNxiiATStHeluqqTIsYstYCt8
 kMTJjm+pKsVSlYXEObpl/qIuG28ik1iFfvDbkyAXLWvw4lsTiYTKWlAZ4gB85VlgypWI
 AZr7zgMT5IOiosMdKu4VWa5FGNl1+Z0RCOinM1JGYA6SDnJrhSvidLHC/jilTP73Volj
 9TgzPKgm5aYM6ynE8TIkLSNNQ3EY/GyzU/yetZ2KYmc3GelROfMYKVc+cnsqKOifHBYo
 ta0w==
X-Gm-Message-State: AGi0Puatys12m4BUU4XZigFaKrkGqxCH3z8A4PYztTU7oIvMF2acPa2E
 JJzLauJXEaE0AsmqP+XzLIbmUQljQNs=
X-Google-Smtp-Source: APiQypIb/4rdD94nw9ofh6p8EagwaQzIyIUBeNWvTROBQvOMblzwFpVimzDCyNQpz5C2JFfaLttsjQ==
X-Received: by 2002:a37:7203:: with SMTP id n3mr17522752qkc.336.1586810198519; 
 Mon, 13 Apr 2020 13:36:38 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:b6b7:222c:adc1:59c6:6fc1])
 by smtp.gmail.com with ESMTPSA id g25sm1778606qkl.50.2020.04.13.13.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 13:36:38 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] spapr_nvdimm.c: make 'label-size' mandatory
Date: Mon, 13 Apr 2020 17:36:28 -0300
Message-Id: <20200413203628.31636-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pseries machine does not support NVDIMM modules without label.
Attempting to do so, even if the overall block size is aligned with
256MB, will seg fault the guest kernel during NVDIMM probe. This
can be avoided by forcing 'label-size' to always be present for
sPAPR NVDIMMs.

The verification was put before the alignment check because the
presence of label-size affects the alignment calculation, so
it's not optimal to warn the user about an alignment error,
then about the lack of label-size, then about a new alignment
error when the user sets a label-size.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_nvdimm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 25be8082d7..9abcdcc26b 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -37,6 +37,12 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
     QemuUUID uuid;
     int ret;
 
+    if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
+                                &error_abort) == 0) {
+        error_setg(errp, "NVDIMM device requires label-size to be set");
+        return;
+    }
+
     if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
         error_setg(errp, "NVDIMM memory size excluding the label area"
                    " must be a multiple of %" PRIu64 "MB",
-- 
2.25.2


