Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F23FC468A7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87D82133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJrrVdOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87D82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUIe-0002Re-63
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEQ-0005ZP-A6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEP-0004DB-D2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEP-0004Cj-6U
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id a10so9869667wrp.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JvV1iVqyAdHF++s4qbNgPhXah3+qiDNHrezSixoPhkU=;
 b=uJrrVdOk7q43i0HZsmCIPUc/TBYmv9/RHoDKVZZoLoKvFfSlrGtrySIM0vfpPf2C4X
 IhNU/vw0drcBOHJNn4pINAdwlMa+DlDi7HjXS7kQlI0M9lcWQElLH9TOKi9KGeV4qpfl
 XOCRjqAYNQQ1DyncI0e9hU7y42G+T3Cs5/9/vBjRUpCM/1ODrQBrrB4jCWxw2RWuFbIv
 gjrEZdcY6Vxw2eiQWbAa8LjsTVTqg1RQ8OLLb80CT0Jspbwpb4MSuB5og31E21zMZ2Nj
 vVSpvOeRfcmWYc7g6gIoVyuLE5Jr3bZQcxZUpIYvsEARJ4dpYcIuuVLyQihwXngB7G3B
 nAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=JvV1iVqyAdHF++s4qbNgPhXah3+qiDNHrezSixoPhkU=;
 b=hd6sqJZlC5D/JKiW9CyLbhPmle4fjazEJvt0UbKuq7toY4Mz2ABZLijS9rzF7eHLJx
 RA1XD48kJFm2rN8iq2GC6aZ5uz/XeKF4SGpVn/O1Ge9sNOf/yMcQVjr/OrZPIrOffVAy
 xGxnrvqNFlEPo7FFj1/Eh+9J5PQXj5O2A45Wj6yH8/QLlehDBbdX1guppIK834kdxYml
 DGtv7PtU66ogSzyFfAbO1lpIijbyo0Ta66hkntX8hPuIY0pVA8zwBgI59p/NHuDTY09U
 4/9wKKxrhIoDuFjqY0gTosZ3Alm5Hjwvgoo6HhOYVOmrimE82cGByun0YHFQ9fMSI1ss
 drqA==
X-Gm-Message-State: APjAAAVUj85fojgZenjmziDu6/i9xMjEaN3DP4WkUlaXFy9njrTPY6AI
 Rwedg3kp911Mwr8UU1y7z5Jjg+EeI20=
X-Google-Smtp-Source: APXvYqy6aaKv2FTeR8AcrAMfDyJTfOPqmnt9qnEPkjb0hUjRQlgbkyHFVESRpa+i/c9QR6huE+NGrg==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr4903101wrw.73.1562356251921;
 Fri, 05 Jul 2019 12:50:51 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:36 +0200
Message-Id: <1562356239-19391-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 09/12] target/i386: kvm: Fix when nested state
 is needed for migration
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

When vCPU is in VMX operation and enters SMM mode,
it temporarily exits VMX operation but KVM maintained nested-state
still stores the VMXON region physical address, i.e. even when the
vCPU is in SMM mode then (nested_state->hdr.vmx.vmxon_pa != -1ull).

Therefore, there is no need to explicitly check for
KVM_STATE_NESTED_SMM_VMXON to determine if it is necessary
to save nested-state as part of migration stream.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190624230514.53326-1-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/machine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 851b249..704ba6d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -997,9 +997,8 @@ static bool vmx_nested_state_needed(void *opaque)
 {
     struct kvm_nested_state *nested_state = opaque;
 
-    return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
-            ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
-             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
+    return (nested_state->format == KVM_STATE_NESTED_FORMAT_VMX &&
+            nested_state->hdr.vmx.vmxon_pa != -1ull);
 }
 
 static const VMStateDescription vmstate_vmx_nested_state = {
-- 
1.8.3.1



