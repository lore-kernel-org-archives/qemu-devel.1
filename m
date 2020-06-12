Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF091C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DB32067B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRsrgQqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DB32067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl2v-0007Vi-T1
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1f-0005Qq-Up
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1e-0001NE-AC
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yihp2yFMcguSy9jFeXkGeBwz3LCEihh+GUUxuBuxjO0=;
 b=hRsrgQquDmSV1GRkEXYNz1GPnaFH6U+Ggbgpr4Br62uJj6iv6TlxY1wYx1NyFO5LqQYxPd
 9OKCSep1H9JqI2RuciELYzXwKp731eesoS/3nGwR57Ht52RcGf4MFZfSB4zd/ag/1qNqEJ
 hHv6804l53PfqJ5/cNYMZo5y7GV7q80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-mTwvBnoSNEWTO6LHipy8hg-1; Fri, 12 Jun 2020 10:51:19 -0400
X-MC-Unique: mTwvBnoSNEWTO6LHipy8hg-1
Received: by mail-wm1-f69.google.com with SMTP id q7so2034106wmj.9
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Yihp2yFMcguSy9jFeXkGeBwz3LCEihh+GUUxuBuxjO0=;
 b=f9SlLKSPFXMlYt38yshq6OT4KQPdWeoxVWUOjQoa+tl4JUy6KSczR5qthME/V5zrh/
 ibccx1axjjne6OJCPG4S2USghs9WxXq51lplZGjU8KEX20tYAbgDKiYRO1FYeKLp60Px
 KNXMgijpa7/kF7zqc3rK20dO/U5fgSOeRkfYPYNO6ym3FOgytjHl/LgS+llqjIMQlf+T
 e9iPR4QWqrmuwon65n2l6HgzVS7I3FdCoUwpgy8lugGik5kc146LUH2su0mJXUNg2lR9
 rIhBYLPtCOpROx4+9WhoZeK2H1MFXJnEmPmCgQPPvyNoRTlTnWSsYKUVihxFN/g8sYD3
 UkZA==
X-Gm-Message-State: AOAM531vFeFMiV0+uLbzzv7SLrTSYN0+dX+xQEhL6CfuVngF2lPtWKGq
 J1hT4V9i/91Gvh/+G5Vrpu1Qt/ize7WhOREUVKCJSzq5+Wc3IuGjfXNv49MbyzPrZU1wNMRg2d7
 PyGdL4bky0iy3XC8=
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr14333526wmj.144.1591973478207; 
 Fri, 12 Jun 2020 07:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI2MR9iN3aR/RD9EO4Em5OmMWD1qY8IFsKnkP4tibDnLG5SaU96a7YSvkwWFVBSQyDOawX0g==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr14333508wmj.144.1591973478048; 
 Fri, 12 Jun 2020 07:51:18 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id f9sm10134022wre.65.2020.06.12.07.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:17 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/58] acpi: rtc: use a single crs range
Message-ID: <20200612141917.9446-8-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Use a single io range for _CRS instead of two,
following what real hardware does.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200515150421.25479-4-kraxel@redhat.com>
---
 hw/rtc/mc146818rtc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index fe05a4488e..1e9fa0f33f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -1013,12 +1013,14 @@ static void rtc_build_aml(ISADevice *isadev, Aml *scope)
     Aml *dev;
     Aml *crs;
 
+    /*
+     * Reserving 8 io ports here, following what physical hardware
+     * does, even though qemu only responds to the first two ports.
+     */
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
-                           0x10, 0x02));
+                           0x01, 0x08));
     aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
-    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE + 2, RTC_ISA_BASE + 2,
-                           0x02, 0x06));
 
     dev = aml_device("RTC");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
-- 
MST


