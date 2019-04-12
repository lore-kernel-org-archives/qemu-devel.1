Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FACFC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 04:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDA92073F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 04:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDtK6uEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA92073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEngC-0006zI-RA
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 00:20:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hEnfM-0006Y1-4c
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hEnfL-0005DP-8B
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:19:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hEnfH-0005CY-Vf; Fri, 12 Apr 2019 00:19:48 -0400
Received: by mail-pf1-x443.google.com with SMTP id 10so4488572pfo.5;
	Thu, 11 Apr 2019 21:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YIqMqtEzrgSvWYDYEAl/QC/5QT6B2u4URO5jB7ldbP0=;
	b=aDtK6uErx+iRnBMvRL+uxaQbXT8Z1xgKYjqlOY0ogkAdxGjEFUMFOyySa3Iem8tr2m
	EXFBlMQwUpBEzqe9FjyP+EBGXbdFK118S+iyKyWGwstZfp+u0GaMuOZZpD+7fnlv0vu4
	3+nxIi+nwsv0EBFGLATqrGP2GYZC/vVcCfKm7jq84TVWT55X2NS23KiSgJnTNXCqx6Yr
	/TDoZcqxn00j4i5HDqvcDdwxvLM3lkZpaWFo/NW/yamvrLC8U/bAXJPCI2y44HVSTgD0
	SO7m6aA/z9ovZjFeg4QvjRssgSDtM2oc6J5jprNCRr5ICrTknnb93Fk669ZuuvnFquO1
	aVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=YIqMqtEzrgSvWYDYEAl/QC/5QT6B2u4URO5jB7ldbP0=;
	b=K0mEc0cUcUpuluRpXY2p3YkOUcktBAhN0i12/8uQ5+XhZK4qU5Hvfc+rjreJXehCQ3
	tZ56ineUhZQG5Ph1QwtYK81mVJUkH8U8wpMANmsWAYqIYwvTwIKAjaIznpK7ycebn+hv
	DZzjR5pL6TEy7WNW2TyeE5rPCzpv0Td5O8IzXEvt00ucpog5sQ8kiE7FAn3r0YrXsg6x
	3Y1nUHYLHwRLvzPuZfuPTU+9UPELd8f1Kcz0vIICTbLBlM0QWhOjOCi2lX0Z9GLYmoFY
	LkIBuvu8mwXKFG+b1hf0M+X/RJYU3FzTyrLDD3KPmGHLr+ihZac9YJPFm3CoiAXN1zxa
	Xr5Q==
X-Gm-Message-State: APjAAAXu8Op3QPaSxaNYO+xyp2IYD4bBMQMmtoh99iK+Sj3trMzmvfNA
	SAW844U5DcDSKNvMYWT2cFg=
X-Google-Smtp-Source: APXvYqxkW6zQ83shynNi5BuJK9uCez17+7l4uaWizTu7mzeOMYZ4z7/owt0Apg/rO4dKIarVaEWxtg==
X-Received: by 2002:a63:6907:: with SMTP id e7mr42890931pgc.209.1555042785929; 
	Thu, 11 Apr 2019 21:19:45 -0700 (PDT)
Received: from voyager.jms.id.au ([36.255.48.244])
	by smtp.gmail.com with ESMTPSA id
	p14sm40590727pfa.26.2019.04.11.21.19.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Apr 2019 21:19:45 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
	Fri, 12 Apr 2019 13:49:38 +0930
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 12 Apr 2019 13:49:31 +0930
Message-Id: <20190412041933.12264-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 0/2] arm: aspeed: Add RTC Model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412041931.2xhacvw6Imiuwie9dKezcZIcJ0UTWtt0JJSRMFoDp2E@z>

v2: Minor fixes, added vmstate and reset, and rebased on Cédric's series

Based-on: 20190411161013.4514-4-clg@kaod.org
[PATCH 3/3] aspeed: use sysbus_init_child_obj() to initialize children

A model for the ASPEED BMC real time clock (RTC). The model is sufficient
for running the guest Linux kernel driver, and ticks in time with the
host when programmed.

It does not implement the alarm functionality, which includes the
interrupt.

Joel Stanley (2):
  hw: timer: Add ASPEED RTC device
  hw/arm/aspeed: Add RTC to SoC

 hw/arm/aspeed_soc.c           |  13 +++
 hw/timer/Makefile.objs        |   2 +-
 hw/timer/aspeed_rtc.c         | 180 ++++++++++++++++++++++++++++++++++
 hw/timer/trace-events         |   4 +
 include/hw/arm/aspeed_soc.h   |   2 +
 include/hw/timer/aspeed_rtc.h |  31 ++++++
 6 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 hw/timer/aspeed_rtc.c
 create mode 100644 include/hw/timer/aspeed_rtc.h

-- 
2.20.1


