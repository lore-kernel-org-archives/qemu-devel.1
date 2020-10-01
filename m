Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6ADC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA46020780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieo3OqZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA46020780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzo4-0000Qz-Tn
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzml-0007O8-U2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzmh-0002EY-0f
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601563334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yfzTgNqzLiEFc/cAfA6GXjB7CpjC/0vuJpK739XCM10=;
 b=ieo3OqZk1B7w7aFXsJXoR8ORa1PYmzJjy3ZPhneBIC0uF9BvjNznqnjpMBMSlnMzieC1uH
 ujBg87yBra/Mmi7OBavPCTZHgz52LrB2oaUe0GprJx2YQflifgW1Qi03YlmGIZNTlf+l/T
 sWY1yUh+fWyvjSs2sBMBeOpEJMAMf5E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-DtnwqpwEMgeiRS2jBdkWxw-1; Thu, 01 Oct 2020 10:41:55 -0400
X-MC-Unique: DtnwqpwEMgeiRS2jBdkWxw-1
Received: by mail-wm1-f71.google.com with SMTP id s24so983423wmh.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yfzTgNqzLiEFc/cAfA6GXjB7CpjC/0vuJpK739XCM10=;
 b=MzX5NrL8wHcy6KrlzjtuPuyKABgmPhxHwnBkgKnae8VnGL/ppJ1K93XwEgswimmMWt
 k/GPy2srgkCNKjCMTULxzjMXvT2N0WcK4ZHtQT5n1qajTEG5sYyKkGhxGaurOlGM2f60
 UxxP3fs+kbyZCyxBjR4wUkThbU2tItdyRvoA2h1GnulVrs61a9wGwUbodviDbLq5d3XR
 5BH/Q3L8lLjmIvYuYCq9PGeWXWbpMl3f/LCL1D+K3iPSC2NrKlqbQ619/w4PLmXhz29j
 P1wElHJ8hgXM3KsDKC6NAllM+VDosfobKtI5jJbjhpcC/+qtgkTEOCJ7N+pbedTZThgg
 PB9Q==
X-Gm-Message-State: AOAM533zxQE/T/R0GPdHVUAhCCJw2gjc2lxf70ckj8WfIwRvNrNQQcIS
 gBE0gj4M7eU51RHZXNC3luzkg6Y8LQC84TjKLLhRecHhAIQkJNkYFXuSdFYjRpFZC9cO9RQOQx0
 /rsYcWRhhcUiGBGQ=
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr322800wmt.189.1601563314633; 
 Thu, 01 Oct 2020 07:41:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9Fst8GzqzZPtYuakCBP5ul3y1+Tttaamjbc94WW3TTCB8qz1Hkrgi1sExgxlr11WfUGF0kA==
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr322772wmt.189.1601563314421; 
 Thu, 01 Oct 2020 07:41:54 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a15sm10185389wrn.3.2020.10.01.07.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:41:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] target/i386: Restrict 'feature-words' property to x86
 machines
Date: Thu,  1 Oct 2020 16:41:49 +0200
Message-Id: <20201001144152.1555659-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series restrict the 'feature-words' property to the x86
architecture (other archs don't have it), and to system-mode
(user-mode doesn't use it).

Extracted from "user-mode: Prune build dependencies (part 3)" v3:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg746423.html

Philippe Mathieu-Daudé (3):
  target/i386/cpu: Trivial code movement
  target/i386/cpu: Restrict some of feature-words uses to system-mode
  target/i386: Restrict X86CPUFeatureWord to X86 targets

 qapi/machine-target.json | 45 ++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json        | 42 -------------------------------------
 target/i386/cpu.c        | 31 ++++++++++++++++-----------
 3 files changed, 64 insertions(+), 54 deletions(-)

-- 
2.26.2


