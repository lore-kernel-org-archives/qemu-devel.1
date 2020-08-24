Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1741AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81132072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfUeDGFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81132072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAF40-0001xQ-1W
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kAF3M-0001OA-VP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:10:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kAF3K-00031w-Cf
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598285431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IKMfpR8LFFqXU42P7wLvK78ryt2+YbDSEEvXx+BdZHs=;
 b=VfUeDGFFtV5PC/vKa+ieKGvr+PNn/sIFNQAFFhGEs+5pUI/xccMGw5ZhW7awAV0EPyQmez
 GqcxIPuTd57HLpkkYgPUm8HFCWuezolw/WIBlSvc0b+0BS068CONHWT0UQNx/5ugbsnz2j
 ed7COz/Br1mXINe6mAnk9g9OW4hCjd4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-xZi1OdlPNseSCEiX87CUnQ-1; Mon, 24 Aug 2020 12:10:21 -0400
X-MC-Unique: xZi1OdlPNseSCEiX87CUnQ-1
Received: by mail-qk1-f200.google.com with SMTP id x20so6735000qki.20
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IKMfpR8LFFqXU42P7wLvK78ryt2+YbDSEEvXx+BdZHs=;
 b=ZYpJEtShxjEad9e2zsIZxI2fYZDXAJ2fPEyc7euM11M8aO8/6f+WN7wdL0ET8a0XBy
 N87PXCxVwMrriNUWJIciUGqA+fhPPASrprWsNTPEGuU3OAOZYj3yxGb4KYI2B5nowGU/
 AAwPSLVBfryF5dXS/VQ7O2eVcfVQSzIeor0rGVrhKUIpM8t40cAEu7YhLAMAxffp3AAG
 C6q1LO+RtokcIHEusDiTsNzic4qf4Cz+duPgn06O5QHAtP13xCkMO+KQ2qQCH5n8poSG
 pV4s0uOau7ObcCrdNg3qFs7vrFsX78/p18rHbNPDfDNVNouPbsX6quRqD0vDGuH3Z9Fc
 L/1w==
X-Gm-Message-State: AOAM532snbwfQvYFX0zLbmVBXRy6f1ofkTK/4Y1B6krpY8+SET/MJl5T
 WTYv7nB6JQ1Btrs1Ly8UNjjsX0E61EGhH+S/a0Tdl2OKN1pL4FL13XFt55E68WcNQXzMi35o9Hq
 jo9VlbMhGVtV+vZs=
X-Received: by 2002:a37:62cd:: with SMTP id w196mr5327932qkb.486.1598285417004; 
 Mon, 24 Aug 2020 09:10:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN8CV4NFB0WNQkM6jKemZlzVt+4hb2PHQE9oi/BT8QvL30Knn7Zkhwzm3gqJWGEMkXvh0SPQ==
X-Received: by 2002:a37:62cd:: with SMTP id w196mr5327906qkb.486.1598285416670; 
 Mon, 24 Aug 2020 09:10:16 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id o47sm11601361qtk.19.2020.08.24.09.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:10:15 -0700 (PDT)
From: Connor Kuehl <ckuehl@redhat.com>
To: pbonzini@redhat.com,
	ehabkost@redhat.com
Subject: [PATCH] doc: fix ioctl name MEMORY_ENCRYPT_OP -> KVM_MEMORY_ENCRYPT_OP
Date: Mon, 24 Aug 2020 11:10:14 -0500
Message-Id: <20200824161014.401882-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just for precision's sake :-)

While we're in there, fix some typos:

  - fix colon placement before a list
  - "provides" -> "provide"
  - "destroy's" -> "destroys"
  - fix a broken link, it had a space where there should have been an
    undescore

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 docs/amd-memory-encryption.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
index 43bf3ee6a5..e4c3f19e6d 100644
--- a/docs/amd-memory-encryption.txt
+++ b/docs/amd-memory-encryption.txt
@@ -18,14 +18,14 @@ ioctls.
 Launching
 ---------
 Boot images (such as bios) must be encrypted before guest can be booted.
-MEMORY_ENCRYPT_OP ioctl provides commands to encrypt the images :LAUNCH_START,
+KVM_MEMORY_ENCRYPT_OP ioctl provides commands to encrypt the images: LAUNCH_START,
 LAUNCH_UPDATE_DATA, LAUNCH_MEASURE and LAUNCH_FINISH. These four commands
 together generate a fresh memory encryption key for the VM, encrypt the boot
 images and provide a measurement than can be used as an attestation of the
 successful launch.
 
 LAUNCH_START is called first to create a cryptographic launch context within
-the firmware. To create this context, guest owner must provides guest policy,
+the firmware. To create this context, guest owner must provide guest policy,
 its public Diffie-Hellman key (PDH) and session parameters. These inputs
 should be treated as binary blob and must be passed as-is to the SEV firmware.
 
@@ -64,7 +64,7 @@ Since the guest owner knows the initial contents of the guest at boot, the
 attestation measurement can be verified by comparing it to what the guest owner
 expects.
 
-LAUNCH_FINISH command finalizes the guest launch and destroy's the cryptographic
+LAUNCH_FINISH command finalizes the guest launch and destroys the cryptographic
 context.
 
 See SEV KM API Spec [1] 'Launching a guest' usage flow (Appendix A) for the
@@ -98,7 +98,7 @@ AMD Memory Encryption whitepaper:
 http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
 
 Secure Encrypted Virtualization Key Management:
-[1] http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
+[1] http://support.amd.com/TechDocs/55766_SEV-KM_API_Specification.pdf
 
 KVM Forum slides:
 http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf
-- 
2.25.4


