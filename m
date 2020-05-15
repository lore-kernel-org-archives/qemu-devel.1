Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F308C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095A820727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfT8HiU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095A820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZe9h-0006J5-US
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe8R-0003XU-R1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:28:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe8Q-00016Q-QS
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:28:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so4436097wra.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JtGgRfJwV4eXh8Inmo5o/BeREd5Y2ML3c0rFf6Dyjzs=;
 b=qfT8HiU5QrNl2Pp59CtaHRNYq1vieR7QgVd5L3uvo1axQ2dh7i8VCXD09k6Kl4HTQo
 oBxkgcetCIrPFj485A2rQLlCeZa4jSbU9RdR9frkC2b+mzRJ5Jc+TSGNb9VzBZAUyj6P
 1H+7reVkH/c+BcMtwnhYyVQAJNjR6fyRyrIbat/jhXqMGtwd3tIavnKAm//lNf35/26U
 GFV3WwoW/A73Tdnnc+tffjdH4S+FUKxcwfKbeoloL8ASoF4mPCUYLY83NWoG71MLBdWP
 S9WvFwowgRa57IkrEUVWPZXaXgTElcZMOetUOHwmHyAsKnOo+s4DV4KC5U09Zjaxxpgh
 s2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JtGgRfJwV4eXh8Inmo5o/BeREd5Y2ML3c0rFf6Dyjzs=;
 b=jzmrHSdB69QozfV/ujQFxb9NPnzJdefteM2Z3Tw1VFfO2rGMrAVAXqnjwhu0vNJd5F
 bB3t7rzKm94I1SwU6wDGnMynrfVli1CGHNmWa993peyMf3QwXsOrVLpuz9b87Wb59hC5
 s8RQS4HoReuBuBSlQXoYAhlXLrutL9tx7D4jWCxCOPyrt4Sh48sZpHnEJql6jJ9bXcN3
 MFxEH+chu+ZouWA6Bezoia5Q4Q+H1tqBPwY3pXorBjDDZ3umwTRIK4zDMOOi6DvvVEQC
 Jd+5jtilpuskD/YiHux7FS9L15MwolfMn29Z8tuRceQjXQQne3ixmO6BCdGUbdbh8UlO
 WvxA==
X-Gm-Message-State: AOAM530bkSvNUQi5Liwkfb65UP4TFDqSKASkvUeSq1kw1NMD0M/dyOGW
 3ZM7ym9XmOVvYjXqKk2Z6KmlTQ==
X-Google-Smtp-Source: ABdhPJweY6SbuWOs/Pu72jpgJMNDUnF1IFseHXVfGVZAqlxUyoicQmtkJKmujQ0DHpFf9551esKbZQ==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr5363550wrv.155.1589563713227; 
 Fri, 15 May 2020 10:28:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m1sm5131287wrx.44.2020.05.15.10.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:28:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34F441FF7E;
 Fri, 15 May 2020 18:28:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/2] some fixes for genisoimage usage
Date: Fri, 15 May 2020 18:28:29 +0100
Message-Id: <20200515172831.8439-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Robert,

Here are a couple of patches you might want to add to the start of
your vm build series that deal with the fact genisoimage might not
exist or have a different name.

Alex Bennée (2):
  configure: add alternate binary for genisoimage
  tests/vm: pass --genisoimage to basevm script

 configure                 |  2 +-
 tests/vm/Makefile.include |  1 +
 tests/vm/basevm.py        | 16 ++++++++++------
 3 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.20.1


