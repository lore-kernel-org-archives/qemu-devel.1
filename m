Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53CDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D15820656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qr0CtjGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D15820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8Gm-00005y-NA
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8FZ-00070r-Tf
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8FX-0006tn-Hc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id a14so707280wra.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8oHZTezB8hG8Oa5+oRsXepYTQKI7/HJl0LCyIRwgGG0=;
 b=Qr0CtjGLwjMvtGEFYh34BZlLXmIfZSKxNXaDYVZBpUDiYDB9mCCYxi2gErB/GH0AhQ
 Vr5fQipcOkqdUZ5Xdv5KIcr10LHjWT3AVglo3e6l8rLeKcUrVV6swc8KL6OLMWwslLLo
 29R6plJ3Q2H+EV/Nm6FFhiR8bANZcQc3QIqKlZbYPdI8TmJt2hjaKbkU0++j+Ya+nHGz
 +R0HAN4jC6sBvHCQkvwX4q4QAMqdOqZjIQWfzm7lnFItDmAgRpQ1TpRv4aLGvhOD9zqp
 FPocw4WbU1bP915MF+3/GF/OGmsrzXUVkBOFEO0uUPykHUapX9uSWwqr3I09CxKEqUF/
 wsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8oHZTezB8hG8Oa5+oRsXepYTQKI7/HJl0LCyIRwgGG0=;
 b=GF4P4fcbAqZ/6vq8CPNf6d+XZaPE0xbZKRCZWrdQRILScBfthwU/SlslB8qCc0DZ2L
 7wTDvJbhkbIa7/dfEfH7GTco9w2BkJL2pzft/4O5HHAbnxLQYTQ67I6Td3K15Camerpe
 uNvYa8LbBMaRfSxr6kY4wChT804Jw1pUoOLP3VLQHu1qCjPQ8GMbsQADKkSFPgeDk7RJ
 kz1dG+PYxA/9YciYEcYVUFuz7aDcxyTdOSGk+pk/8pnMTokOkoFB0Phxaxg7ZOWzkhjZ
 mn7aMHGEoUOcW/DQAlXqxHVgTIskav009k3OglRirRHiJU2wpoANyaSsjSfE3vIGa0US
 5XYA==
X-Gm-Message-State: AOAM532ZlGSpYVattcXrBvH29Yqo+G+zHKlVAEdZXbpbX1U61LnpAtSg
 Wo7ZXY2d3E1F5VU/I2mbX9KIAw==
X-Google-Smtp-Source: ABdhPJw4Ito5tFViv1MMgo3GlZLPpeXjP3lYAtBu9xp5I/hYxfdaZdVfxqqusD9oTaU/cEefa5g4zA==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr3519324wrq.57.1595399345423; 
 Tue, 21 Jul 2020 23:29:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b186sm7141022wme.1.2020.07.21.23.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 000E51FF7E;
 Wed, 22 Jul 2020 07:29:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/12] candidate fixes for 5.1-rc1 (testing, semihosting,
 OOM tcg, x86 fpu)
Date: Wed, 22 Jul 2020 07:28:50 +0100
Message-Id: <20200722062902.24509-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current state of my candidate fixes for 5.1. Apart from
the revisions following reviews I was only going to add one more fix
(the pgd fallback code not using MAP_FIXED). But as is the usual way
of things I found a few bits and pieces on the way.

I haven't been able to replicate the original failure so testing would
be appreciated.

The following need review:

 - tests/docker: add support for DEB_KEYRING
 - tests/docker: fix binfmt_misc image building
 - tests/docker: fix update command due to python3 str/bytes distinction
 - linux-user: don't use MAP_FIXED in pgd_find_hole_fallback
 - accel/tcg: better handle memory constrained systems
 - util/oslib-win32: add qemu_get_host_physmem implementation
 - util: add qemu_get_host_physmem utility function


Alex Bennée (8):
  shippable: add one more qemu to registry url
  util: add qemu_get_host_physmem utility function
  util/oslib-win32: add qemu_get_host_physmem implementation
  accel/tcg: better handle memory constrained systems
  linux-user: don't use MAP_FIXED in pgd_find_hole_fallback
  tests/docker: fix update command due to python3 str/bytes distinction
  tests/docker: fix binfmt_misc image building
  tests/docker: add support for DEB_KEYRING

KONRAD Frederic (2):
  semihosting: defer connect_chardevs a little more to use serialx
  semihosting: don't send the trailing '\0'

Laszlo Ersek (1):
  target/i386: floatx80: avoid compound literals in static initializers

Laurent Vivier (1):
  linux-user: fix clock_nanosleep()

 include/fpu/softfloat.h                       |   1 +
 include/qemu/osdep.h                          |  15 +
 accel/tcg/translate-all.c                     |   7 +-
 hw/semihosting/console.c                      |   4 +-
 linux-user/elfload.c                          |  10 +-
 linux-user/syscall.c                          |  15 +-
 softmmu/vl.c                                  |   5 +-
 target/i386/fpu_helper.c                      | 426 +++++++++---------
 util/oslib-posix.c                            |  15 +
 util/oslib-win32.c                            |  17 +
 .shippable.yml                                |   2 +-
 tests/docker/Makefile.include                 |   2 +-
 tests/docker/docker.py                        |  13 +-
 tests/docker/dockerfiles/debian-bootstrap.pre |   7 +
 14 files changed, 307 insertions(+), 232 deletions(-)

-- 
2.20.1


