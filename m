Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C811C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421C6206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhgwBHnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421C6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jougV-0005aQ-Fv
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joufd-0004Lw-W8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:09:58 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:50711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joufb-00041h-Tb
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:09:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id k71so1916291pje.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lasQjN5LXj5UcP1e4KoJ+A1gauTll/nfuzKb2yFFZeI=;
 b=lhgwBHnnHJ3mJ7DE7e3s/Di9Z7Nj9HJ1HXiIlz+24NQQXPnYY/ntyEplO2r0kozAfL
 5xkkdQqcihGWiRDxvjBPgtl1d59qpUm4akVLPc9g+2EIy5thl5gc6MAm5HfD9fctnUsG
 EPwObOfueatGM2WrDe3yKcUF4GgfyTpfb65EczMde2Hx5WIVs/VhV/zx6HbOdo+FMSEl
 1yvtS4LnpcXdeZEu+adCj0xp+bGFKeJ3Mq4MtH927JEZ0qC4ofmRohCWvIqVLPCFd0M9
 gBB1qU1c9cmg6aFjKTGaJtpR95Lnd9T9yN3PhiGVBE1k7wI4I9SIgqhR20DeKQ7qCSAy
 aQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lasQjN5LXj5UcP1e4KoJ+A1gauTll/nfuzKb2yFFZeI=;
 b=qsNYXw4yLEaLEKxDHREJ3JOKdefcLlbJkq8lxM5HqvtCkTNrsjnlOIGUJdnXPW2pFL
 C5WnXtdEBJLVCqbgS/DTOpZF2Fdc7f/36zCVRes3Q7AbjLpwW9emKMGrcSiQlvw84+6W
 yRHBWFGsOV1DBCDCUk4IDzOSXyY3B9S4YDJsZJjtY1RXBdqIdwqEHR1alWDLbDLR3vkw
 H5nbD0Wo3m6MzwFLG2khEXWRGplWoiKEQohbAknUUCrg0qgVz6vxd5eFCJWIx6+R9bzO
 ft/OQC1PGCtw6JRMWncyG56u1MeSgtEPgvSeqtYcQ0Bs7P/2W5UqKK+8wFqBCyq0yfB2
 Wbsg==
X-Gm-Message-State: AOAM533dUlUiRmzNbIWIAJrkoSUGQkEr+2WTjiMJiTpluy6COdFzTCg9
 Fo5lQz1HjHvE5Vr97AidaxY5B+7ZQyM=
X-Google-Smtp-Source: ABdhPJzRGo9Z+haAvSeSRLRlnL5esKpMhNsYQ1kkqw/sHSM7+WgLVnaITzzD4mHhMu6Q8qF+MBM2qg==
X-Received: by 2002:a17:90a:f309:: with SMTP id
 ca9mr4880084pjb.113.1593202193858; 
 Fri, 26 Jun 2020 13:09:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n8sm23879405pgi.18.2020.06.26.13.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 13:09:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] tests/qht-bench: Adjust rate/threshold computation
Date: Fri, 26 Jun 2020 13:09:48 -0700
Message-Id: <20200626200950.1015121-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Supercedes: <20200620214551.447392-1-richard.henderson@linaro.org>

Thanks for Emilio's review of v1.  I've split "seed" from "rate"
as suggested, left the comparisons alone, and expanded the comment
in do_threshold.


r~


Richard Henderson (2):
  tests/qht-bench: Adjust testing rate by -1
  tests/qht-bench: Adjust threshold computation

 tests/qht-bench.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

-- 
2.25.1


