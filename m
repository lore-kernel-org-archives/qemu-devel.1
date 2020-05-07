Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BAAC54E8C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CB120A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUIWcg3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CB120A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkGP-0003K3-1F
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkFY-0002UW-Ta
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:23:56 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:36344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkFY-0005Yt-2i
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:23:56 -0400
Received: by mail-pf1-x431.google.com with SMTP id z1so3320698pfn.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E5wwYiIlrZ2dlpj/1BVd9dND0awhkp219C9DoJHI8Rg=;
 b=GUIWcg3ZIK1EuRjD95fvAK9iui+TmGw3Zryu7RdlVHDRfdlRyr7OS/0oghc+f8ione
 1w/GOcPIuCkjNLCPGrAkR6njCAq+Z6dM4dYVF3S7/5IhrADkGRG+OSNrYhhMmPA/Mmf9
 vh0k6F5AyA7dU3rQq8T1o6DbN2Oe/uyg9hjPhUQBa3s6wnc3jGfLU+Dg+9br+TQKrhcl
 qOgGOe6KSLeS/+APGaob05hQ3dLPJqPV82nWIeEWWteFmfJShFtCoOGNmIjKGa6Da+FA
 +/Wgw+Prrs7eu1+/VpgTDfukf7bVjQbrJ0DtW84Dn8xOR6GX97Rq2jvY5/9KcU5Q7VYO
 0DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E5wwYiIlrZ2dlpj/1BVd9dND0awhkp219C9DoJHI8Rg=;
 b=UsD3Bf+64cvW68Q1ZkFiKkEUZPSZW9Z42ocujia/GccjzGRjmdd8Jz6OVK2Rdvok/f
 bF/aBID+By083qbO4VyVdqmydSl4w1qX/MJ/Be/4LH8I2vTq6fHjdVaqmIJmyTYz4TOL
 0V8i4meblDc90Zjla/pns3lfvg1VGWKLSwu3h6f84hnVgG8NRVJGgCPjFOV/y9CEeJyn
 AeoZCkbufgS48upkgOmKhNh6aTMbbbNHFaAMlzCYqbzRUBoD4ixWOrg1Fl86t8PQYmnf
 40FGJEzWMwcfUcWz2KoT/vFpCpi5ni6/2LBotw6rZlL2q3OcP6X/QOPe8ewWgRk522HU
 9uFg==
X-Gm-Message-State: AGi0PuauyNC4HNHAdYFqzlgcJPvxU0TenmM4FLPhY/Pw6t07hs8z2fJs
 EPNwW5svckxVJxv3cMLPn5+Ujit8GJQ=
X-Google-Smtp-Source: APiQypLiIqQwZ7pKFEWJ3OLYwATbtY7gm5yx6qe2BWyM39o4GP44aGSTZ0xU5vc9GoPLaPMwDTDgyQ==
X-Received: by 2002:a63:ef05:: with SMTP id u5mr11821214pgh.237.1588872234137; 
 Thu, 07 May 2020 10:23:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 19sm312228pjl.52.2020.05.07.10.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:23:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] target/arm: Misc cleanups
Date: Thu,  7 May 2020 10:23:48 -0700
Message-Id: <20200507172352.15418-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 2 adds a fix to a just merged patch.


r~


Richard Henderson (4):
  target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
  target/arm: Use tcg_gen_gvec_mov for clear_vec_high
  target/arm: Use clear_vec_high more effectively
  target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)

 target/arm/helper-sve.h    |  45 +++++++----
 target/arm/sve_helper.c    | 157 ++++++++++++++-----------------------
 target/arm/translate-a64.c |  69 ++++++++--------
 target/arm/translate-sve.c |  76 +++++++-----------
 4 files changed, 157 insertions(+), 190 deletions(-)

-- 
2.20.1


