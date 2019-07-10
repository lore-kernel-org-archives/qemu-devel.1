Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A8C74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46F32086D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BzOr0ufO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46F32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlEiq-00078c-Th
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 11:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlEhf-0006gK-SX
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlEhf-0004ky-0j
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:40:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlEhe-0004hp-PJ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:40:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id b7so2554856otl.11
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mf8gqTbBctUe969CFeVPYQdQXvCiwYF1mLCjQz6cWWU=;
 b=BzOr0ufO5wQkhWV6Zyk+IRMMhbQVD3b/xg9fQDe3JHFn9dhxxIPoB8Adg/VyYCcyqu
 mfVPEDRjMTYLrdAm6CpTn6Zy8t3fDVvoiuTo9wtiX9Ijd+aKTWSg7Nnqu5/Lw4DXPFz7
 Q8wORNMajN4LIuTTcdeOXvuo/3h4Bb1sTX/uF1+oQboEU8PxSrwV6jZXFPfupRbHRf9o
 qknFwhjFM6W4CVjxwgRb9zkFjjOHt0R8LPaun1IvJdfFijOBEDgJnXwZlusiRwpI97Gt
 225WJYpWXp0yxRcKLhbs6Bw1uyv7Wq1PKYRRijMReDcXQPSzCJoYcYbA/fVFOz+f7cec
 Hp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mf8gqTbBctUe969CFeVPYQdQXvCiwYF1mLCjQz6cWWU=;
 b=mypMGcI1k5i12DOSxCMD22caaycasevbLhq9Ipkg3048QiG/Z5lKvXDu53c688W7ay
 wiYZHK44uwTl/DR0Q1XfNVyfIzZ2Aw9J62sJ0K8ZfAKkliklfASXzZHQ/fvxeGCpF8ZL
 5tpIrXA7lAPYylAxtJ6Te3WiEJubQwHkaQVZwTADLmDkgeVsVgUG6HrkKPel1LXZ/Eir
 J/Uxj0ca4atsIacBqcwWiYO5QAjTriKqbhruEC/lqopgjysOM463NXQAVvMTH3HcbmrB
 GSqfv0U+vgj1qdr7FHBl9krIpU72Z4fjdMKcbe5TG+GrFXLb2lOTpkaT+WhP/JPnjiQK
 GG/w==
X-Gm-Message-State: APjAAAVqGa7ATNWrefJSaghfqgl0n1oluYt1O/i2LwCMpXSIF5ZaXVRV
 P1UNmvq2Nvm1ARgaQdJiE9ZbRxwFjfrobYFjEGpYXw==
X-Google-Smtp-Source: APXvYqw9Xyvn01o7XPm1K3rgrQR4ec2YjqWSjw3oz5Kx6BFtIufCDYbE0Y6sqHTBtE3BvB95QcoAXOi3W65mnkmrCMI=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr25115857otn.135.1562773216748; 
 Wed, 10 Jul 2019 08:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190709184823.4135-1-richard.henderson@linaro.org>
 <CAL1e-=i7Paug3G4xFCVRpH=NadNti1oG9y8n7geUJeGDoizc4w@mail.gmail.com>
In-Reply-To: <CAL1e-=i7Paug3G4xFCVRpH=NadNti1oG9y8n7geUJeGDoizc4w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jul 2019 16:40:05 +0100
Message-ID: <CAFEAcA-wJ9hTvk90wikTFU669Qh4sfZyDZvjZaHo=P-eF_v26w@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: Fix output of extract2 opcodes
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jul 2019 at 10:22, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> The commit message looks more like a list of some random items
> than logical explanation of the code change. Improve it.

Can you be less combative in your review comments, please?
Providing constructive and specific suggestions for the
improvements you'd like to see is more likely to help
us produce better software than abrupt orders to "improve it".

This is about the third or fourth time you've done this
with RTH's patches and I think it is not really warranted.

thanks
-- PMM

