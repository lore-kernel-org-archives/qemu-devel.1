Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C83C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922842076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEoJd4lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922842076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5kek-00062l-SD
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 02:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5kdt-0005Dm-LC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:53:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5kdr-000412-SD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:53:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id z20so668039plo.6
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hRnoFEnKBhkgA2clRhmlEpGopkDGft0FGQ1sbW5/fwI=;
 b=pEoJd4lD2pzXeFTBowHd8mepclvEYhF5He9ADrurkYy7Tf0x+nfElE8jQNEqVgDjXg
 UVMYowNBlzy9R5ly3L6kNZ3KEz/q+73yR79r2CZBdwU2O2VgIl3pODujhwVJ3lgXpBtb
 Njg1eJoqsT4AVNf8GtJ7NMBT+UsUHQ6Exuq5/qKgKO1UJsjmb7Rdt5a3Xxo7VbPL1+a9
 UgS03hgYoKpXYecr9qrdB204bkYQgpOAdViA4uiyBGTCmmnBJueupCR4CXKKbeUHFAor
 QyyJ7agVJFAWxxQ9BG/FGiKWI7Pn6BAsaAzI3owoBncGXzQObP7JUs9n8S2/EPeVqrGN
 Us1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hRnoFEnKBhkgA2clRhmlEpGopkDGft0FGQ1sbW5/fwI=;
 b=Mv+bngaNVH3kSgkRB9fntgo3D9cl4hd685kq/R5eTl1bLRHjNZlyhQ1Mwy040LSwXc
 q5s76NR4M8kAIUinaIDdH6g9TIvd6WcREFccRc30bEmQYfX+djWUg5MqOzowRix0Lt0a
 5tABaqCy3OXgCeB0+z38ojaBtd/b2ctHN5xON1yEEEJ93PjlRIZzodAV1uFq4LStREvo
 hPxntoGmHz7PqymK5LFsA5FwMjn0K8zROqgjLWkayrtZJmKgQ/SXtwY4e23A2SseYF+w
 ovhAeV1pJ2UnH7VZuAVUsxbsHRtZADXrA1qfxbtRnB6zlwHDHXHEP/fiNkd0hI7KpY8D
 p53w==
X-Gm-Message-State: AOAM5327SGP8w3No8/ENRmabKUl65ylSW043oSMKWsXlKJ9WFaRiWMdr
 ph72aWk7hIRqvdz1A1tv/LCD/ZDq3Y0=
X-Google-Smtp-Source: ABdhPJzaOFcBbY/EPG2gULPCfcwocH2iSWDgUD49cyovgtiTJ+bZV8xpiZH1ct0uQYDk8hrYbZubZA==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id
 f12mr4427045pju.44.1597215221220; 
 Tue, 11 Aug 2020 23:53:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b26sm1242781pff.54.2020.08.11.23.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 23:53:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: Implement an IMPDEF pauth algorithm
Date: Tue, 11 Aug 2020 23:53:37 -0700
Message-Id: <20200812065339.2030527-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With recent linux kernels, which are built with pauth
enabled, boot times have been significantly impacted.
It turns out the architected pac algorithm is expensive
to implement without hardware accel.

I tried replacing this with AES128, which most hosts
have in hardware.  I did manage to make this perform
fairly well, but it *really* depends on the quality of
the crypto library shipped by the OS:

(0) For reference, pauth_computepac_architected consumes
    about 80% of the total runtime for a debug-enabled
    kernel build.  That's a 400% slowdown.

(1) libgcrypt performed well, with 15% of the total runtime,
    or about 18% slowdown.

(2a) libnettle, as shipped by ubuntu 18, does not have
     the x86_64 aes instruction set enabled, and so is not
     using the available hw accel.  That took about 40% of
     the total runtime or 170% slowdown.

(2b) Rebuilding libnettle locally, with --enable-fat, and
     using LD_LIBRARY_PATH to replace the system version,
     worked fairly well, with about 20% of the total runtime
     or 25% slowdown.

(2c) libnettle doesn't have support for armv8, ppc or s390.
     Those hosts should *really* be using libgcrypt.

But, silly me, I had used --target-list=aarch64-softmmu for
this testing, in order to speed up the builds.  When I went
back to building aarch64-linux-user, I was reminded that we
don't link linux-user binaries against the crypto libraries.
And those crypto libraries are usually only distributed as
shared libraries, which would cause problems for --static.

I very briefly looked into doing my own aes implementation,
with host cpu detection.  But aside from the ugliness of that,
it begs the question of what to do if there's no host accel.

I settled on a fast non-cryptographic hash with about 10% overhead.

I added a -cpu max,pauth={off,impdef,arch} property to choose
between the different algorithms.  The default remains arch,
since that's what 5.0 and 5.1 shipped.  We can discuss whether
it makes sense to change the default for "max".


r~


Richard Henderson (2):
  target/arm: Add cpu property to control pauth
  target/arm: Implement an IMPDEF pauth algorithm

 target/arm/cpu64.c        | 64 +++++++++++++++++++++++++++++++++
 target/arm/pauth_helper.c | 75 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 134 insertions(+), 5 deletions(-)

-- 
2.25.1


