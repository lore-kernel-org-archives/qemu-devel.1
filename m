Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD24120772
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzoFlmRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD24120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYG6-000874-IK
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEW-0005tA-Lw
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEU-0004dU-3d
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id k6so14062254wrn.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yXrx6SW8zqKj/mn32mzyhphYQKvlH+oGrD+d4c8vj0g=;
 b=ZzoFlmRpbFUQJRDfBTohtiDu6p0UdmU29K1sfmee3gZMwdsjoCa9ehwVWje+5InaB8
 HBZx5Of1KiLtLB+bGUV81w08aj0rz3hoy+L5QyRBHd/KvfgDgvqGuroaCtd98KBcsMHy
 3B0eKA9j2C3piPgCt9gw8vf8UbAyYTA2IVhgcchIKHTP7xzzgOPFBYFF1EvvfmEeiiOj
 vJMuNlFdH5hAwBWwHjJPEViKR/tGOivbzV1m9uWCbKFSQgHE6je9YIedeMNzWHUkPxkf
 FdCXx3zlouOfme1sTX7fLlsLAxiX3Nk2FxkW1SmjUFKVDzdAd4P15oTmdfRyN7D04eBl
 MZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yXrx6SW8zqKj/mn32mzyhphYQKvlH+oGrD+d4c8vj0g=;
 b=cPgmG+HYDZ2gUv98Pl2LMekOI3hLbmNEVMBicQNfoSF5aLAYge2mHS5CUfjxA5190B
 seeCQcEjrCintfI0Fqqxz2Qzm2cthpd1gzDqqO7PM5GVOSmzbLiwSuUlKA3/hvhyey39
 7k7BtKJnMyLfowyvLd4yQgdMjrYQtwPdey3PjW940xYgsFyBbpuEaNkW44LIdVU6pfQI
 M02La0kxdrM6RzQg2BKRJttakN5Pu4Ulv/wVbl/h8U+/4mIObdQTFIzLYOCRAxRIzD98
 nUIKa9+AcnObI5RFkzf0kV5hwhN+fPXmRFwf2OZhGjYmMv0kjjc572wal6UYA4HQPnQN
 LcNA==
X-Gm-Message-State: AOAM530ZwLjBw95V15pcegRjT4DXB5AAbLJ4Sq2dxia0gbo6Uy0Me/4v
 Jow22F834C/iBJ3M+BiDRwGajQ==
X-Google-Smtp-Source: ABdhPJwatJgqLS5mx7wGSySScGyRSVSYcAv9SWt8bTLgr/3IebYOe1gYMaeDIJuLecJm1PD4FrfKhw==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr13888580wrn.166.1593354272269; 
 Sun, 28 Jun 2020 07:24:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/17] spitz: fix hacks, fix CID 1421913, various cleanups
Date: Sun, 28 Jun 2020 15:24:12 +0100
Message-Id: <20200628142429.17111-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches makes various cleanups to the spitz board
family code; the main driver here was fixing the minor Coverity
nit CID 1421913, which is a complaint that the call to
qemu_allocate_irqs() creates memory that is leaked.

We fix this by replacing the free-standing irq array and
callback function with a proper QOM device TYPE_SPITZ_MISC_GPIO,
which can have its own GPIO inputs and outputs which we can wire
up as appropriate. This also allows us to remove the ugly
file-scope variables that pointed to some of the devices on the
board so that the old callback function could prod them.

For this to work we need to add QOM properties and input GPIOs
to the max111x ADC devices so that we can control them that
way rather than by direct calls to max111x_set_input().
While we're in that bit of old code we take the opportunity to
get rid of its call to vmstate_register() and to give it a reset
method and a header file so we can document it a bit better.

The last few patches are unrelated cleanup that I noticed in
passing: we reduce the use of the zaurus_printf() macro in favour
of LOG_GUEST_ERROR logging for bad register accesess, and we
get rid of the old FROM_SSI_SLAVE which can be replaced with
QOM cast macros.

Patch 1 removes the hardcoded tabs in spitz.c, because they've
escaped our usual "fix as we touch a file" policy long enough,
and it's easier to do a wholesale detabify of the file before
starting.

As you review this series you might notice some other things in the
code that could also be cleaned up; so did I, but I felt that
17 patches was quite enough to be going on with :-)

thanks
-- PMM

Peter Maydell (17):
  hw/arm/spitz: Detabify
  hw/arm/spitz: Create SpitzMachineClass abstract base class
  hw/arm/spitz: Keep pointers to MPU and SSI devices in
    SpitzMachineState
  hw/arm/spitz: Keep pointers to scp0, scp1 in SpitzMachineState
  hw/arm/spitz: Implement inbound GPIO lines for bit5 and power signals
  hw/misc/max111x: provide QOM properties for setting initial values
  hw/misc/max111x: Don't use vmstate_register()
  ssi: Add ssi_realize_and_unref()
  hw/arm/spitz: Use max111x properties to set initial values
  hw/misc/max111x: Use GPIO lines rather than max111x_set_input()
  hw/misc/max111x: Create header file for documentation, TYPE_ macros
  hw/arm/spitz: Encapsulate misc GPIO handling in a device
  hw/gpio/zaurus.c: Use LOG_GUEST_ERROR for bad guest register accesses
  hw/arm/spitz: Use LOG_GUEST_ERROR for bad guest register accesses
  hw/arm/pxa2xx_pic: Use LOG_GUEST_ERROR for bad guest register accesses
  hw/arm/spitz: Provide usual QOM macros for corgi-ssp and spitz-lcdtg
  Replace uses of FROM_SSI_SLAVE() macro with QOM casts

 include/hw/arm/pxa.h      |   1 -
 include/hw/arm/sharpsl.h  |   3 -
 include/hw/misc/max111x.h |  57 +++++
 include/hw/ssi/ssi.h      |  31 ++-
 hw/arm/pxa2xx_pic.c       |   9 +-
 hw/arm/spitz.c            | 507 ++++++++++++++++++++++----------------
 hw/arm/z2.c               |  11 +-
 hw/display/ads7846.c      |   9 +-
 hw/display/ssd0323.c      |  10 +-
 hw/gpio/zaurus.c          |  12 +-
 hw/misc/max111x.c         |  87 ++++---
 hw/sd/ssi-sd.c            |   4 +-
 hw/ssi/ssi.c              |   7 +-
 MAINTAINERS               |   1 +
 14 files changed, 474 insertions(+), 275 deletions(-)
 create mode 100644 include/hw/misc/max111x.h

-- 
2.20.1


