Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36C5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7142220838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8/5fGRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7142220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5w1l-0003Wq-O7
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5w0p-0002U8-RS; Wed, 12 Aug 2020 15:02:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5w0o-0006EL-CO; Wed, 12 Aug 2020 15:02:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so3048601wrl.4;
 Wed, 12 Aug 2020 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Uk5BShFRYcQUzFdAQhFuk3duAFMlAohm4jU9MUl0cfA=;
 b=m8/5fGRWbOuh3Yy68qMUgnuoHOmPCjOb9GnFUYKXuy5U9Ob2+ckHjhxG3s+IxWhC8B
 5PhOydsMF5r3E5TSemdqvmJEnwzUwWPkJNoxZCxuinf8S0Y5w46G8zXxcdJNeRG5Q8BD
 B4zwbusGCYG9nmcbVt7+6C34vURAL/5U6YtbAfh+W5tUtBpFJwRhRQsb1luiks/fR892
 Qek0c+pflhXZEqihmixQQ01a9kXz2qzDw+agJhVchbvhhqpAmfD3mohhDhxOVK30I8Xy
 LtynTi5e//YFuNzWjLraR6ogRmzG69KZA75bZlpKYtyTxBdFKOeGcCjcKAxLjpQo+VeI
 pklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Uk5BShFRYcQUzFdAQhFuk3duAFMlAohm4jU9MUl0cfA=;
 b=uBbT7JCZyNt4wjrOYXW3ULk/q8sNWx9JJS7ygBN6Kf2OWvOEIRgLJAesj3ok4UA03W
 pXKyxwaTO1TAVtvQ29ZVLoFMDKByNQFK6detubGcuAua4clcS0701aGo6NthV4dHwtz9
 JmBkK7XxuLgkvEzkGpdGAN5Ufmdy5C9nV3RKP8nsb2iryuVvLgAY50p9nyGte5jS7ewk
 5Uq6eaFlcOO2lF6027vgr/kb4/vIbJUFqrAn9I9jeMfZ49fnrkCMX327mxE20BOcJBXR
 ufO36hK42zAsJg2g3dLn2RX+2zbatTe/XAj/TAnCEWYVkQjz6CNcX7DHiUMUvqeLlhYR
 Pt+A==
X-Gm-Message-State: AOAM531PtEtxrSdBvNNcZBl48ncU82gAmCIiBhbt09/+CDooAF1WIKn3
 DM95w2LIny+2lJM0+f7Q6tbOA/fd
X-Google-Smtp-Source: ABdhPJwSSafyzxx4ZbtFWQuZopYdEokCeKz+Xh+/o3btbsxMzplGmQNKSUqgckSU7q7Qujsl1Cm38g==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr560781wrg.7.1597258927981;
 Wed, 12 Aug 2020 12:02:07 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z12sm5689441wrp.20.2020.08.12.12.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 12:02:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hw/misc/unimp: Improve how offset/value are displayed
Date: Wed, 12 Aug 2020 21:02:03 +0200
Message-Id: <20200812190206.31595-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series aims to ease looking at the '-d unimp' output reported
by the UnimplementedDevice.

- read/write accesses are now aligned
- the value format width uses the access size
- the offset (address) uses the size of the memory region it belongs

Series fully reviewed.

Since v1:
- Use DIV_ROUND_UP instead of ROUND_UP (rth)
- Added rth R-b tags

$ git backport-diff -u v1 -r origin/master..
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[----] [--] 'hw/misc/unimp: Display value after offset'
002/3:[----] [--] 'hw/misc/unimp: Display the value with width of the access size'
003/3:[0002] [FC] 'hw/misc/unimp: Display the offset with width of the region size'

Philippe Mathieu-Daudé (3):
  hw/misc/unimp: Display value after offset
  hw/misc/unimp: Display the value with width of the access size
  hw/misc/unimp: Display the offset with width of the region size

 include/hw/misc/unimp.h |  1 +
 hw/misc/unimp.c         | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.21.3


