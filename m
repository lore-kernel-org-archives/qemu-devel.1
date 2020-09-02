Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA80C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A889120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRrR9e1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A889120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDScF-0005Io-R0
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMa-0006R6-H6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMV-0007A8-C6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJINUlrbOh9CRinU9oksUQxkJN23nsr9dJ80VojDCLA=;
 b=gRrR9e1rddUOV0XT8up2bSu9u8qogr6GLmbi8RrCNspywX/uD34q3JTMyYZVp70JCqgYZz
 q+nZeUDNRo9IGWDyS9RGQYfozrrYjhkS+5C5LhAXgWMuCvra6/BL1vcqdRBHJwgrwdd3m8
 2ENFdBTm+Fj4iORQYFK22Ewuauv3Iqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-DARaZT6gMDO_oli4irB6_w-1; Wed, 02 Sep 2020 08:59:37 -0400
X-MC-Unique: DARaZT6gMDO_oli4irB6_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333CA801AEF
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01CB85D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/39] docs: suggest Meson replacements for various configure
 functions
Date: Wed,  2 Sep 2020 08:59:17 -0400
Message-Id: <20200902125917.26021-40-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 28492cfcae..591e93f4b4 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -125,23 +125,27 @@ developers in checking for system features:
 `compile_object $CFLAGS`
    Attempt to compile a test program with the system C compiler using
    $CFLAGS. The test program must have been previously written to a file
-   called $TMPC.
+   called $TMPC.  The replacement in Meson is the compiler object `cc`,
+   which has methods such as `cc.compiles()`,
+   `cc.check_header()`, `cc.has_function()`.
 
 `compile_prog $CFLAGS $LDFLAGS`
    Attempt to compile a test program with the system C compiler using
    $CFLAGS and link it with the system linker using $LDFLAGS. The test
    program must have been previously written to a file called $TMPC.
+   The replacement in Meson is `cc.find_library()` and `cc.links()`.
 
 `has $COMMAND`
    Determine if $COMMAND exists in the current environment, either as a
-   shell builtin, or executable binary, returning 0 on success.
+   shell builtin, or executable binary, returning 0 on success.  The
+   replacement in Meson is `find_program()`.
 
 `check_define $NAME`
    Determine if the macro $NAME is defined by the system C compiler
 
 `check_include $NAME`
    Determine if the include $NAME file is available to the system C
-   compiler
+   compiler.  The replacement in Meson is `cc.has_header()`.
 
 `write_c_skeleton`
    Write a minimal C program main() function to the temporary file
-- 
2.26.2


