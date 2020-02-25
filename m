Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3328C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA7B20658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXEzyiJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA7B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aDg-0002Bp-HN
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0V-00043z-BD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0U-0003hN-A5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:11 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0U-0003gu-3J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:10 -0500
Received: by mail-wm1-x343.google.com with SMTP id z12so2724357wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PIafvyQfHwf8flcgdrRq/WGoQSyodU6qPc8agqHB4HE=;
 b=OXEzyiJBxRQHaXtDrUH1R7xedeSGF96CYA6foLLYIqgZT8p02WDSuSnOSBVfbdHxEj
 Bz6qA/pmV7R10Xx0ZvMqstzBChC/PAmF72uM7yHu4t/q31K65l/LnkkDH9x8b2ES+J6H
 Jk1j0YrU1ICdxSbwC9QQ3F6I5pZ4lxx1130Mr2Pi2MHKjrdS6feIJMNHcgeHvfYh/pGR
 MgqM0HlH7LqMYk6WardFvjDAZIWWYLEWTQUrOsQsaPsSLSmdyK8AF6drHjoPJ0bC7Vjs
 KnskMmtoWQkNofu8QJJ93eHOElf3Xx5Pmm+AqiZBjxVNAjL0HCbX6GGPDDe7M/D3D/Q4
 gXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PIafvyQfHwf8flcgdrRq/WGoQSyodU6qPc8agqHB4HE=;
 b=Q6fazOCV3RDDmCwalnKnfgfjHY8KFM3Uzy74aE+zi+RTgDTn5f4Y9YBYmiXrfyQFiK
 OA7p3gQgIOy3/TzR/I2ob7zE8Ry/Vyz3G95Yt6aCK/V5s8HX2kqv4QFmei4Ht1GOo9rw
 RVJNteeKfh3Ufl/1s6XjlnDYiUA6vqAuxEKI/n1dOn7oiDKSKuSTcbSkYRBoU+RMQDRA
 IvX8mqei4EwtXEsslN3jcgd6dJj0Jc5e+1rF8pJ9uETSdh1ZvwOT2yZKklJ9+13wg+a1
 iO67ZAx8/RDGOWryvcS9ZMeR70G40jwVvXoaDarZgy2Z+hVWAx4OEx7aqTaTVsFkVo/1
 NJ5Q==
X-Gm-Message-State: APjAAAUoX4EvDJ09Uxs317KxTxAj4gim2PMZrEDafxrqdj94dgYeiS3K
 7X5O2DheRJVuk1UALE40O3KR2Xg0
X-Google-Smtp-Source: APXvYqz4hfx1FnjqcsgHuVlAOejMe1qP4rWMfqaZJz3H8hbWa+XooknxKEO4vv+RGgP11W6pDvd4Ng==
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr5200251wmg.79.1582632488264; 
 Tue, 25 Feb 2020 04:08:08 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 135/136] accel/kvm: Check ioctl(KVM_SET_USER_MEMORY_REGION)
 return value
Date: Tue, 25 Feb 2020 13:07:33 +0100
Message-Id: <1582632454-16491-33-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

kvm_vm_ioctl() can fail, check its return value, and log an error
when it failed. This fixes Coverity CID 1412229:

  Unchecked return value (CHECKED_RETURN)

  check_return: Calling kvm_vm_ioctl without checking return value

Reported-by: Coverity (CID 1412229)
Fixes: 235e8982ad3 ("support using KVM_MEM_READONLY flag for regions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200221163336.2362-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c111312..6df3a4d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -308,13 +308,23 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size = 0;
-        kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+        if (ret < 0) {
+            goto err;
+        }
     }
     mem.memory_size = slot->memory_size;
     ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
     slot->old_flags = mem.flags;
+err:
     trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
                               mem.memory_size, mem.userspace_addr, ret);
+    if (ret < 0) {
+        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
+                     " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
+                     __func__, mem.slot, slot->start_addr,
+                     (uint64_t)mem.memory_size, strerror(errno));
+    }
     return ret;
 }
 
-- 
1.8.3.1



