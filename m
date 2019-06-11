Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03018C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8CF20665
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4Esrwb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8CF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahPu-00018z-I3
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hahLz-0007fT-Bh
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hahLy-00058a-21
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:02:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hahLx-00053i-Jl
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:02:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id x15so3096072wmj.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JSl0k1sCyaLaV8GlGWpZmR3qtvOgRYDvZ0iR3jZR8EM=;
 b=x4Esrwb/6L8++PkSFezfEdgWxdCvwxv0fkjQKKt7NsQ/O7KeIcEMmAjE0NkrNeciJe
 HF+jk15yVCROQUuuV2SfeS1qjPSorY0iiRCvOEZ7OLQ8VYU92kImqWdWPeyxa0atOFLT
 qsdEkuZF30pc3hsQsXxvupR/OK4TY92BvWxBa9H9nxgtSfv49xdW0Gme88+55HspPF4L
 UTr1vRsZnpddnpOjGo5SwSz5v9ilZ4IkDCr7bLPbT/JRepV4ezKhlk/aCWbhDnZ8UVeO
 m0dWOuhTdcLXVaNTkKpmTEMM2516CJ6YgS5qWaj0cdxYdJK1+Dh5qObCzcQ47fvR7ceS
 /4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=JSl0k1sCyaLaV8GlGWpZmR3qtvOgRYDvZ0iR3jZR8EM=;
 b=hBXgj2dB3xaYaXRR1rt7a/2n47k+MUPnyJn1Jlfyxtg5F4D4Vp9VAVQckubK3c6t1B
 hminq7t7wu0SpSggQn//8PAr4upJ9oZNr9Xfg65FO8LDjtoppTdI6fkrIHpUn5S5ab+Z
 OGCNERp3aZ/oG0c80+bjE6N8+TqCiFPVrqPPBEm3ak+xFvC4jl3tpjulcDxe4IZYKZH/
 JyRbNhur9fdO0ZxkdYdJk387DB85tFjQz22qNeJzFfnQp3ZgLxWhbAJ2Sm7Wkn4KHLuR
 PSz8sc5yWtOjrdrnP/k6FPeFUgrrTSgFEFS4Y3VITICq3p0veHeKbdj5E/63sSmuIsfM
 3IFg==
X-Gm-Message-State: APjAAAWwkAKoSfCNounn9GyOrvrXhYGwRBq2hf3cHcpgj32cMkJ7rEEn
 HRNfP+G9vGG7tsHHtP3CA2HeyA==
X-Google-Smtp-Source: APXvYqzff82Kd9xtf4Edm9vm8A3EtRFrbztYO4IQWM7heQ2NC71cyoA7PQerjuNvjA72Gh595G0uLw==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr16802687wma.23.1560261738046; 
 Tue, 11 Jun 2019 07:02:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v3sm1744029wmh.31.2019.06.11.07.02.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 07:02:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EF95D1FF87;
 Tue, 11 Jun 2019 15:02:16 +0100 (BST)
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@redhat.com>
Date: Tue, 11 Jun 2019 15:02:16 +0100
Message-ID: <871s00fcev.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] Flash emulation questions
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Phillipe,

There has been some interest expressed in adding support for RPMB flash
partitions for the benefit of secure firmwares like OPTEE. I'm just
trying to scope out what sort of work would need to be done for it.

RPMB (Replay Protect Memory Block) is a special eMMC partition which
requires a key and write counter to unlock and write sectors to it. It's
not clear if the partition itself is only accessible to the secure world
or if that's just the only part of the world that has a copy of the key
to do the unlock sequence.

So a few quick questions:

Do we have a common emmc emulation in QEMU?

It seems there are numerous hw specific bits (omap_mmc, pxa2xx_mmci) and
what looks like a common sd.c. Would this be the place to support RPMB?

I assume the easiest way would be to add some qdev properties that can
enable RPMB behaviour for segments of the flash which can be set when
the machine initializes.

Where do the pflash device types sit in this scheme?

They are the default goto device for bios flash devices on a range of
machines but AIUI they follow a different flash programming spec (Intel
or AMD). Would we want to be able to instantiate a "virt" machine with a
sdhci backed flash instead of the default pflash? Should we have a new
machine type that defaults to secure components?


--
Alex Benn=C3=A9e

