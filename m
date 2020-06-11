Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDDBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89385207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+1Dh3JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89385207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU8T-0004LQ-QN
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAt-0002Ta-1o
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48775
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAn-0001Uu-Ci
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYd0ZjqThto94k0nBBkenZImnLZ41UE3/n5FFwZ4lOs=;
 b=E+1Dh3JQlebNd5a6ChLkvhg0TJ2jfikgtpl0cgf103zNAnt/ytzJv8cJH9YEJrWTkSIctq
 PSy2EMPppeAzWKPtZswdOPFjVrZIbrkYyS2ho0QHcqWGK/9zy/ZpcIzub9r6X5obqZAwY3
 wZglaIaoMVf3zdAopg+tZ/UKbXE2rAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-h2Ga8VnuMQq-B1IH6rx_Gg-1; Thu, 11 Jun 2020 15:47:29 -0400
X-MC-Unique: h2Ga8VnuMQq-B1IH6rx_Gg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4062A0C03
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:47:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 897C1707C6;
 Thu, 11 Jun 2020 19:47:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 115/115] target/i386: Remove obsolete TODO file
Date: Thu, 11 Jun 2020 15:44:49 -0400
Message-Id: <20200611194449.31468-116-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The last real change to this file is from 2012, so it is very likely
that this file is completely out-of-date and ignored today. Let's
simply remove it to avoid confusion if someone finds it by accident.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200611172445.5177-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/TODO | 31 -------------------------------
 1 file changed, 31 deletions(-)
 delete mode 100644 target/i386/TODO

diff --git a/target/i386/TODO b/target/i386/TODO
deleted file mode 100644
index a8d69cf87f..0000000000
--- a/target/i386/TODO
+++ /dev/null
@@ -1,31 +0,0 @@
-Correctness issues:
-
-- some eflags manipulation incorrectly reset the bit 0x2.
-- SVM: test, cpu save/restore, SMM save/restore. 
-- x86_64: lcall/ljmp intel/amd differences ?
-- better code fetch (different exception handling + CS.limit support)
-- user/kernel PUSHL/POPL in helper.c
-- add missing cpuid tests
-- return UD exception if LOCK prefix incorrectly used
-- test ldt limit < 7 ?
-- fix some 16 bit sp push/pop overflow (pusha/popa, lcall lret)
-- full support of segment limit/rights 
-- full x87 exception support
-- improve x87 bit exactness (use bochs code ?)
-- DRx register support
-- CR0.AC emulation
-- SSE alignment checks
-
-Optimizations/Features:
-
-- add SVM nested paging support
-- add VMX support
-- add AVX support
-- add SSE5 support
-- fxsave/fxrstor AMD extensions
-- improve monitor/mwait support
-- faster EFLAGS update: consider SZAP, C, O can be updated separately
-  with a bit field in CC_OP and more state variables.
-- evaluate x87 stack pointer statically
-- find a way to avoid translating several time the same TB if CR0.TS
-  is set or not.
-- 
2.26.2


