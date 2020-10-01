Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F4C47423
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89632085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kry9AVeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89632085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Tk-0005jc-1b
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Kw-0004Oc-Fb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Kq-0004FD-O7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D38Rl8stPDowIAHnj4YR4yXUaHyYT1kHxdVb7Vz4dLo=;
 b=Kry9AVeFboHb98lHfqocXeg1Vx3qRNDk4mKUGAauEUDIehwhlWN9ZE54ObD3TdIZN5O2wR
 uENJBeAwlA9snv0KF5f9aWDjk1FB3ze0LLCHzdE3K4VLRZzeDkfsqbdYWmPGt1h9bCoAqz
 1POcgFLrhgA2NMANLBfhtV3UtrycudM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-J6nLmgWyMUu4a7JhvsMGmQ-1; Thu, 01 Oct 2020 13:25:33 -0400
X-MC-Unique: J6nLmgWyMUu4a7JhvsMGmQ-1
Received: by mail-wr1-f69.google.com with SMTP id a10so2290068wrw.22
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D38Rl8stPDowIAHnj4YR4yXUaHyYT1kHxdVb7Vz4dLo=;
 b=f/K2yyxT8uX9w2q01c2EKgJwvS6i9Kegl+HbRporI5dEFu1FrmMBN/l8499VKba1pj
 vPiKtogYwvhRRnN+Bhft5Qiksq5yyge6T98LXr7pfxx89oQWhQykfSxnNLNMOnBBHGRj
 y3Kf1YYhoBfKh8MvckpjDmiD8J/91dfxJqDceDWF/FTf7+DbtJwHILKtm3BeOa/Nnurp
 eDy8Ofk0Og1mfjillbKNecuS3k1uNtyP/YyRZkTAU90PZt7NTy+PPxqW2B5DPjF3Nnbc
 3pTFvBRFbe6nWwippPAljg/mdqtsHhKftcIYPETSXlu1+N0e2ug47evQWdGa6GyDqqtg
 /cNw==
X-Gm-Message-State: AOAM533+ge07l6KfVD80q3h6S3IbxIEHIZnH26jc0nySWXGZTuokbJ1M
 lBRGF1936XNg8fF7Mx3P/LOVmnv+jAApx0DfX3kuWVBZCZ0bSitIqXkMfY1RWGouqPELCsfIcsT
 h4qMh7y9fwxejgM4=
X-Received: by 2002:adf:f80a:: with SMTP id s10mr10826933wrp.351.1601573131718; 
 Thu, 01 Oct 2020 10:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5u1Y98czRZyz399fxOS74PBTWqTEND2+WAOqwJU68kXF1PABB8dUoiALGfqLUPtLwxKerGA==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr10826918wrp.351.1601573131504; 
 Thu, 01 Oct 2020 10:25:31 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id e19sm2388302wme.2.2020.10.01.10.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:25:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 02/16] docs/devel/loads-stores: Add regexp for DMA
 functions
Date: Thu,  1 Oct 2020 19:25:05 +0200
Message-Id: <20201001172519.1620782-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001172519.1620782-1-philmd@redhat.com>
References: <20201001172519.1620782-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/devel/loads-stores.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9a944ef1af..5b20f907e4 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -477,6 +477,8 @@ make sure our existing code is doing things correctly.
 
 Regexes for git grep
  - ``\<dma_memory_\(read\|write\|rw\)\>``
+ - ``\<ldu\?[bwlq]\(_[bl]e\)\?_dma\>``
+ - ``\<st[bwlq]\(_[bl]e\)\?_dma\>``
 
 ``pci_dma_*`` and ``{ld,st}*_pci_dma``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.26.2


