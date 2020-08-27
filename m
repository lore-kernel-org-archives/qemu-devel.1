Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCF522CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVREqagB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCF522CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHYC-00066d-IQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBHWf-0004eL-8b
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:01:09 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBHWd-0001BS-EQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:01:08 -0400
Received: by mail-ed1-x541.google.com with SMTP id n26so393483edv.13
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HwnMBZ0Xa2ornS7ieOgEsGB/1HJECozKOZjHwZWJ+WQ=;
 b=nVREqagBqrseSpBqJHNdQ9sdHZDC2c9Kbze9ywB5xGCV5mOXxLg3lqtkj12UBtmgqm
 zl6DIeHc19ephe9YyfDslOPwTzGnBE5iFchjBmxW5q7dI8SBJJqtP7sVSZQuumd3Bnt1
 VHc5uglgaedNII0lk24xpGuzCHkZF0BGxC4ZEbLoou5GDQlBCMGhbR6WzGb0aJAA3Kod
 M7bBpMcro94Y3s9Qdp2LuT+/ma3XscGYQYI2Xr4CmJK3VgXfHIJd/GcZ52NOEo43zH2C
 +VjNDlZyEkKDbVc5vG78Hy9Twhq13mlXAWghNZdqmi2pPiMgV5T8LjGlH+u+ZqojrqiQ
 FUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HwnMBZ0Xa2ornS7ieOgEsGB/1HJECozKOZjHwZWJ+WQ=;
 b=ebijfKkBFQowTUcs5sXCE5QscQJ6xU9SaK5TdgvVrStzFNZFBNcA5/pMM9Fte0/EfP
 CudrZvRlCBPHvna8sct7YjmGIFdZCDaw+J0qTu3DECrrhIFy+1m8ooorcVR3chhA+dOW
 VWP1YtVnOjqmjaH28LKVn/F3Nukshk+p8SoBHINlcY8esHNFtbpcObcoJeyt1HGvacER
 Rp+VA383lR0wQIJ2qpurdZGt3BPfjbIW6lRB6Py5w14uCDOd9CFCzivmLAOy05ciBZR6
 HhGY0Id8bwMgPIkhFa2cOAEAmxgveZydBFhUIaF76WgBpsIFWBhzIY5uYFS6eLlBCgld
 bhgQ==
X-Gm-Message-State: AOAM533uDF2EcpztH4hCR3IzkuCJtrvzl5F1M4e1F8kag+IkPvyAe8Ew
 6u+7hsNeE6+eV4s0vpYyf6jQDokN5BZE8zqckumelA==
X-Google-Smtp-Source: ABdhPJySMnEk/HM96NDHk+GotKLqPFFdl4Q5Hl4reTBs2rtB7GL53fM8I+WM3LoOvLeJrXJ/MfkW9mE7MFc6r8UmkIM=
X-Received: by 2002:a50:da44:: with SMTP id a4mr20307706edk.36.1598533266069; 
 Thu, 27 Aug 2020 06:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200826181006.4097163-1-ehabkost@redhat.com>
In-Reply-To: <20200826181006.4097163-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 14:00:55 +0100
Message-ID: <CAFEAcA-VuODmgo=8WeFP=gEBdOr8K1HxvPN7hdp4AYHnBh6A6Q@mail.gmail.com>
Subject: Re: [PATCH] armsse: Define ARMSSEClass correctly
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 19:10, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> TYPE_ARM_SSE is a TYPE_SYS_BUS_DEVICE subclass, but
> ARMSSEClass::parent_class is declared as DeviceClass.

Whoops, I clearly managed to mangle the definition of this
class quite badly :-)

Applied to target-arm.next, thanks.

-- PMM

