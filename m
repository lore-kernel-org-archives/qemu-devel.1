Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA16BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D3C2081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4Wxb/5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D3C2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlP8-0000rK-M4
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl4I-0002xn-Np
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:54:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl4F-0001py-NI
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tIipyy3cxji7TSg5TkYgKmMY4wP6xoAvP6GDwENCxXs=;
 b=c4Wxb/5Ev93T2kLX21g9WVOgG4fm96vJnFh/rQ/dUjvh/UPwKPjrg/d9AR8FlunmybgtGy
 Bkq+dG4rvBJbG0vZrkr7FBjwfwAW9DcDzSLZSEhoqpgQPhGVjYaT5dcrC5dDnOoASZf+B3
 ZlS5NhpqFX5SH3xKIPmzXSk1qa+ziPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-YUStj6CnPRSp-2TUeGzKGA-1; Fri, 12 Jun 2020 10:51:14 -0400
X-MC-Unique: YUStj6CnPRSp-2TUeGzKGA-1
Received: by mail-wr1-f70.google.com with SMTP id c14so3978826wrm.15
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tIipyy3cxji7TSg5TkYgKmMY4wP6xoAvP6GDwENCxXs=;
 b=e4jO4Q7/XpDqzc1XMYoV1CqzUqseZuEW/WV1D9Tp9WmGhcQIb2QXaTxaXv1ayeZHXl
 FoL6E+YEFapmZwMY1ho1tuvlKVG9wm8cROEy8UU4XRbo+ivcf5SRSE0Q90wp0bAXsXGl
 iqpZjqRVSibZ0B5p00l+soXVGZhPBdpghTJd9dpZUBd66q29JSkcaSa8lSdLqEC43/r5
 x3VLxeF51aMkgIuebkfVGIWqYDjOjWPrHbBVHgLluM7bP3Tzm7hq+R10Nbg6tAg00Tj5
 byoWRza2uAbQrrFLwxDIQTJFcFjaTsPXkSaJVq9pKAbcOEEL6VVizpZKb60kmls9sqZL
 aAtw==
X-Gm-Message-State: AOAM530bXIppnNp0Us4Y7u7G2b6ERpCDxSmOTMCIX6sC1t39IykLzLiN
 liIn+NY8EvT1T8mk/3iq5nblH5eNXpaK85iYxPcLTgLoj81S9lgHQ6X1nNDSI3a6z0xRGq8tq8u
 thpo0G/8x9X5LMUA=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr13538854wma.148.1591973473709; 
 Fri, 12 Jun 2020 07:51:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsNBee+a5+YUd9sncbeMD/ln4kObwJNlMCXBD/kzA2ThtEmhJSdZ7ydbXYrwMMdhMor3ncHA==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr13538847wma.148.1591973473563; 
 Fri, 12 Jun 2020 07:51:13 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id t8sm10258545wro.56.2020.06.12.07.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:13 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/58] qtest: allow DSDT acpi table changes
Message-ID: <20200612141917.9446-6-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200515150421.25479-2-kraxel@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..6a052c5044 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,18 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/pc/DSDT.bridge",
+"tests/data/acpi/pc/DSDT.cphp",
+"tests/data/acpi/pc/DSDT.dimmpxm",
+"tests/data/acpi/pc/DSDT.ipmikcs",
+"tests/data/acpi/pc/DSDT.memhp",
+"tests/data/acpi/pc/DSDT.numamem",
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.numamem",
-- 
MST


