Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B4EC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A193322464
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH9KdeLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A193322464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3iji-0001Ng-Or
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3ij0-0000A8-6Z
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3iiy-0007ZS-V3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3iiy-0007Yp-NR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:54:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id b17so19016886wmb.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 07:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3uzgQaQij2DH5MuYf+nfMxhMBugM9wE6JvtdXWR1MXk=;
 b=FH9KdeLkBluGR8qVHG1+XuDtKLB0proI2Nn+ULdShvKTZvOl2Izo/+ErgoTV5PzM8M
 JwVL5O+ilbA7lBb8+yjLIILNN4M/ydFxFm3msAiPe/nDYlu9vWAL7GTzL+4Xf6en9mFr
 g+zA3rOEqQjesoQAWPtObrNlULh0GYTdmdEMQpMvShPWpKBF/+ELNUYxUAhBs4spF0Mz
 kNzEHHMeQd8ejC57e2FBMmgh6mdIbSr9mW+aPZHNvLwVwJ6AA++1YoGwcHUsfm0C1LIr
 MVw4fbBqt1z6RotDyHN553iDr5PThGHyAhpb1xpBe7vh3LQzn1VPu2dK3i13sdSBqsrt
 FQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3uzgQaQij2DH5MuYf+nfMxhMBugM9wE6JvtdXWR1MXk=;
 b=qCq6dQWrDGsy4V5VG+dEPpcDgt8GyzGJu+sEif35XcQbJQZqHgZjpHQ64y0yjESYI7
 nhfqabf2selJa3xjN7tZhA8Cn1QA7cFm5MjdgM2b2NYRIftwzAzZzAOL8GkZOxV9vR5l
 WCtwud+Zmm59hgqRydnJsnDNKdLPIi/n1acveDfxsOkTCh8P/cPM3xBbkaHFZFrFU1Fe
 RjKIEo40jr4uiv4erH5ARuM5ecw5+s0oONRhXCo7EUy3912wkmkgxbJOXHyVM2iulJ7S
 XddGreMwtUviZax/ec4tlagM1R9GsbYOYx2XO4Nc7RsaTFKCRgogGfSQQiJwEazfGRMy
 r/XQ==
X-Gm-Message-State: APjAAAXqWGg9SChVxVd/rS4THVB0eZSFVY/h1kLvUIHEUZRl4Eg5Hxo4
 IdIDyNzRD9R7XaINMn83R0xwt1kz2wudhQ==
X-Google-Smtp-Source: APXvYqxrxfWuTjyedklk3POhjoP/Y3B3OL5fFydt8GCs08ZgTkX10VCumPTU72mdR5LQnGLKrLZPaA==
X-Received: by 2002:a7b:c8d3:: with SMTP id f19mr22346840wml.26.1581954858859; 
 Mon, 17 Feb 2020 07:54:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q9sm1465626wrx.18.2020.02.17.07.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 07:54:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] docs: Create a 'tools' manual
Date: Mon, 17 Feb 2020 15:54:12 +0000
Message-Id: <20200217155415.30949-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset creates the new 'tools' manual that we've
decided we should have, and moves 5 existing documents to it:

 docs/interop/qemu-img.rst
 docs/interop/qemu-nbd.rst
 docs/interop/virtfs-proxy-helper.rst
 docs/interop/qemu-trace-stap.rst
 docs/interop/virtiofsd.rst

This change will conflict with the QAPI-doc-comment-to-rST
patchset because they both change the docs/interop makefile
rules, but I expect this one to get in to master first;
the other needs a respin at some point anyhow.

thanks
-- PMM

Peter Maydell (3):
  docs: Create new 'tools' manual
  docs: Move qemu-option-trace.rst.inc to docs/
  docs: Move tools documentation to tools manual

 Makefile                                      | 41 +++++++++++--------
 docs/index.html.in                            |  1 +
 docs/index.rst                                |  1 +
 docs/interop/conf.py                          | 12 ------
 docs/interop/index.rst                        |  5 ---
 docs/{interop => }/qemu-option-trace.rst.inc  |  0
 docs/{interop => tools}/conf.py               |  7 ++--
 docs/tools/index.rst                          | 17 ++++++++
 docs/{interop => tools}/qemu-img.rst          |  2 +-
 docs/{interop => tools}/qemu-nbd.rst          |  2 +-
 docs/{interop => tools}/qemu-trace-stap.rst   |  0
 .../virtfs-proxy-helper.rst                   |  0
 docs/{interop => tools}/virtiofsd.rst         |  0
 13 files changed, 48 insertions(+), 40 deletions(-)
 rename docs/{interop => }/qemu-option-trace.rst.inc (100%)
 copy docs/{interop => tools}/conf.py (80%)
 create mode 100644 docs/tools/index.rst
 rename docs/{interop => tools}/qemu-img.rst (99%)
 rename docs/{interop => tools}/qemu-nbd.rst (99%)
 rename docs/{interop => tools}/qemu-trace-stap.rst (100%)
 rename docs/{interop => tools}/virtfs-proxy-helper.rst (100%)
 rename docs/{interop => tools}/virtiofsd.rst (100%)

-- 
2.20.1


