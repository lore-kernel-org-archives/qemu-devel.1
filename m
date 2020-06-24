Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80070C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F0E20738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiPchCM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F0E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEWH-00042y-GI
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETY-0008FP-SO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59127
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETV-0001FL-OA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593039996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEBYz/1rOCc1PXQNYXHobgljmWeZgraW/Nx26o3Lqgc=;
 b=SiPchCM3pKMfdHqr/vozTJga0lhPkaANCSsSccPYee2DY+6YLLD18WaDVuzgSfVye1J7Kv
 Ujfy05ByiAtOv2vcS3MuBpRX9Bbim+pJOaJ6IlgEDSSnxIuc01YtDkxxZ8aPOmdJUQKrJ4
 xgJjitSx1dnpODOx19dmfsU9U61XoME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-sSiZUijPP6C3qDywOTEpvQ-1; Wed, 24 Jun 2020 19:06:33 -0400
X-MC-Unique: sSiZUijPP6C3qDywOTEpvQ-1
Received: by mail-wm1-f70.google.com with SMTP id g187so4665061wme.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yEBYz/1rOCc1PXQNYXHobgljmWeZgraW/Nx26o3Lqgc=;
 b=a6OBDVAR9ZG5HPpGGLMpL7lBBDwVIST0AygteiL+LMIWpf2R0ffX2JRyNs+CHsOrkm
 3qabw0bFu5I6JZaDUe+3Tsqe9ZqtdOYS2uXQt4rJK0erUj7vI8laBlT5DDBDadKZUSvl
 /RFmUHLCgGN9/ntY1wKo2p3/XBZSWmbHltGAnh500yDDitepXoqBNpe4PWeqbxHkJf0P
 dQJj5knUhy1w0TggWvL1dRa0qKBwVhhwK4cmCvE1eVyeZ76vau+7dBBoSb65ktLsAIgx
 hcAE/wO1ziGegu8qdKCg34D83ja+BSIdh9v+rzZQM+cVTRcFf+/nVoHHYoXmybFRuYds
 Z1rQ==
X-Gm-Message-State: AOAM533lLwFNVpEa1oznRjUbzBAne8Ya1GC7Y44RPIk1Ko8FHspY8XYr
 c8EdzzCfleakfueia5thGTWiErqKokaLyKwzn+NU3VeNzspWdRetOmoTLqKwyxzgAivUwEg12f0
 Mgv6D2qFecRr2Aek=
X-Received: by 2002:a5d:6107:: with SMTP id v7mr32849297wrt.174.1593039992425; 
 Wed, 24 Jun 2020 16:06:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkpBhYqoNFCWvxqzVFvefHVuz9Owc83laJA9ZQUI/co/ll1ZIUNGqyLO5yLI7014U4c4Ok6w==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr32849281wrt.174.1593039992233; 
 Wed, 24 Jun 2020 16:06:32 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 t16sm7036094wru.9.2020.06.24.16.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:31 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] qtest: allow DSDT acpi table changes
Message-ID: <20200624230609.703104-2-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Message-Id: <20200619091905.21676-2-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..8992f1f12b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,19 @@
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
+"tests/data/acpi/q35/DSDT.tis",
-- 
MST


