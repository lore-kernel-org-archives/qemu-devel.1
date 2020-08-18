Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5BEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2315420786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9lwWj0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2315420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82Rn-0008Sq-Am
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82K7-00038H-CB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26974
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82K5-0007Jm-D3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgLa8OOgysOf7Sl9OK2QDbGQukQVDXrVrkDaQKpgc84=;
 b=B9lwWj0JTqFvQZbv2K6N8I1w0wgQAsr1M2B96RGrV377apaGXa053V3rYtXLPVpXi1j3D2
 8PmIZpYaSXZz4myzOKtl5gemzBQrWZqYKYos+CRPecDr2WOFnyuKtB/vtc9GV47n7N9YbC
 OohyhL+xoQ61OpQRLShC8xwmxetdgvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Fc_335iuM3ukUEwAYruWHQ-1; Tue, 18 Aug 2020 10:10:42 -0400
X-MC-Unique: Fc_335iuM3ukUEwAYruWHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E1DD100CA8A
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C938BA63
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 015/150] tests/vm: include setuptools
Date: Tue, 18 Aug 2020 10:08:10 -0400
Message-Id: <20200818141025.21608-16-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They are a dependency of Meson, so install them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/freebsd | 1 +
 tests/vm/netbsd  | 1 +
 tests/vm/openbsd | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 29252fa4a6..b34b14fc53 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -33,6 +33,7 @@ class FreeBSDVM(basevm.BaseVM):
         "pkgconf",
         "bzip2",
         "python37",
+        "py37-setuptools",
 
         # gnu tools
         "bash",
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 2e87199211..93d48b6fdd 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -31,6 +31,7 @@ class NetBSDVM(basevm.BaseVM):
         "pkgconf",
         "xz",
         "python37",
+        "py37-setuptools",
 
         # gnu tools
         "bash",
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index dfe633e453..7e27fda642 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -30,6 +30,7 @@ class OpenBSDVM(basevm.BaseVM):
         "git",
         "pkgconf",
         "bzip2", "xz",
+        "py3-setuptools",
 
         # gnu tools
         "bash",
-- 
2.26.2



