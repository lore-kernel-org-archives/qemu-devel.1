Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EE320767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5xFtwLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EE320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Ax-0001lg-Uf
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl8A8-0000ok-IH; Tue, 16 Jun 2020 05:45:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl8A7-00023o-4I; Tue, 16 Jun 2020 05:45:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id p5so20015348wrw.9;
 Tue, 16 Jun 2020 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BkfrXS6jUPlOeSckQNT81vLmPXJox8SVcSY2Hn3/dQU=;
 b=X5xFtwLtOOEPDu0XJMfuwgOijMyOKlho5ap4523Ap0QtiJ+AbQF1TQ/08/8QQ8sMFf
 vxFP0joX+6+Hx0RnwQ3FGwIotstkyizRgUcBB1Rq4iQUVYR5AUd7bNmLgi7tItR8IGrf
 MiRZDPnqsEC98BuFIUDPAqzTi2i1Nm9ACMSAqOkpk5VAaVxjLUsoUkGCv1YIXLs9FcWw
 uJRBmElBvPTITsT0yXMy3ksMeUXng0QIv4b1R87a6woicM2B6gae/zh4eWqsPaDZmlwe
 oHzHDelx28QdtJOvpSi+SnVxqhydoim9pAgvPD11tX4oceRsNerWwU9QbS19URDR7lHb
 7WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BkfrXS6jUPlOeSckQNT81vLmPXJox8SVcSY2Hn3/dQU=;
 b=fTpVIK8iabNa0cEF/R3P6QQyYTfTfBY7HyoOen81cX+SF+kRNszeoLTzer3izghaMP
 BNNcrQ3BV+/EsExLT8iEKPshddchaQZTLCDHSjifAc5WjTxyVS3gJvgSP8iRcy27/m/Q
 TyujDbR8UFAo9mSVyTetyW/FYOwAP7th/XkyDjFYmjfXdCax+PcCzeKMCAK7X/npfyJn
 kwXiZQrDGVOIYrn75DVqHRHWcbVHudFCa6hKNdGakK61HfokIUUT2zAB6HX5qZNDExxb
 tOUmCDty4MvoOwsf5IilKPv5DCC+JOqkPeaBlxBGXgJeKoQnhDyL81Vq2sW0nMxW/ZZT
 VQ9A==
X-Gm-Message-State: AOAM532e7VePo7IuAgNRnBU95bCmvnLYv46/lHf8VHKIIkMKaHdbBwPY
 T/CoM0U/CUYLwUXmms+upF7qVG/t
X-Google-Smtp-Source: ABdhPJwi47aKpRcMrb9z4W5IBm0LR9XQMl0nOFjQFxMuHqRR5j9j2q6BJTB5KdWu69xA5EOVJV4upw==
X-Received: by 2002:adf:e587:: with SMTP id l7mr2155993wrm.352.1592300745151; 
 Tue, 16 Jun 2020 02:45:45 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o82sm3254017wmo.40.2020.06.16.02.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:45:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/misc/pca9552: Trace LEDs events,
 make LEDs 13-15 as GPIOs
Date: Tue, 16 Jun 2020 11:45:40 +0200
Message-Id: <20200616094542.25415-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PCA9552 LEDs 13-15 can also be used as GPIOs.

Philippe Mathieu-Daudé (2):
  hw/misc/pca9552: Trace LED On/Off events
  hw/misc/pca9552: Make LEDs 13-15 also GPIOs

 include/hw/misc/pca9552.h |  2 ++
 hw/misc/pca9552.c         | 25 +++++++++++++++++++++++++
 hw/misc/trace-events      |  3 +++
 3 files changed, 30 insertions(+)

-- 
2.21.3


