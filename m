Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D830FC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7395320874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSq56Hzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7395320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKK5X-0007cP-HM
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK18-0002nZ-SU
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK17-0000gH-1U
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600687796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hYvdz2qitSdqwuTuePQGMPUpQ1ZwS4Y5kaurOk3sFU=;
 b=RSq56HznwBZ0cROdy9sDfBdm/p9e9k7lE3e+lsC9UEvDsgF2DwqL1lMc4j6IIR57DfU1nJ
 A1hiUSDSj6xEmZQ75go88AJ+UQAbEn4QLsnO5GZsZJePhgrgvyP+mZIrLyNginuniBDeN7
 BHq1DOIcqCIOm861wa82rKCTwn5IUgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-ytF-OL9XNNK7jdZh3lTmpQ-1; Mon, 21 Sep 2020 07:29:54 -0400
X-MC-Unique: ytF-OL9XNNK7jdZh3lTmpQ-1
Received: by mail-wr1-f72.google.com with SMTP id l15so5740056wro.10
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5hYvdz2qitSdqwuTuePQGMPUpQ1ZwS4Y5kaurOk3sFU=;
 b=lZtrTnoLWZZqcELzneKXEY+t4phf3REsIDuEeMRnD8h0TsSP3LXVY28LalLYdzXJ4P
 ThdcK8WqIizf2H7oMzL9IDZ1fsDYl9h8tj9uWZJYa9rJa1LNx8dRQZps0IZjpOcwviwb
 /Ki29tgIBOzh81POSB5avbe5GOEe9vaBPUzt+yZ9j6bA2sPDCyHVhCdzKxzwLC8I/Xdd
 0pEeCO5AgPFhC0CBr6odK1ocaLm66x+y1teSb0fgvXxfPQy90cwIewF+SLoK+7oscXK9
 oyObX0uKjXN1fexMeYiatiYdzHh1ZtmuF8Q8OxerkL4LN/8h5jUn/2XACt5XLXgbVtyp
 drIQ==
X-Gm-Message-State: AOAM533fZWZypySjPMULonSOPPd+0kC5ERMfQqXecFXaGQsxMp8gWo1h
 T4LQ/2c4oSaGDvK8At1c5DHmiBHCKhY0l1PkPCe3OfjJJoTDYiRORZpqLNldDO6umDyNi/i24MS
 NlzSlgQyuCHUmgxg=
X-Received: by 2002:a5d:404b:: with SMTP id w11mr29629986wrp.24.1600687792688; 
 Mon, 21 Sep 2020 04:29:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWzGul82DBCE24ot+3BrzsUZoKWx7HELF2uzOjxmIznYPpqVAhf/Ka5NeHZA6eawyWZqE5IA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr29629969wrp.24.1600687792566; 
 Mon, 21 Sep 2020 04:29:52 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id f12sm19067282wmf.26.2020.09.21.04.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 04:29:51 -0700 (PDT)
Date: Mon, 21 Sep 2020 07:29:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/15] pc: fix
 auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
Message-ID: <20200921112913.555392-6-mst@redhat.com>
References: <20200921112913.555392-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921112913.555392-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Unfortunately, a typo sneeked in: we want to set
auto_enable_numa_with_memdev to false, not auto_enable_numa_with_memhp.

Cc: qemu-stable@nongnu.org # v5.1
Fixes: 195784a0cfad (numa: Auto-enable NUMA when any memory devices are possible)
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200820094828.30348-1-david@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 622d039717..e1c415f57d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -382,7 +382,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
-    m->auto_enable_numa_with_memhp = false;
+    m->auto_enable_numa_with_memdev = false;
 }
 
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
-- 
MST


