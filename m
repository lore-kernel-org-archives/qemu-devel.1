Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D2AC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4BC2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEJKVB+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4BC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC9a-0001sM-2g
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC07-0004zK-CU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBza-0002Yd-T3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:27 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBza-0002SH-GT; Thu, 30 Apr 2020 12:24:54 -0400
Received: by mail-lj1-x244.google.com with SMTP id e25so7159546ljg.5;
 Thu, 30 Apr 2020 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GbdU1HOMrG9CUFlccGTR8R68ycumC+NmUh827HgH404=;
 b=XEJKVB+2wxaGUcKtIi9DiHH5JwRbYS/dTbXLebD4+ZEpBAu+sCEZLqwiIII2FBGo7g
 7bMNzAcOGc9v/+IRAhvVzQf/UYWaEbGuqwVWyiBSvNkxIiyDeqHXQeUyu8uqHnIbbaX1
 Unmv9E7ECKkKtlr4mhjgmfFxOyrvOJxZ+kFdez1bqOViF0qL4STkNay1P6drdXTcPh7C
 qnRNr/32mVwNQTY1QwOgOW46Z9NyGAa+QstTHePHO3l3X1/MkiRm3v8oAPbFv1qvMJTs
 agK8KT5hchYFLrNVNmOEk7HGvrJjr312xtR0Oczq7URH07BGBjFcrQV3vYaFwl0cm7hL
 t8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GbdU1HOMrG9CUFlccGTR8R68ycumC+NmUh827HgH404=;
 b=AoQkOfP+cTE9JHfBk3cRu2IYJWLHIQTqhBSoNWK4y3cY2UvtHADUYzd0MK6FyhL+Vo
 CvLfGGMBlVkAL9HpmiZoU5kzw0eX4RdOnugIqgB6JRKgw7GxIfZpoKObIgzmNToOY3kz
 vAz3VaD25jk31f8s5mvVPaSSCLCPjHxGdi08Ksa1NNs+OXiPSg5XIdWmo5ILYGnyYY6D
 HKtvH62UY64zA+QJJ64lHGnkzwIYr5k1csFu6B1F6Qo/fviOcZO6HD/7W+ypWLNDBOgZ
 Y1Ah3LloOnD1SBdKjILSBsuRoQXzswgrjPdW4B2zUkX3GLqdXC4zUcEZfYjobONXLfcW
 xJFw==
X-Gm-Message-State: AGi0PuY3g4oS+epb4aor8P6+pLaUOC9ZpYiTxlNfsAHX3F6aVnr6UrtJ
 SqtpKsW3b3AcIr6JqaJl+4G/65JfVmw=
X-Google-Smtp-Source: APiQypKLSMFrGewOniEU3e6IIaO1tr+6vwyJ6S6l2F4zpaVeJ488NarXMVbDIOsRNPNqKZLflVGuSg==
X-Received: by 2002:a2e:7215:: with SMTP id n21mr39538ljc.199.1588263892282;
 Thu, 30 Apr 2020 09:24:52 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 16sm147275ljr.55.2020.04.30.09.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:51 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 9/9] MAINTAINERS: Add myself as streams maintainer
Date: Thu, 30 Apr 2020 18:24:39 +0200
Message-Id: <20200430162439.2659-10-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Since we're missing a maintainer, add myself.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..9f504e32df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2311,6 +2311,12 @@ F: net/slirp.c
 F: include/net/slirp.h
 T: git https://people.debian.org/~sthibault/qemu.git slirp
 
+Streams
+M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
+S: Maintained
+F: hw/core/stream.c
+F: include/hw/stream.h
+
 Stubs
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-- 
2.20.1


