Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE9C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09AA20663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTcmZh0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09AA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1yA-0006Nn-Ki
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0002Mp-Df
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tx-0003N1-8r
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:39 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003IS-U3
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:37 -0500
Received: by mail-wr1-x441.google.com with SMTP id g17so13563750wro.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kuWSnhcrHwbVnp902ZpXroPuln+EY221cv9y5kwLvqA=;
 b=qTcmZh0laNkQcfn9V+l9iAZo1Y3uyrHHughSNBCLelfrtDpUpNkN24ljB9fG4fhIsO
 2l+byiGreGmoYnj+LweemP5JbPG1n60Zla83EIBD/QZhTmFK9wqSLOmSD/2G9eT4ZTJH
 TQrX67YeeH0MnAm4N5zREl91HymNxj0Ni2PMN8Mhld6KlR5sboxDh1KBTGtDvd2F+Dg4
 NLafpunozBID6ad4kNKmKQyoXbl2vIBpsJWZTmMVTdslO8CYuAtdWoZxq22lLxoZ6jDv
 ayHSkVPNktyNe1H2K2L9WZct2v3XHZldN6+KZmj7naPSPdjL0PUvMzcBM7k/uIV0ieg4
 FzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kuWSnhcrHwbVnp902ZpXroPuln+EY221cv9y5kwLvqA=;
 b=eKNDbFI33WRtQ2QTche95u6GNk+WpovEERl3QIll4W4HR1/UnpuQgYizR5MDjT1cTC
 mznpzxbQ6uyozF+O6wMinEwY8i+k8HS4Ff/BsVOJrQU74SJsAOXxiCg8aPDVD9Ee6Bm3
 SStvMVoiiqDcBs5uCGoGHeO+4mqH3OyQ0NtCCSZsPMq1SD4pNCh8juFy/HNqyoRBTryK
 P2w0pek0gzdyMDJETHZszNHlm7jFKZzVd3BT2swpOdSerSn4DnDqUp9Dp/8TPd9s3iOC
 9RKcXNjFEH7mGn0fOz/pXN8GIEn0peNOjHFfKRNiF/uorZhsUpNldyBJS9/4XXuuKvxe
 M41Q==
X-Gm-Message-State: APjAAAU+HQZHV6I+ZwRMvdau/Du0WGqEfiaCLN0G6kTfoDQ83qFShDg5
 W53wUg51mcTa1Bboazf21tmqSiMEAdqh/ddY
X-Google-Smtp-Source: APXvYqwKjPeThK8I0R2lXHip/EXLz7MdcpmQo2jbyKpSeQWyfJ3IvRD9hR9iwBe3dy1gPqHK13UYNQ==
X-Received: by 2002:adf:e812:: with SMTP id o18mr25878877wrm.127.1575830431907; 
 Sun, 08 Dec 2019 10:40:31 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:31 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 22/22] target/avr: Update MAINTAINERS file
Date: Sun,  8 Dec 2019 20:39:22 +0200
Message-Id: <20191208183922.13757-23-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include AVR maintaners in MAINTAINERS file

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..9ab7ed0865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,27 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: target/avr/
+F: tests/acceptance/machine_avr6.py
+F: default-configs/avr-softmmu.mak
+F: gdb-xml/avr-cpu.xml
+
+AVR Machines
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: hw/avr/
+F: hw/char/avr_usart.c
+F: include/hw/char/avr_usart.h
+F: hw/timer/avr_timer16.c
+F: include/hw/timer/avr_timer16.h
+F: hw/misc/avr_mask.c
+F: include/hw/misc/avr_mask.h
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-- 
2.17.2 (Apple Git-113)


