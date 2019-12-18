Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E06206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKdL18c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E06206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYw3-0000Ro-VI
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3y-0007S2-C1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3w-0003nm-PB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:22 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3w-0003kB-G4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so1622249wma.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0G5D0ozjbHj5sAqDM4QYNat78/7TY1w8UX8v8w/OBsk=;
 b=BKdL18c7czG/3xjwhDSrZp/ZzKXZ28lSa1V3d9DP4+mCxWJejAuCivVYqWy2yBONLk
 We7tvBXfig52phPpYnoUC2wiC3Qen24GT1Tb6S7611BmIG6zK6RmScRVyezfHtZF7lex
 hqZkxw4OTyUBpjsuOliqv/pzn6OmWcxIvGs2bqGtwgQwQNkI9IAJg9/EInY5TobuSP8c
 0v2IPAraiREaKk8TJTGeVMpf1u88t7vv3zhM7/F5yghPuWAe6WK4/vzH5119L3kD6j5I
 Y5xkcE+eMaOKa0R4OaltHjZqkPCPYxS3OCtbqIrb+qVDpi9Aa+rGD7aITRas5bOy3SMy
 mqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=0G5D0ozjbHj5sAqDM4QYNat78/7TY1w8UX8v8w/OBsk=;
 b=m59WvFx/HDJoE7vd+WU6Iw3Xr1ojBm1x97LYKjhWq0sLC+pZjoa0hZlGolFA5HjapY
 2wZ9Dfsmcv/73A4OnQDJbsTASOc8V6TAVg71QY012/HN3j1dDGcdR1JcOuAiYnULNSDh
 vjjdFMezOApYyUmGREqGIG4ttGwhruMnmBFFFO7V/B3d30AMvLpJALezEyjOVE+ZkJkb
 xDl3uj5yReqKcmaZephPLbxeSHhlHmGSmJhE06PBrMA7E7YWYA0QKW/jeC+RUzPDZogY
 J/66FgDIJu0UazOtzMhUVP6TmhuDQlkW3ntgJ1M8TtUVpIdb+2ezpnc1g/CbUM0cmIAL
 t9pw==
X-Gm-Message-State: APjAAAVMLf+2mjR/FqPelAQbLEVE3+4jVTmxYIxhQPEattNn6sRrCtCP
 RHFip1G8ZDVPPkjBqOtfoXQoxN6B
X-Google-Smtp-Source: APXvYqxwKOo7DrrNMdzXevWWUh1hU3KTPdRJfbFrViw5UsR7+XxxoTqrJN+LymYMXjQW37sv6MOVdw==
X-Received: by 2002:a05:600c:20c7:: with SMTP id
 y7mr2945346wmm.21.1576670659252; 
 Wed, 18 Dec 2019 04:04:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 76/87] Fix some comment spelling errors.
Date: Wed, 18 Dec 2019 13:02:42 +0100
Message-Id: <1576670573-48048-77-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cameron Esfahani <dirty@apple.com>

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <086c197db928384b8697edfa64755e2cb46c8100.1575685843.git.dirty@apple.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index b6720d8..0c96531 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -261,7 +261,7 @@ static int cpu_pre_save(void *opaque)
      * intercepted anymore.
      *
      * Furthermore, when a L2 exception is intercepted by L1
-     * hypervisor, it's exception payload (CR2/DR6 on #PF/#DB)
+     * hypervisor, its exception payload (CR2/DR6 on #PF/#DB)
      * should not be set yet in the respective vCPU register.
      * Thus, in case an exception is pending, it is
      * important to save the exception payload seperately.
@@ -271,9 +271,9 @@ static int cpu_pre_save(void *opaque)
      * distinguish between a pending and injected exception
      * and we don't need to store seperately the exception payload.
      *
-     * In order to preserve better backwards-compatabile migration,
+     * In order to preserve better backwards-compatible migration,
      * convert a pending exception to an injected exception in
-     * case it is not important to distingiush between them
+     * case it is not important to distinguish between them
      * as described above.
      */
     if (env->exception_pending && !(env->hflags & HF_GUEST_MASK)) {
@@ -415,7 +415,7 @@ static bool exception_info_needed(void *opaque)
 
     /*
      * It is important to save exception-info only in case
-     * we need to distingiush between a pending and injected
+     * we need to distinguish between a pending and injected
      * exception. Which is only required in case there is a
      * pending exception and vCPU is running L2.
      * For more info, refer to comment in cpu_pre_save().
-- 
1.8.3.1



