Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9612098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvQZ0Ub5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9612098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXz4-00008q-Sy
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlXyU-00089Z-GH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:19:30 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:43295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlXyS-00021h-CD
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:19:30 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id i4so383506ooj.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MYs39ZPH2ABKydBzqQ5sDzT90pNDso7176kAX2Ev6a8=;
 b=cvQZ0Ub5vG2zbyIdzJ7uXnPB0BRpg/Q8gLTqJfjpfxJGJDZlGOIg4vDHK3BM+dhhvR
 dy60pBtHG5EW6mUiZmUtB32SIh0Pl7oD+njGsQmXKPPMBKwFM08H8o1pafW3IuDS2u/D
 /DjCkvMaP6gQKX8cDByH3RWWCWdpp64o4gMQJfSrG9pm3eMfcHDJXHGNWw72TlCEmvTI
 2oSfm24NqMyXWFHGvv2RuSc15/78sUhH2XJdwoNMleahePkGEcxw0rxh7lWgPY136Eto
 YnQPyz0G4nY3uFwJDFVYiaz1SGuwiK7MDadUeHliTeNokD2r1WgM34fBUsTclFl2fski
 n/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MYs39ZPH2ABKydBzqQ5sDzT90pNDso7176kAX2Ev6a8=;
 b=oXRLmcyoaZnRXu0vnf759bZ6KHssFyFh40Xwp1uAHP/QCAvLLh0cmIrJZPpLgYnzjR
 TA/WgBmrgN5n38dAfauJuT8ldjSUDCyxXBGJ7lKRyOW4ZHUN3S3qhE1iPo3U7HuuswWB
 TJdlGzjAYr+wq600dTIz5vayjQqyJjhN7a0b3hq+iaNJbi4JUaM3kfBF/ssylen5VMj9
 Adjuva29CPlXf0Xd8HJm1MAPzXn4NiC3dw7lxdds1bjR+UgAHNrGvMHKbJVt2jol+GyR
 nPNGOxKboODv+agogNM2mVuJ+Sl1u9koz8zulGSrUsxOOl2h0VcjXom1ndeC6qe/med+
 b2Fg==
X-Gm-Message-State: AOAM533kSrscHqxBScHVTd4Nz/uTRhy20uFNOK8/VCtf2ToO7msuW257
 IFkJ2DAsvVLHcX8Ah3xha2Ejg5KF7TB7F3yknqZKUw==
X-Google-Smtp-Source: ABdhPJwjXj+SU2IKcTh9L1q3V/YUeGmrSOvEXXRD2xmk1wLyteJPNkzyfp7ByN9LzhXrGXk0GF8nJuTDp5K+uwrdnKM=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr6648010ooi.85.1592399966720; 
 Wed, 17 Jun 2020 06:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <7f3f1607.7942.172c256f75a.Coremail.13824125580@163.com>
In-Reply-To: <7f3f1607.7942.172c256f75a.Coremail.13824125580@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jun 2020 14:19:15 +0100
Message-ID: <CAFEAcA-En6SXPokMA30wQsnXr2xKSM1SFaQVy+2oXU-0PE0Vzg@mail.gmail.com>
Subject: Re: What is the "E10, E20_0 XXX" Flag means on arm port?
To: tugouxp <13824125580@163.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 13:54, tugouxp <13824125580@163.com> wrote:
>
> Hi folks:
>
>  I Know the arm prelidge level can be divieded into EL0, EL1, EL2 and EL3, but i am confused by the following  definition on qemu arm port.
>  for example, why E10 are postfix with _0 and _1, what is this meansings?

The meanings of the different MMU indexes are described
in the long comment immediately preceding this enum.
For instance, ARMMMUIdx_E10_0 is "NS EL0 EL1&0 stage 1+2"
and ARMMMUIdx_E10_1 is "NS EL1 EL1&0 stage 1+2". See
the comment for the discussion of why we have more of
these than there are architectural "translation regimes"
as described in the Arm ARM.

thanks
-- PMM

