Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3017AC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1F420820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OY0BnNFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1F420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Tp0-0004Dz-0X
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5To4-0003oQ-4h
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5To2-0002eJ-4U
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:50:35 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:37739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5To1-0002dn-Uz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:50:34 -0400
Received: by mail-oi1-x236.google.com with SMTP id v7so1480374oib.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=Xo2C27fPYSUSHDwOxRgYQnm/cD5jjZDzWbpPHN2McV4=;
 b=OY0BnNFPPkwWPu8rUdBHjfOy69biepYKUAToCoNuduqjNH5kyxgG7xXGczTIaom2TS
 1sQ54M0LYMAKYFHFGG2bJIpKDmep1XqqE1fryOdPbNPtRXeEg+QFnagoUTTFeYbY2YO9
 AwhUEG1NbLlrkKtmjETv1Z+nGnwGmb0Nm75dRmaF8LUqachJJhHjInibehG3s5qEzyrF
 PtsH0aqW7DdT7uiSkLOOSpVwVS9ekwXVN4whuCDC0uKDl0apFkcuDHSPSvek1ByOolQY
 31Q0r5/PHsMaQf2EYV2FHtLvohvD7dGXbsEWY0NXieFmYtXFeCTiwjiZqO7W06AQEIlH
 71AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Xo2C27fPYSUSHDwOxRgYQnm/cD5jjZDzWbpPHN2McV4=;
 b=UNbpfX5qYZmyjOHuO3QYBk2fvv/HSYKvQQeVKHm2wV7cxXWQW4ZITg7cUirLsP8tLn
 wcefueAgiH3jXBwVBh3bKWeCZbtC5oLkGkHJLQhWvBxk2p15gxaeN5MxdhmlT+o/Pqhx
 v2otYyi6b7B/KKvN0bKUzc6wLltXoS2Lrm0tH+G8X0yC5RgG+QKk8mzXE2OFoMFn7O+9
 jSEwI4c0TfxJ0X2xN7HnOPol/mMqzF6Hlax/EGK3cGe7hjMOTRm64GVf4JRQojHCLmmU
 lU/9QsPQ2F36rzIlChMJkEo29UDpJJtKUfLwEanPBKwUKfTmDW0c3nEYsCKqFryCzMly
 FS/A==
X-Gm-Message-State: APjAAAUyCQKWJ6E89rSqwLHOx/12eMeFYCq0L985d8mm873RybJ0L784
 iBqBD3n0uML1dRVqwE3679S85DD6lGvwH+f2YcGZBSRkC2Q=
X-Google-Smtp-Source: APXvYqxgEgfeoJX/yCq2Pm63Wn2sm5J8EZj0EMG7Ybt6emCZslGUgj1Bv4iv+hRxM3154MRjATcqSgvaRe0cWeNUyAA=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr2805578oib.48.1567597832402; 
 Wed, 04 Sep 2019 04:50:32 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 12:50:21 +0100
Message-ID: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: [Qemu-devel] test-aio-multithread assertion
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; I've been seeing intermittently on the BSDs this assertion
running test-aio-multithread as part of 'make check':

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
tests/test-aio-multithread -m=quick -k --tap < /dev/null |
./scripts/tap-drive
r.pl --test-name="test-aio-multithread"
PASS 1 test-aio-multithread /aio/multi/lifecycle
PASS 2 test-aio-multithread /aio/multi/schedule
ERROR - too few tests run (expected 5, got 2)
Assertion failed: (!qemu_lockcnt_count(&ctx->list_lock)), function
aio_ctx_finalize, file /home/qemu/qemu-test.kaRA0o/src/util/async.c,
line 283.
Abort trap (core dumped)
gmake: *** [/home/qemu/qemu-test.kaRA0o/src/tests/Makefile.include:905:
check-unit] Error 1

Anybody got any ideas?

(this is with the tests/vm setups; I've seen this on FreeBSD
and NetBSD.)

thanks
-- PMM

