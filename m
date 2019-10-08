Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02431C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B981B21835
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVOGArVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B981B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHwEc-00088l-Su
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHwCZ-0006qd-1f
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHwCX-0007cM-RR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:35:22 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHwCX-0007c2-KF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:35:21 -0400
Received: by mail-ot1-x342.google.com with SMTP id e11so15240625otl.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O2OwHo9MN7fRpyZkAqSHujkBVze1HAYlPsNEGEZfsLE=;
 b=jVOGArVa3OiRya7bwg3k68g+htGbG7sMHfPd2dsrCGriK7pqYVVh0LOulNWLlhM8kh
 L0EoKS4z+30T6p9iHXbz+AYk9yDyObZJ8U/tvR/G/49Wj8/XuZhZmRh6Rc53oQNWCyvO
 /PwCS9Gfetd+dM+XmLgc+eeyt2oDtczfQAAppDotVt0R1AY6SbtT2u6QhODPNXgGlUkK
 K4tLrVhPEeY0ZHCEiePYqxtg5t8puFhD+1aGxYqhP8FmStVdlZbYETNPoto3UCHsQqU6
 6HeWceao0n7T9looRjcdqRfhrGUgUMvvSibdPRVkdI3ClIG2po6QlFKfKLKxADevBesq
 gdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O2OwHo9MN7fRpyZkAqSHujkBVze1HAYlPsNEGEZfsLE=;
 b=JVdv3Cj8/RcLmxdzHbHsg1f3GDXluwvWAapljIdRWyDmp5NWRX8PEE4j4mgaGIXnby
 qsfKdIRDpnHZ9AqJ12jbpsewl/PUqClmNQTRCTLuz9d1uiVaT46mEt/woM2E6K69Cpcq
 NYsutL+4QeYq64fxrW6Bz2kI/jMP+ozNwOpfmdf0NrY1QHZYeB3M8s6CzXvE3TVfM98G
 RCtPOuAVbpIxCCnAOS3Jw4nAoiU/HX8Grx67j1QSD0h/WcXXmtxdBlI5Tx2qmt6BPrkY
 lrZJP61il62ftlMYCdYzer9KizE2vRiFjVCW73+U0ULiQNVJOto/kTmT/w4X2dw0p9Md
 4uYQ==
X-Gm-Message-State: APjAAAV64NKpbHvV1X6rKasJV2XoY6NiDycfLnRpdIBTvcsFE1YjUzTv
 TQgQpSE+LL+SmvRprac+FUkKK+Fpox2Ti1pjjQe0Ww==
X-Google-Smtp-Source: APXvYqyXP7NXDIap+/WbZM1445Sd1/FVqn+adfqxf+R6W11lan33e5Qhp6VaLEwJDjkOVmaUgWdNKPkxjpARNMQBqrI=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr101939otb.97.1570566920340;
 Tue, 08 Oct 2019 13:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-8-philmd@redhat.com>
 <CAKXe6S+B8y5fdFowN3+40baR-b4c0RDrsi+LvuNcx1g-Mx7LpA@mail.gmail.com>
 <f0178880-2526-c3ee-6ad5-1d66f2e23fd9@redhat.com>
In-Reply-To: <f0178880-2526-c3ee-6ad5-1d66f2e23fd9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2019 21:35:09 +0100
Message-ID: <CAFEAcA9Xn=UTG7otjSX5e88ewVXmCmip=d=dvHwuM_jZ8X8QqQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 at 21:29, Laszlo Ersek <lersek@redhat.com> wrote:
> In that case, the original initializer will remain in effect, from:
>
>   QTestCtx ctx = {};
>
> (Admittedly, this is an ugly GNU-ism; for standard C, it should be
>
>   QTestCtx ctx = { 0 };
>
> but the GNU-ism is used quite frequently in QEMU elsewhere, so meh :) )

This is deliberate -- some compilers grumble about "{ 0 }" in
some situations, so we generally recommend using "{}" which
is accepted by all compilers we care about. (Cf commit message
for commit 039d4e3df0049bdd.)

thanks
-- PMM

