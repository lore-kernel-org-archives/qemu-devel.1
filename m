Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D52AC06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5B42146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnEN3cQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5B42146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKPT-000884-8L
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIU-0001st-3f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIS-0004v2-9C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hiKIS-0004Ov-17
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id a15so1166185wmj.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=gJ0heN1dGGXTyxKYi/gqfpjh07K3JSRY95r2UM0evD0=;
 b=FnEN3cQygiapU1hjIULN6oNX4hVJrKvQmGVKtmXtFwNfPZD1BUESpXaVslcP6QR5Tw
 PomfRdOxmWYy6E3qYn3DYJJpzNKB9lKmDeFPLC00l8rkNndta6v8gQD0W0A3ez/LL7Vb
 IymNQijyIoV+Rd8xCTUVOJQ/qUl9+fvjluw95X5azNdqaJqZO/MmQ8T4+nGMxBXToF0N
 Non37MQsphHTkXZZ5h+OUt1jV66LcWGC6vq4UNNFHnWJj0/NYuAus/90e5PKAMu6tFRv
 I1c8/YFzmPm2UBpG4c8mp65W2txM5UUQif7yBCfZrcuq/QYqgZxzlfLIDyzHiFHarUA5
 ib/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=gJ0heN1dGGXTyxKYi/gqfpjh07K3JSRY95r2UM0evD0=;
 b=P7lgtXQl19GQn2hapOPKET8/WY3DX1QR9HSymjxMYqfp+pMgX7yl4TcyD12uh2+x5v
 gShtuYr9b26c6Um1AKQkF0SJYvqLBrIoPEaJqpEN5LyLgGsVcTdnU9/DqxPLHmwcVeri
 jq+c4rgO3NyTsihyLby6VtMUBtdoBa1r1aTp5lz07JVx3Kj7ekWEGVRb30vcHXDJ3bur
 pu0ircxfnBR04m2+rK2nG0N8Io6yaEOg7Becu3f1v4A68CMClLO5Bz7L13m1kBKSVEVf
 8DXg0X2BbeFQQflMxCaOvGUScaBeVuC1cbCGfwrD3yRJArKqO/02txcz9yeOzThiB8Vl
 arxg==
X-Gm-Message-State: APjAAAUPzj28kWPwxRA5JLtt0WwNQT9muRCDtJrYZdtNHBsRqVv2MOum
 fskYVIIImTpY1xU/6OOsXGIZ4VR4ZDA=
X-Google-Smtp-Source: APXvYqym/Xgj1OYTlbzo9/oR1kbjWfFrbqNAjI3gRaS4Jfa5CS3MPTMy8DPvHV4KCp9gTLYGmhuBEA==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr3945708wmi.14.1562079683335;
 Tue, 02 Jul 2019 08:01:23 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m24sm3006262wmi.39.2019.07.02.08.01.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:01:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:01:14 +0200
Message-Id: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [RFC PATCH 0/7] target/i386: support VMX features in
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
Cc: Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds support for VMX feature flags so that the user can
enable and disable at will the flags.  In the final version I will
also add VMX features to named CPU models, which will complete VMX
live migration support.  That's somewhat tedious and I didn't want
to do that before getting a general review.

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

Please review!

Paolo

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
 target/i386/cpu.c    | 433 ++++++++++++++++++++++++++++++++++++++++-----------
 target/i386/cpu.h    | 138 +++++++++++++++-
 target/i386/kvm.c    | 173 +++++++++++++++++++-
 5 files changed, 656 insertions(+), 104 deletions(-)

-- 
1.8.3.1


