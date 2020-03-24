Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4ABC54FCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC418208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q31BgDUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC418208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjVX-00066f-Ss
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjU3-0004V3-U3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjU2-0001uD-0r
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:20:43 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGjU1-0001tz-Lz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:20:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id 22so11458684otf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U9MDPZvFcaK8sKalHUAczhxfPeFYaWrumeanjAlIE7I=;
 b=Q31BgDUWuJBWuwZAjMBEsc/7DuO77Z/fm5WJhvkeX+wAei2PD5QuvrdR6priA+yVuz
 slFVRE15MWoqsEHFCYbulNcAPUGPjiOslt7FsZ1//sAqWlbhqqNblPTS0IFdB0Z0x30A
 oxDQqX7wMvrt4TBDqa4wErHZpQzJnz+yHV3C+6yxkgm7c+xFge4xX8Sg9kiYc8qFAOjV
 /hL/eattWvZouku3xGjx31rCysc3q/YDljdDc6xWPyzI/jja+qSXxvt7t21N4mnTcwjt
 ytCsTdblCvNkj97duYXnflZoBFnky9JvvTg/c1l8R/e99tmWiq8yf7YxYUw6BSkg4JgC
 YgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U9MDPZvFcaK8sKalHUAczhxfPeFYaWrumeanjAlIE7I=;
 b=ls0HAmM5e74N/sqcROowyzv6PxmrJiE2fzMpdMz5ZQRbMCIf9JhYmLqIlj1bTfixaf
 M0/G1z8jsCqFyoPk3d3o3iWNSA8BvCNBoLo6EaJ+ryNewSYo4T2PkPqyB1fVp3JgxFta
 f9Wo8LmFIb9Vp7Pt+eKqP84NorBn5YbvX2sXrRJxMVueXCn32kC7zoRxKJtLjk8CDQ4E
 2JmpjNd9VLtWys6JGLwx8od+I5gfcqCgULbHCO6uXU7PnNRcmM1422MRFPiLkz1x7OD1
 HVdJcRP6Xa6fPcy964LQlZFv420CDD7EtIGDqNmhxcdxXqinDyHU2K40SXqGebP2K9ee
 crzw==
X-Gm-Message-State: ANhLgQ08pd2Zeaq/uPLAW/ThvVnY5uQVQWkTJEoB1zLAKf9qViiL0ukK
 7bc++ekj0bx5b4IlGrjpjWfCwGh7R8z3kfeBJvFeng==
X-Google-Smtp-Source: ADFU+vu6Z0cwBZRhIXBeQ55zejPu0N1/bGF8p6mHK8JkJTlLE5IhZoPdG5Zd/V/wEifGEU5dzfxN1nMRREwMwwvntaQ=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr22038960otm.91.1585056040501; 
 Tue, 24 Mar 2020 06:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
 <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
 <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
 <CAMPkWoNqKpn22Y70vZizFqd3BQjVJaSwjE25KwHOcMJaZsY17w@mail.gmail.com>
 <CAFEAcA9=AGgYAxjixjau8KDet-of4=Vg9a_2k-hV54h=1gbrSA@mail.gmail.com>
 <CAMPkWoNh_ZX+kUoEkMndY_ShQ0qKNTvYoq9aVM7G1pFLW2CdCg@mail.gmail.com>
In-Reply-To: <CAMPkWoNh_ZX+kUoEkMndY_ShQ0qKNTvYoq9aVM7G1pFLW2CdCg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 13:20:29 +0000
Message-ID: <CAFEAcA_TEcwNeL4ao2x=_y-7yxHCH0VbkCNso+EvF0WFaU_-8w@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Yuval Shaia <yuval.shaia.ml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Tue, 24 Mar 2020 at 12:57, Yuval Shaia <yuval.shaia.ml@gmail.com> wrote:
> So what i can do is to check list->list at every API since destroy
> functions sets it to NULL.

No, that won't help. You can't check list->list for NULL without
taking the lock (because in the append etc functions you really
could be multithreaded), and you can't take the lock because
it might have been destroyed.

thanks
-- PMM

