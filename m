Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37743C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0329A21852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL2+eViL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0329A21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAsW-0004iz-91
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAop-0001mg-8t
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAom-0004wx-WD
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iAAom-0004wQ-Oz
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:44 -0400
Received: by mail-wm1-x344.google.com with SMTP id v17so2494491wml.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=/z9SS3aj3ILltt5rbzKWR8Zbvnqbu1rZVYr/9dq97bs=;
 b=EL2+eViLMooVCGfmQgEsXIe24p1fr7JzD6TJKjelfivDKwQmZ7oh/ANgQFPXWx2rt5
 GmisNQtA+pQWS47tZI269G0D8UMr+YZT6oqdkRW8XOSbJxzRC3rLUuSdbsdZvdC/WpWW
 oFyUyBmO9Ssw5qIcUH1kZpGvWB6HHt2sX87LRvV2Zur0KcscO07hVaD/bb05ZKJ9Qe+I
 dLD2tIWJgoPjGqgMVFfMsD6ATi3NDwuG7IipmJTj8oOYvo27I1WP81wLZN7it+dbhPjZ
 2Q75JtF8lBENVOahc4XMdO7eybjsKUMAH3jX6BSjgGZkia/TJJXNEO119uxrcM+pYXqo
 7uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=/z9SS3aj3ILltt5rbzKWR8Zbvnqbu1rZVYr/9dq97bs=;
 b=lHocffE4cWa9KYp6FxC9REqrz8lrLKDuk74neBB/25AEK+1wlzfEezdk6eB0KPdxsQ
 75VCuYCWKPbkizz3mePtW7qQv4C4BM+FnGvZkD0DsAN2tnaRT4CgKpbnJu+AA4haRwd+
 w5NIp5xILbp/9CVmb3A4fpySXJMynsSpPpLZM1AR0G2WYAG8w3Vk9o3Zsjx7JOM8MjG6
 S748MPVc+sYMrrgsRwDGNPbmocSncBxj3xp/FMpbnqgusAzsGXmH2hZ2BMgoqAcWNbF0
 82QqM5VRJriAP24XHipLe54FeRhwM1FzwWgBjazpk7rljqle6YAXxOFH0jGEPoIhoqF3
 ErFg==
X-Gm-Message-State: APjAAAW7DrLvtHtvwZHGcee17lw8ZbmnAGHc6XcXKpMmxo2E8fh1inPh
 5WjzEWlxW2NukBasS4cxIkbVp+pI
X-Google-Smtp-Source: APXvYqy+OdFay5hNh0InGfSKTjgEDJkhENch8Ly1hGgKvZCrTs5+GCds3ZXtK5cljN/B8DGG3oBx6A==
X-Received: by 2002:a1c:cf4e:: with SMTP id f75mr2756559wmg.49.1568716482787; 
 Tue, 17 Sep 2019 03:34:42 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q3sm1985415wrm.86.2019.09.17.03.34.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:34:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:34:33 +0200
Message-Id: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 0/7] target/i386: support VMX features in
 "-cpu"
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
Cc: liran.alon@oracle.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds support for VMX feature flags so that the user can
enable and disable at will the flags.  A separate series will
also add VMX features to named CPU models, which will complete VMX
live migration support.  That's orthogonal and somewhat tedious.

There are a few complications, which are tackled across the series:

- KVM ioctls fail for some invalid MSR settings, namely when some
  controls are reported as available but the corresponding CPUID
  bits have been disabled.  For backwards compatibility with
  e.g. "-cpu host,-rdrand", these VMX features are silently
  dropped (patch 2)

- some VMX MSRs have features in the high 32 bits (patch 3)

- some VMX MSRs have values in the high 32 bits, but only
  actually have 32 features; this is handled in patch 6 by
  mangling the result of KVM_GET_MSRS

- KVM has a couple bugs that can be worked around relatively
  easily (patch 6 and 7)

Paolo

v1->v2: do not consult check_cpuid/enforce_cpuid in mark_unavailable_features
	introduce struct FeatureMask


Paolo Bonzini (7):
  target/i386: handle filtered_features in a new function
    mark_unavailable_features
  target/i386: introduce generic feature dependency mechanism
  target/i386: expand feature words to 64 bits
  target/i386: add VMX definitions
  vmxcap: correct the name of the variables
  target/i386: add VMX features
  target/i386: work around KVM_GET_MSRS bug for secondary execution
    controls

 include/sysemu/kvm.h |   2 +-
 scripts/kvm/vmxcap   |  14 +-
 target/i386/cpu.c    | 443 ++++++++++++++++++++++++++++++++++++++++-----------
 target/i386/cpu.h    | 136 +++++++++++++++-
 target/i386/kvm.c    | 173 +++++++++++++++++++-
 5 files changed, 665 insertions(+), 103 deletions(-)

-- 
1.8.3.1


