Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DAAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2AD2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9a8vZ7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2AD2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kILcN-0007uO-Vo
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 20:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILav-0006C6-5P
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:33177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILas-0001Ux-4y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id z18so413151pfg.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yNC3S/khtq12tJRSCbvlPPiZVwJzXQmUa6AFIClVkY4=;
 b=t9a8vZ7RVzwtQjEt1J3AvjbyTZKrIuOQeg0s7nSJZG9F1LWO3SLgm5PwDxJ3DAE9i3
 q7n9XBArD+tloYxXm+vYjQabmP6m1qeGXccS62ucuNFVnGZEDc1OxQoPzFZu4rScBFUc
 /96SgSqFvhTiQatY8Ks4SLZUJKaa5MBkNP8XtU1chc8hU/2h45rJhlB3eWPR3LpDujKA
 sSQMyx48zVXVznCYLCHQsRScFLuQ9NSIPL2ShMg/gHTtD2YGrn/w0yp5DY5yO4U8UGmy
 Ml0cuUD96dTFzuqWfJ6VbzN+TxH+fLYtpCZeUqzdeQCgEXWjFoGSGyAUE+/97vEEzefm
 oP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yNC3S/khtq12tJRSCbvlPPiZVwJzXQmUa6AFIClVkY4=;
 b=GoVWHXslL9v5hUtAqF6lHyxL183CSeXaapaeB72dZAJZVwVjU4L4r6mmwI9ML+Ny0n
 dyy/0UI16YGcqrZcusiRI3f7OBNbVEB9YmrQ0PLqWG/FVzycj7IMpefi8dGt2N6xYrAV
 x3F5pmZf1x3jFNjggq/PBEzX5+t+dvOLEui8RKbNfLiDL5Jj/35qfulWwYHiRLIw/xM3
 K5YLxi6kOxl7RnvwiIRSpC8Y1R2RJfBE6/uzOaRMdTHPQqCCDe6HHE2ukvtNjfZBpass
 iEk4XOyhRAWnQk6Vk9W3d7hhyGhQOSdAXk4go3ev2WlKZBLaF4M3OCzIQI/mwT9m6xgP
 jHtw==
X-Gm-Message-State: AOAM531tjl9RLArXwsUER29Po8m+Ziz6NeUUdB7mF2G7hMoFbJmBU6HD
 8MK9dfpbkj1wP0JK4D4b82lu0Br5414IHw==
X-Google-Smtp-Source: ABdhPJy3dazCFMWcdNrfGtLknyJ6gg7B2dLw1Nk7g9bwMYZfOWiG6C5+ZdP5uNbaz5iBcX6Yvjy1IQ==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:6525 with SMTP id
 x124-20020a627c820000b029013c16116525mr20664512pfc.5.1600217200425; 
 Tue, 15 Sep 2020 17:46:40 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id kf10sm611723pjb.2.2020.09.15.17.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 17:46:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] qom: Allow object to be aligned
Date: Tue, 15 Sep 2020 17:46:32 -0700
Message-Id: <20200916004638.2444147-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've seen some failures on arm and s390x hosts after
enabling host vector support.  It turns out that the
malloc for these hosts does not provide 16-byte alignment.

We already have a function that can alloc with alignment,
but we need to pass this down from the structure.  We also
don't want to use this function unconditionally, because
the windows version does page allocation, which would be
overkill for the vast majority of the objects allocated.

Changes in v2:
  * Add _aligned_malloc patch for win32.  For what it's
    worth, this passes a gitlab cross-compile test.

  * Add and use qemu_max_align_t for choosing between
    g_malloc and qemu_memalign.

    I had been discussing extra checks for i386-linux with
    Eduardo, but then it occured to me that both linux libc
    posix_memalign is smart enough to not imply extra overhead.
    So qemu_memalign with alignment <= malloc alignment is
    handled easily by the system.


r~


Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-riscv@nongnu.org
Cc: qemu-s390x@nongnu.org


Richard Henderson (6):
  util/oslib-win32: Use _aligned_malloc for qemu_try_memalign
  qom: Allow objects to be allocated with increased alignment
  target/arm: Set instance_align on CPUARM TypeInfo
  target/ppc: Set instance_align on PowerPCCPU TypeInfo
  target/riscv: Set instance_align on RISCVCPU TypeInfo
  target/s390x: Set instance_align on S390CPU TypeInfo

 include/qom/object.h            |  5 +++++
 qom/object.c                    | 36 ++++++++++++++++++++++++++++++---
 target/arm/cpu.c                |  2 ++
 target/riscv/cpu.c              |  1 +
 target/s390x/cpu.c              |  1 +
 util/oslib-win32.c              | 10 +++------
 target/ppc/translate_init.c.inc |  1 +
 7 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.25.1


