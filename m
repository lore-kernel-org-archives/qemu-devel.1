Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2ECC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1225920720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNtTbb8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1225920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juBF8-0000af-CC
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 04:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juBEX-00008y-Mz
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:51:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juBEV-000813-Pl
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:51:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id o2so8177883wmh.2
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7clw+t0uKWKhdhiYKA1+T6Hh9/vZ1fsButZLr1IJHSU=;
 b=GNtTbb8Fx8goDv6CI8mQNzzY3f2l82FG/X5zBjfYs/EOVJLddDbQI3vH6IJC36VUI8
 uhv9sF/pZWDqEgqbozi+QDdvPbBHcw7N3/9HzYGr3gZJkSdP/YmbNTW1dcsXvFNRjSaZ
 GeIr05ap1GC2Zq3F+iyARhLFQUxsTfOb0cybp3I44/XJE32htunW/JdoXi9ZchWzImjT
 AXUXmF4YiCrR4uUyvdSCcKrrwmsjnqw1lyo5AAqn13UyyFd7L0B7Ot4cUxkhHUEWC+sB
 z8Mx2izs8eFs4P4AVmWqdd3Qo5iMuJjB73DlWGv3Iqehcbo55VPgfmBaEZQ6lrYh8qDs
 2Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7clw+t0uKWKhdhiYKA1+T6Hh9/vZ1fsButZLr1IJHSU=;
 b=m0N1dDIG1H97hxeXqrELQVCt8zyJyWkP23mMx9nQftNZiCqGIe4V5APY7m3kCOkHOY
 uowstlzVF06koZKdoQe0m/OfGECilhxWf/VuoR9E56XKvnQLF6FBvKMt1zLLL+7yJ3cx
 ZrHNrwrkvIgaDtoHiAV3Bz9U1eTEJpaa6zLy6ndqo9qfF97zfvvDHckro+89TKIqg6xo
 p/uqnFQgV3iqcAQxnxXEok9L20ysHkARO2hnxwBk83Th1uDeZ1Tbqxrr2dMFHc7m+AzT
 TdxdlvFuSz0Xxk31rOdMojII19luBc3J4OFDh1UPAAHQ+qSyuSf8jZRK6SOZJcyuS9eY
 GmCw==
X-Gm-Message-State: AOAM532qjZqRZRwdaAj7fhm6Ln/6/tAt9VZjqwbexPYQmTQv5AE9H7tl
 ufHFrZOwLBBiHhgOS5Rx4OKJ7w==
X-Google-Smtp-Source: ABdhPJwH4KBeXfo1TcFlOTL+7NW19EF7si9WxyJMLa/9Pd38VdEbkXgZLIyEW6uDb/On1mgt6PRxAg==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr8874327wmt.105.1594457501287; 
 Sat, 11 Jul 2020 01:51:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w13sm13671548wrr.67.2020.07.11.01.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 01:51:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D8291FF7E;
 Sat, 11 Jul 2020 09:51:38 +0100 (BST)
References: <20200710203652.9708-1-kraxel@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/2] module fixes
In-reply-to: <20200710203652.9708-1-kraxel@redhat.com>
Date: Sat, 11 Jul 2020 09:51:37 +0100
Message-ID: <87wo3aqvs6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> Gerd Hoffmann (2):
>   tests: fix "make check-qtest" for modular builds
>   Revert "vga: build virtio-gpu as module"

Queued to pr/100720-testing-and-misc-2, thanks.

>
>  util/module.c                |  6 ------
>  hw/display/Makefile.objs     | 23 ++++++++++-------------
>  tests/qtest/Makefile.include |  1 +
>  3 files changed, 11 insertions(+), 19 deletions(-)


--=20
Alex Benn=C3=A9e

