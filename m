Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBFCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E739720869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUhIGuGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E739720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgJg-0007r4-Hs
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHj-0006AB-AP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHi-0000zG-26
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:36:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRgHh-0000yq-OW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:36:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id x4so6489293wmi.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PD+JSR621lvpf+Sd+2ith67t1fURq8YcQZUW9FkbrMc=;
 b=kUhIGuGJx3FbwbbP+V1zRsuOJQ9iuT0m0e2wQ+0fV9pBpNsSAvLbHjMPf/RhnxKxOV
 mgbFMGSJU76VEDFNO2Lap0vPMLrTJ/yWczt8hx/imNVdG4lxQ4UOIyTMBaPVKw4HXjgk
 nAKg5JfNIlGJ7UrDDifs2riMLGxKb7tqtQnii21nX5OQL9hexqd69GpFMUwzY+SdnTC/
 ECMpp/u4l6+6y3kHaHEa3SMaqpvkDI0vqoMCBVxAnkrmRyaqGhhU1RBoADHSw9WaFbfm
 27wG3sWSCoyH50ciOCOUw6MldRJL9Bb/Intc84xn1u8F1lf5BqkJbpyaZddMlcEgNlf3
 XZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PD+JSR621lvpf+Sd+2ith67t1fURq8YcQZUW9FkbrMc=;
 b=GdYiHXho8n3sE5Oq3UBEV3dvw4n0Y7xqgtNgobJftpBWKR1K4NvPc6METPUJl8KJ/c
 7q862FuhfICmMSVxeV7y4tJXVtnhosVINsSw7n77Y3AFx3JRsaGcRYtl7yR/cg4fVP+N
 57Jei/EYIp0NqQT4ipdYyVXEyjv8OdSA/zKEYAMPvqPggYR2rDJh+GNluAN+Jzgr0NHy
 IICrt8tSnYetQD/2GPaq8QSQk9qhpxMrS4IWoy/vtSvnGuP2qEVwHw3EJ6/SycOKhOqs
 NyNmQLIyLyrN/3ulhD/Dz25I9ajl/zWPoW0O0UDqtInHxlYo8DSfbrmBz/G7r2rMJH5g
 6/RA==
X-Gm-Message-State: APjAAAXh++5POpaMeljCifQgROblVtmrGcqmLxQjWOnTpTYYzUsVpE13
 JaS0eRI4OW+AOBWbUVChoUuYgA==
X-Google-Smtp-Source: APXvYqxddFduzAS1+tgaOxzQi3JakfbzZrRGDGhrsm5bTE1hu4bAERgJw+DQ0SZQHyG1l7Nd6c1vUQ==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr242723wmf.24.1572889016151;
 Mon, 04 Nov 2019 09:36:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 11sm20026836wmb.34.2019.11.04.09.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:36:55 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E7C61FF87;
 Mon,  4 Nov 2019 17:36:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/6] testing/next (netbsd stuff)
Date: Mon,  4 Nov 2019 17:36:48 +0000
Message-Id: <20191104173654.30125-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As we approach hard-freeze I'm trying to temper what comes in through
the testing/next tree. However it would be nice to get the NetBSD upto
speed with the other NetBSDs. Although the serial install is working
well for me this has had a rocky road so if others could also give it
a good testing that would be great. I've also disabled one of the
regular failing tests for non-Linux targets. There are other tests
that still fail however including the tests/test-aio-multithread which
asserts in the async utils around about 20% of the time:

  assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
    "/home/qemu/qemu-test.nS1czd/src/util/async.c", line 279, function
    "aio_ctx_finalize"

You can run:

  make vm-build-netbsd TARGET_LIST=x86_64-softmmu BUILD_TARGET=check-unit

on repeat to trigger it. If anyone has cycles to work out why please
have a look.

The following patches need review:
   05 - tests only run ipmi bt test if CONFIG_LINUX
   06 - tests vm support sites with sha512 checksums

Alex Bennée (2):
  tests: only run ipmi-bt-test if CONFIG_LINUX
  tests/vm: support sites with sha512 checksums

Gerd Hoffmann (4):
  tests/vm: netbsd autoinstall, using serial console
  tests/vm: add console_consume helper
  tests/vm: use console_consume for netbsd
  tests/vm: update netbsd to version 8.1

 tests/Makefile.include |   2 +
 tests/vm/basevm.py     |  29 ++++++-
 tests/vm/netbsd        | 190 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 209 insertions(+), 12 deletions(-)

-- 
2.20.1


