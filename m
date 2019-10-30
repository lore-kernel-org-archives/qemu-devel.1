Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA52CA9EC6
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 20:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AB82080F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 20:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khxwz8d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AB82080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPupk-0002Ih-C6
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 16:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iPsPv-0003v5-IJ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iPsPt-0006V7-Ee
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:09:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iPsPt-0006OR-8K
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:09:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id q13so3368729wrs.12
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=N+2MOMMrGRhCDwJoIgrO3zCdzJUAa8aWvETBuL462sQ=;
 b=khxwz8d6Ip1bf7AifdUTjl8rXfYnpBe5a5KCbdimwM5qRY/Uf6hxy6Ik3T/a7EshYx
 AEWD1saglH8gbrUT13Xby7H4VRVhIGUjeT3TAyHgr165vw/XLoa0Qw26PloSMPATLI4b
 vGYm879Dxce6VE1b4FPwMU1GkE6+ezxX6u+uiIUCGWwBrAdBxtcKa3XYJWVZm5ykQ3sy
 OrvrNV3iub2RJ+EmXAuPrEKc/a/kfYFIwWm4GiF/BXCEvzZ15GHQ6w27J6/bpdZaPCZC
 uZnDLUfvO4sL09UDXuP9TxaCLKwDwj6IAJPvaZZrGEk2oxSRD3W6LurhC4Jmb/0wPKZl
 ZlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=N+2MOMMrGRhCDwJoIgrO3zCdzJUAa8aWvETBuL462sQ=;
 b=eAkSeEm4y7vk2tjAEVMvRy6ZReo+GMp5WB29mIdHqHfYroCwTdyPg6ZyXJ5VvuWuvy
 elOmFQN8AfU7GrGs7kjqIpBhP7qNlDCL0WCFkI2AwmIZ0rhIDJzlExdvkGcV2E7ohXSo
 JpLFjQ1Ij3tB2kxGC8mE7lUgLE3R2S/rn2hhib7lzKfyyD2TqTcB/xbGvWQHcFmqWXbF
 mVK+tjg16iqMlmL71QlSMQONtKk7201C1TsPlsBbyNmiFvHRSKPud76OBieQpauaBV5M
 Cl6phcl7n97t/gnrGkpfpUGE1niHJn0DNWfs3k3792rsJBRk8Qfr+pVqMGvpApT24xGr
 GYZQ==
X-Gm-Message-State: APjAAAUsI+toNM8cY9DSk5l5DRVXvEo860h/WHitpYcUoqMO90Za5MFZ
 BdJ6ZWL6A7j3xDSt+bFz2OUI+KR1D44kRg==
X-Google-Smtp-Source: APXvYqw7uNqOjstd+Um9VDOvMUgasel0tAhP+mQq17vhvDr3xC/hiiAE7fxQrNWWyzTd+L9kkXgEsw==
X-Received: by 2002:adf:c402:: with SMTP id v2mr1158280wrf.323.1572458994346; 
 Wed, 30 Oct 2019 11:09:54 -0700 (PDT)
Received: from localhost.localdomain (248.42.142.88.rev.sfr.net.
 [88.142.42.248])
 by smtp.gmail.com with ESMTPSA id t133sm6931299wmb.1.2019.10.30.11.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 11:09:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-4.2 0/1] softfp patch queue
Date: Wed, 30 Oct 2019 19:09:52 +0100
Message-Id: <20191030180953.24180-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

Just one easy patch that made the cutoff.


r~


The following changes since commit 16884391c750d0c5e863f55ad7aaaa146fc5181e:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-10-29' into staging (2019-10-29 20:06:08 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-sfp-20191030

for you to fetch changes up to 21381dcf0ca8fc822328e30570c8465ec4e52be9:

  softfp: Added hardfloat conversion from float32 to float64 (2019-10-30 19:03:37 +0100)

----------------------------------------------------------------
Use hardfloat for float32_to_float64

----------------------------------------------------------------
Matus Kysel (1):
      softfp: Added hardfloat conversion from float32 to float64

 fpu/softfloat.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

