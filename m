Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6534C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE3B2075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9E+2DQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE3B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1su-0004hx-Ss
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1g1-0008Vo-7y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1fz-0006Cd-Mm
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id m6so6592849wrn.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A1ZzYbjxs3SI6wFiB7NslbSM1TQ862wBVt3L6OuFAno=;
 b=g9E+2DQ8OMX4aAaM0aY74YPD8uO/QEcg3Qik4ZyXhqPQ91FVKQbiDOW5L+fAhoS0sg
 zo0zs14nRQOmWlXng2LTD8z/XkekXpBUqWl1zH/TTuzG/Koo8LzS2skqxmLSMNGzi4+0
 trfxFdGPiXbxOshrQh1SHP3OLFJH71dl5ooDi1rD/2VLjbMqjIRkKt4gUHB5kv6ytHtL
 dDHYIrQsezsuYQJLypTyq6rqmOb9ZwDJmt/0E6P0oR8tQAny3+Dp6tIsxAoXrqCC8mHl
 NDa2QMiEtGI2q+oya6dhrZx+GvbbVzwsuv3dpExFFt8WLozSeRI01H6B9qN39OardoUj
 BsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=A1ZzYbjxs3SI6wFiB7NslbSM1TQ862wBVt3L6OuFAno=;
 b=Rm5FbhAIn6UuCarZgkvvXOB8zn1eZl6fnvF8X6i24U74dVLaHZTPi4r4UOPm67NEI3
 q2bAe3+WOl6jRnSX9xwTsR2G5hBrjSTsPfGhXkrg3ltSoLBK/wzRcmGJSTJaKkOJ87R4
 vAUB9Cct43TjNC7RH5ED+kuVnFkb25OOUkl7QdXZHQv6w8CQ8/NPO4118XHqrGxFZdGp
 k9ynmZRco9gRsZfnxwhX2fchp/OFCESh2V8Kz4smP/wUIOimgpF651iRAWO+Oro2Bb53
 5dSbx5FG/bAhsX0jTMeJtPQD6vj9dWV8TuQAJb88/9AjQyaml9E0gQngw5HINCL57FFD
 hiyA==
X-Gm-Message-State: AOAM532p16axaBiRZiddft68eQw/dQKlGg4Aun+7yGHb2ZwIFaFjb2mU
 2GQ3buOGPmnEq9mFHfDtbVImWSVvdVY=
X-Google-Smtp-Source: ABdhPJxLkGSZuymBvtjGaUZYMGXASSg0bIRIXeO3J95pM318jNKYT+ejLuymiiuOVQ8YGMAw1RKNUQ==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr10807501wrv.25.1601570605393; 
 Thu, 01 Oct 2020 09:43:25 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h3sm10733059wrq.0.2020.10.01.09.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:43:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] qdev-clock: Minor improvements to the Clock API
Date: Thu,  1 Oct 2020 18:43:19 +0200
Message-Id: <20201001164322.1585392-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handy patches while using the Clock API:
- display frequency in SI scaled unit
- display error hint when device lack clock support

Since v1:
- Avoid out-of-bound array access (Luc)

Patch missing review:
- #1 "Introduce freq_to_str() to display Hertz units"

Philippe Mathieu-Daudé (3):
  util/cutils: Introduce freq_to_str() to display Hertz units
  qdev-monitor: Display frequencies scaled to SI unit
  hw/qdev-clock: Display error hint when clock is missing from device

 include/qemu/cutils.h | 12 ++++++++++++
 hw/core/qdev-clock.c  | 11 +++++++++++
 qdev-monitor.c        |  8 +++++---
 util/cutils.c         | 14 ++++++++++++++
 4 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.26.2


