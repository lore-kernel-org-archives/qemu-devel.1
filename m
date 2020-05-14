Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3F62065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7vsK8Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F62065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLQ0-0005W4-FA
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 17:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPA-0003zz-Nz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:36 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:39484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLP9-0004bI-QK
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:36 -0400
Received: by mail-pg1-x52f.google.com with SMTP id u35so1823332pgk.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4hK64SaAIyCA4e+qcZ4V/7FFwWXibh8/hVGB6NZ+ilU=;
 b=O7vsK8IwJyp3bYGkcGCOd8AgYpVxk5fQJvE7VvjPpyqRH7rhWA1u+hJOPF6S6h95DL
 vrkMX7Wg64Bdo3mvASFBSyfTQ1V8HrQUYjIO42ge1+1Y7j+uxnF78oiyS4b5wf8Nfzbn
 hkyPHEwz1yRTmY3ZjfBK2H2Brgiu98ya32+Wkk8lFrEOamwIYxou2fIOXTLvNa9a1ysn
 rZbr9mpKOBLhpx9Ub4wlKLj1KVJS3jBpAPHx/JmvngSDOYntFFsYYujiNqNw4rIDazii
 /d1CuJmInAU/QN62y4CiPtjJXqE3zxNFV+Ja02VFhGaaJztWKmwj9BQAxGHuyGVb6G8E
 9GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4hK64SaAIyCA4e+qcZ4V/7FFwWXibh8/hVGB6NZ+ilU=;
 b=dIlnRyB+6GAjLN9OmsBHKRJFdkguFiCvU4yGsAsGRYviSrxwr/96+CYVnKkOudgVZf
 aAoPX5MEIeHe6lixhQnL3/fXnokq3SynnYhWRkabDSQ914ErSex/3uNbtvPPan0x1him
 +Nctr3x8SDxPrmoVm4qRScLwhkXU8PCyxGt5ZftSuWcJmjxjgT3SFCej7PwUJg9wUsBJ
 Cm3KIOqgkkwHGMUUCftk6IH7KWqJkK0DyFw5HU6FFah7s1OWGq979W2UDQAaRpoqb/O4
 tjV1ZF+z6pDZ3XzbCU9JTCsRkgKMJPaAzTNdRxEH0DALmBALJUFWY5M/T596YWLr6pbz
 z36Q==
X-Gm-Message-State: AOAM530gw6NLpxMIgwL/R/+Z92LwSWfC2HBYY7kIe1gXIQn8dmArexvo
 jMstBqxVhn6GV4XjBg2EJlYys14dm3c=
X-Google-Smtp-Source: ABdhPJwTKClaIcG/IG/Bm+I8ijUW4kX+1GPTTc8skFwKk0TwNONyIBIummZ4V8UH3dMvkDRNiaT0sA==
X-Received: by 2002:a62:3644:: with SMTP id d65mr537458pfa.186.1589491713374; 
 Thu, 14 May 2020 14:28:33 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm4986pjj.33.2020.05.14.14.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 14:28:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/arm: Convert crypto to gvec
Date: Thu, 14 May 2020 14:28:25 -0700
Message-Id: <20200514212831.31248-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In addition, this fixes the missing tail clearing for SVE.

The sha1, sha256, sm3 routines that are not fully generalized
are not used by sve -- it only supports the newer algorithms.

I'm not sure that this:

Based-on: <20200508151055.5832-1-richard.henderson@linaro.org>
("tcg vector rotate operations")

will be sufficient for patchew, because it also relies on
today's target-arm.next merge to master.  But you get the idea.


r~


Richard Henderson (6):
  target/arm: Convert aes and sm4 to gvec helpers
  target/arm: Convert rax1 to gvec helpers
  target/arm: Convert sha512 and sm3 to gvec helpers
  target/arm: Convert sha1 and sha256 to gvec helpers
  target/arm: Split helper_crypto_sha1_3reg
  target/arm: Split helper_crypto_sm3tt

 target/arm/helper.h             |  45 ++++--
 target/arm/translate-a64.h      |   3 +
 target/arm/vec_internal.h       |  33 ++++
 target/arm/neon-dp.decode       |  18 ++-
 target/arm/crypto_helper.c      | 267 +++++++++++++++++++++++---------
 target/arm/translate-a64.c      | 198 ++++++++++-------------
 target/arm/translate-neon.inc.c | 172 ++++----------------
 target/arm/translate.c          |  51 +++---
 target/arm/vec_helper.c         |  12 +-
 9 files changed, 403 insertions(+), 396 deletions(-)
 create mode 100644 target/arm/vec_internal.h

-- 
2.20.1


