Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DABC3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 09:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A93F20880
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 09:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A93F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyv69-0006ND-OG
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 05:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hyv4y-0005Od-5k
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hyv4w-0007Tw-8t
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hyv4w-0007RV-3Q
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so4363136pfq.12
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 02:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WN15kRwUIpiTgqZ6FcyxFvfA5gnKgrwg4P1J0yV6K6o=;
 b=Pqu0nVmj7EokfZby/htYfUFexU6A8QwYLvzuTyD9Z7AsIk8oYAXVo25RTG676pas+j
 PbiVJBGx0d044oaDPq11mTQocE26dIIJUXwpOlAcoJWbHIkle1CtsJwaPegALp+ZSxpj
 4QrpjtDYOEc7vsWlWl5xcEB/G2tM9y+VkL3yrs79mN2k6QM+PR8lKngJLKnPUoVD6Cj1
 1gqLySwMc+4iJUeAW4rlu+Rh/XmoMJd+0/ofMffl5eBSv9zbLJxPD8GBKP2wKH5LfVAl
 6Or+cITC8nNpTR3Zz7cNjwYhfqgRVnMJbx7sZvsdHnzM8H5Nu1G8t7LRM0U4LY/+WFKK
 rZAA==
X-Gm-Message-State: APjAAAUg2rmNB9gfn0Bw1aAC1qJrDk8ShL9XJhvO/gWDJC3BZxm8scqR
 NJClpX5I73J/NoqKuHS1jJgyp6vdqUU=
X-Google-Smtp-Source: APXvYqw920/AbB6wKvP1StqQD7u7SovqwMByLKDmJn4uT9R7iS/S6VUFWmP+krDO6m/tkTgV7XqkCg==
X-Received: by 2002:a63:69c1:: with SMTP id
 e184mr10770165pgc.198.1566034368671; 
 Sat, 17 Aug 2019 02:32:48 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y23sm9821473pfr.86.2019.08.17.02.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2019 02:32:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 17 Aug 2019 17:32:35 +0800
Message-Id: <20190817093237.27967-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
Subject: [Qemu-devel] [PATCH 0/2] memory: Fix up coalesced_io_del not
 working for KVM
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I can easily crash QEMU as long as KVM is used with e1000 and reboot
many times, then I hit this and QEMU aborts [1]:

  kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device (28)

To reproduce this issue and also to avoid rebooting so many times,
simply dump the devcount from KVM would work too with this patch
applied to kernel:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c6a91b044d8d..c4f1e8a5a93c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3841,6 +3841,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,

        memcpy(new_bus, bus, sizeof(*bus) + i * sizeof(struct kvm_io_range));
        new_bus->dev_count++;
+       pr_info("%s: dev_count++ (%d)\n", __func__, new_bus->dev_count);
        new_bus->range[i] = range;
        memcpy(new_bus->range + i + 1, bus->range + i,
                (bus->dev_count - i) * sizeof(struct kvm_io_range));
@@ -3879,6 +3880,7 @@ void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,

        memcpy(new_bus, bus, sizeof(*bus) + i * sizeof(struct kvm_io_range));
        new_bus->dev_count--;
+       pr_info("%s: dev_count-- (%d)\n", __func__, new_bus->dev_count);
        memcpy(new_bus->range + i, bus->range + i + 1,
               (new_bus->dev_count - i) * sizeof(struct kvm_io_range));

Just watch it increase with reboots...

After some digging, it seems to be the coalesced mmio device that
overflowed the kvm io device count.

I suspect it's not working from the very beginning when the coalesced
interfaces were introduced...  We had a fix for the addition
previously but it seems that the deletion part was still broken.  This
patchset tries to fix the two problems related to the deletion part.

IMHO the 2nd patch is a workaround of KVM in that KVM should allow
KVM_UNREGISTER_COALESCED_MMIO to work even if the user specified a
very large zone that covers multiple mmio devices.  I've a KVM patch
for that, however I didn't send it because it'll slightly change the
syscall behavior (of course it won't break any existing users in most
cases).  Please shoot if anyone thought I should post that for good.

I _think_ this should be needed by stables as well because e1000 is
still widely used (is it?) and triggering it is still not that hard
(simply reboot enough times, this should be even worse if we got more
MMIO devices, e.g., multiple e1000-like devices). I'll leave
maintainers to judge.

Please have a look, thanks.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1741863

Peter Xu (2):
  memory: Replace has_coalesced_range with add/del flags
  memory: Split zones when do coalesced_io_del()

 memory.c | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 8 deletions(-)

-- 
2.21.0


