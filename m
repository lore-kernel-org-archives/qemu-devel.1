Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E9AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74A420756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu26BOEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74A420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTrA-0005Yj-Hi
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmS-0000Rt-AV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmP-0000Rh-Ke
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smveN6Rzbijww7fMqUTE3pDIKVjvYutAyE50uFiM4wM=;
 b=Wu26BOEq1hFX+yeQmadOGe5swZADmGF7OcDju5MET+gco5VdB+Rti/PXeWiJjO4RngON5l
 KlWZOjF1SwC/wGuc2qBI+E1Oe0iyuhf68vpN5joRHuzJWsQkJeHBlgWMdJogmRw8gti7Ms
 FRIhwrd8Iz5tmOwDgOyIgnqNbvj0xbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-ylUlWg9DPLyAIDBNyiozmg-1; Fri, 30 Oct 2020 08:45:14 -0400
X-MC-Unique: ylUlWg9DPLyAIDBNyiozmg-1
Received: by mail-wm1-f69.google.com with SMTP id t21so583338wmt.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=smveN6Rzbijww7fMqUTE3pDIKVjvYutAyE50uFiM4wM=;
 b=OeQTA3D6+LNTN0d8vZmEHMTKto5M0m4r2DmAgF5aRY8DiqlTOjZrzMiJhfCSPEB1pR
 ZxfBgJXcAcbef60dIsIExCQZSEnd1Gc8Z77S/6ddwA3VTwRt8dOnALY+j7i5xTvkSQzM
 cYlN9oxsZso9GFOd4/bdRODoGgz3hRDFZrwiWmZ6nwKWFlVBQerav3RV4ivgmqZWdOs2
 aUmnY56Mr+1XgojkquCY+p46ERGCyagAs+mzqrCVGd2hakhPBH7+G+a08DoOFrpIaGEV
 DUOs2XdSNhlmvJ7YoUpIISX6ZYGGx0UOiWNZ1Cz5bk1g/Jq8SocG4A4Ht7nkWsF3HdI6
 DOxw==
X-Gm-Message-State: AOAM532C14PNT9TXVOg/Czdc3IMcV2JfBaqaMv7pCOI+aNvguoAAb4Y9
 Sqg8Wivsur6dkDWotiHhOJnRm97332H73HPfzZliMRmkrDkGmwW5zzksP5OhpPQFTfFPAZ5oWPT
 c8CzUUCy9+0FKY0c=
X-Received: by 2002:a1c:190:: with SMTP id 138mr2348070wmb.113.1604061913431; 
 Fri, 30 Oct 2020 05:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUK2Or34hHYTLReg6pGYXi/hTH0MSt7yDxOZBFmolRsJrR1WASsmn2AWTmub0QRS/C609EAw==
X-Received: by 2002:a1c:190:: with SMTP id 138mr2348046wmb.113.1604061913179; 
 Fri, 30 Oct 2020 05:45:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id p9sm4466695wma.12.2020.10.30.05.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:12 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] acpi/crs: Prevent bad ranges for host bridges
Message-ID: <20201030124454.854286-4-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Ben Widawsky <ben.widawsky@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ben Widawsky <ben.widawsky@intel.com>

Prevent _CRS resources being quietly chopped off and instead throw an
assertion. _CRS is used by host bridges to declare regions of io and/or
memory that they consume. On some (all?) platforms the host bridge
doesn't have PCI header space and so they need some way to convey the
information.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Message-Id: <20201026193924.985014-1-ben.widawsky@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e3a4bc206c..98ff9f5cef 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -866,6 +866,8 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
     crs_range_merge(temp_range_set.mem_ranges);
     for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
         entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
+        assert(entry->limit <= UINT32_MAX &&
+               (entry->limit - entry->base + 1) <= UINT32_MAX);
         aml_append(crs,
                    aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
-- 
MST


