Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE81C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40781206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuVHJDbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40781206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNbM-0004Fc-4y
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTS-0000V0-G6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTP-0005zk-Bg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMwIRTvAsZv05t/Z/v1VSWCCvEEsjq5LkWRrPd5aQvI=;
 b=BuVHJDbhVHsCQsu3flQepBGD4rfg2net8O8hZkylfLLW+EZPcdN23R7wfpU4gqcdRBnWR7
 lqfMersa+Wv/CromRNN4WmmpLxJaE/mR+meseBJImeEMJevZNzwXBJQ5lh3SzhYlzF7zD3
 tV5hEVna+Qyt1hiv1IF/tsT3/PF/LpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Id6LJKdUPwei4zcffabIIw-1; Thu, 24 Sep 2020 05:23:28 -0400
X-MC-Unique: Id6LJKdUPwei4zcffabIIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB05D104D3E3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:27 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D9CB7881A;
 Thu, 24 Sep 2020 09:23:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/92] doc: Cleanup "'-mem-path' fallback to RAM" deprecation
 text
Date: Thu, 24 Sep 2020 05:21:56 -0400
Message-Id: <20200924092314.1722645-15-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

it was actually removed in 5.0,
commit 68a86dc15c (numa: remove deprecated -mem-path fallback to anonymous RAM)
clean up forgotten remnants in docs.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200911084410.788171-3-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/deprecated.rst | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 6422230fe2..e78d03038f 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -104,17 +104,6 @@ error in the future.
 The ``-realtime mlock=on|off`` argument has been replaced by the
 ``-overcommit mem-lock=on|off`` argument.
 
-``-mem-path`` fallback to RAM (since 4.1)
-'''''''''''''''''''''''''''''''''''''''''
-
-Currently if guest RAM allocation from file pointed by ``mem-path``
-fails, QEMU falls back to allocating from RAM, which might result
-in unpredictable behavior since the backing file specified by the user
-is ignored. In the future, users will be responsible for making sure
-the backing storage specified with ``-mem-path`` can actually provide
-the guest RAM configured with ``-m`` and QEMU will fail to start up if
-RAM allocation is unsuccessful.
-
 RISC-V ``-bios`` (since 5.1)
 ''''''''''''''''''''''''''''
 
@@ -647,6 +636,16 @@ New machine versions (since 5.1) will not accept the option but it will still
 work with old machine types. User can check the QAPI schema to see if the legacy
 option is supported by looking at MachineInfo::numa-mem-supported property.
 
+``-mem-path`` fallback to RAM (removed in 5.0)
+''''''''''''''''''''''''''''''''''''''''''''''
+
+If guest RAM allocation from file pointed by ``mem-path`` failed,
+QEMU was falling back to allocating from RAM, which might have resulted
+in unpredictable behavior since the backing file specified by the user
+as ignored. Currently, users are responsible for making sure the backing storage
+specified with ``-mem-path`` can actually provide the guest RAM configured with
+``-m`` and QEMU fails to start up if RAM allocation is unsuccessful.
+
 Block devices
 -------------
 
-- 
2.26.2



