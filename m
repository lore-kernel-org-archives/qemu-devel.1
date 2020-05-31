Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42057C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C882206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au/MK1hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C882206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfOIO-00057s-9L
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 09:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jfOHQ-0004LJ-5k
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:45:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jfOHP-0001Ba-9V
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:45:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id c3so8745342wru.12
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=UdJMKgP7HXvJifz7OblobespMlN2m0Hmu5IlCva16ZU=;
 b=Au/MK1hVrf5wmHqh15ROCO5++zPmxokm6uY1+2hJ51bdubhyTgoYqU2wM4ktd79LEe
 F8AWer9sRoCVxXssehuLJ6mRi5YRLQd/u92/OO3Hz/q4HC/6aZz79Tm0R08aXlRdhVmm
 l2bhNWbHZrQtrCAWACFTZumAqIvbF3v3DF+7iakY8P2S9dLY/eMqndGnHdxXcCdMe789
 ATXw9wM0LVfl0OrKZo4iRHIDILLuHX+BWKxy0AcIOByLOXAH62mu1Qo9+aX6/ie5TFSm
 mza1wQKzWLvsyZHIw0AGw43xdkCJjRp28Mvv33+P653jqCBMQBu0+mDHwp9y9JkaTNuZ
 FmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UdJMKgP7HXvJifz7OblobespMlN2m0Hmu5IlCva16ZU=;
 b=FGAT1r1E8koDYTz93/PqnrlvIbVvTwpBlL8loVgr3Yz8VszVbiqToJ4oNlEG6qIpTO
 35Nnztc/ITL0JcanPgmQMVucaGC/ThF3DoGoOQVnRxe55Jpj91CxhTq1AcgL8XX2sUz5
 Rn7pCEJtix20xtPlJAyHoWd4T48d8S8WR64O4uEIs2XwAmk4s6zizdRwG1mpDmuCFde5
 /wF2LBpQ7vIxqQ+iHekwEI1yMpZzq6RKyUzn3qjl78p7tOVbdSfvepXdkos4shfNerPv
 b8eWjaN29uUvOWqqCcVinzeDZFppmgdDkwkrsIkidwTtFx+bTngsY5NlxDpBpskpMHum
 CM1A==
X-Gm-Message-State: AOAM530NPYsz35/LGUsw24VHuksXzeTDiFIe+cde/7nVBW8Mc07ehO5i
 Xptj5AvWb6dI1bwnPBDXyGgLD90ngNU=
X-Google-Smtp-Source: ABdhPJzxf1wuUF/HKD96RVZUlTWzmw3sRiO5P9BFRcNwKCLyWEYulOD5Rl5KpUqA/dKjkrzHt2vJJw==
X-Received: by 2002:adf:f790:: with SMTP id q16mr17836147wrp.399.1590932733286; 
 Sun, 31 May 2020 06:45:33 -0700 (PDT)
Received: from AK-L.domain.name ([41.232.117.148])
 by smtp.gmail.com with ESMTPSA id a15sm18006483wra.86.2020.05.31.06.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 06:45:32 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org,
	rth@twiddle.net,
	ysato@users.sourceforge.jp
Subject: [PATCH v2 0/1] Check for page crossings in use_goto_tb() for rx target
Date: Sun, 31 May 2020 15:45:11 +0200
Message-Id: <20200531134512.7923-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

After discussion on v1 of this series, the conclusion was that page
crossings must be done for all targets and for both user and system
mode. This series deals with rx target, that is the only target that
does not perform this check in system mode.

In version two of this series, the original use_goto_tb() function in
the hppa target is left unchanged. For the rx target, it's modified to
check for the page crossings in both modes along with other minor
fixes.

First version of the series:
https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg05426.html

Best regards,
Ahmed Karaman

v1->v2:
- Skip the patch related to the use_goto_tb() of the hppa target.
- Apply the page crossings check in use_goto_tb() in both modes for
  the rx target.
- Add appropriate comments in rx use_goto_tb().

Ahmed Karaman (1):
  target/rx: Check for page crossings in use_goto_tb()

 target/rx/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.1


