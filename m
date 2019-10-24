Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB1ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B669320650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXoEhScK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B669320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfGc-0000z1-B9
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjF-0008LG-L8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjE-0007xB-7I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdjE-0007we-17
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id s1so17473487wro.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=ACSSwd4vLiPduucfk8qILiYK3BU6NBbxPynhmSEzC6A=;
 b=YXoEhScKkoeIwTfYdNx/Gv6m/u6kNPKPze0mWwwCVCV3hmU7UNVgefmnmw41th7Rp+
 mZjC7jet6BAgq6QFHKGuYGQVcB/k8CuoRx+Z0xpdESTe4sIiXz3sCkTSA+5psfnEZbZT
 hnBR5fvkkHuqQzFT70VHLeIBfct0yKoOq/pzdJp6aHdnWGVsERR+PNkZHVZDLWRiyQ4v
 oMCZ4SS6QJzexh3bwll0nFREhKrIrXTFZQGLwdfP3c+jMQvUsCsUMALv+uyNXK1FXN1q
 0p8hD3evedbLYF6yJo17raNzCpMdV/TzW8RfQ/281Fbt/DniAOC8+1HbSWMafNbYPb0m
 9a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=ACSSwd4vLiPduucfk8qILiYK3BU6NBbxPynhmSEzC6A=;
 b=lNhj03OERNVT/G+tZ6hli91wl2gRu7lBr5pdQOOFQIzW26Jdf0S6iyWsA1dPBw2JzH
 A3p3SDqQW6zBrk3uaRVFtSShW+FReHh3jksWxv5gNidV3YP8ZEgTDSOHMmMxOPaoXAqU
 jqRRLszm8k3vbdbtUesPMR0Jbhzu0oI3WFBmNpHZjXy9IsSR3mwscj4GJXlLurEqX9MC
 vuN/HfQyVo4CEyAtIcedMp7guXbOdUUjGTmFWWIwIn3yBbohx/I9XXP5eLRTPJ41xfWH
 9V+p/vIPGpztTDLJOoJ0WhCczcHWaI25ywDL9YRhFPPhrdGU695gE+5+EMek61/yq8Bv
 ySYw==
X-Gm-Message-State: APjAAAVZ6Wuv67X3YHayvVjpSz77yK57yvyCHcSCKXrqc2pvKe2llt4r
 ZIqTnBgSfnu2R+QEte4+WYKLhlWh
X-Google-Smtp-Source: APXvYqxQDSGFdpPuxTzYN3MHJYdSlYSzwda4d+Kf9uxWHaQVOqAYtpeAGeGCSf89acBPCLRhsIRDXQ==
X-Received: by 2002:adf:a48c:: with SMTP id g12mr3830271wrb.212.1571925878701; 
 Thu, 24 Oct 2019 07:04:38 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/39] target/i386: introduce cpu_set_fpus
Date: Thu, 24 Oct 2019 16:03:54 +0200
Message-Id: <1571925835-31930-39-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

In the next patch, this will provide a hook to detect clearing of
FSW.ES.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 4db0059..6825024 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1053,6 +1053,12 @@ void helper_fstenv(CPUX86State *env, target_ulong ptr, int data32)
     do_fstenv(env, ptr, data32, GETPC());
 }
 
+static void cpu_set_fpus(CPUX86State *env, uint16_t fpus)
+{
+    env->fpstt = (fpus >> 11) & 7;
+    env->fpus = fpus & ~0x3800;
+}
+
 static void do_fldenv(CPUX86State *env, target_ulong ptr, int data32,
                       uintptr_t retaddr)
 {
@@ -1067,8 +1073,7 @@ static void do_fldenv(CPUX86State *env, target_ulong ptr, int data32,
         fpus = cpu_lduw_data_ra(env, ptr + 2, retaddr);
         fptag = cpu_lduw_data_ra(env, ptr + 4, retaddr);
     }
-    env->fpstt = (fpus >> 11) & 7;
-    env->fpus = fpus & ~0x3800;
+    cpu_set_fpus(env, fpus);
     for (i = 0; i < 8; i++) {
         env->fptags[i] = ((fptag & 3) == 3);
         fptag >>= 2;
@@ -1316,8 +1321,7 @@ static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     fpus = cpu_lduw_data_ra(env, ptr + XO(legacy.fsw), ra);
     fptag = cpu_lduw_data_ra(env, ptr + XO(legacy.ftw), ra);
     cpu_set_fpuc(env, fpuc);
-    env->fpstt = (fpus >> 11) & 7;
-    env->fpus = fpus & ~0x3800;
+    cpu_set_fpus(env, fpus);
     fptag ^= 0xff;
     for (i = 0; i < 8; i++) {
         env->fptags[i] = ((fptag >> i) & 1);
-- 
1.8.3.1



