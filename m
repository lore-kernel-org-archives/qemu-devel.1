Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48ADC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7C4206CA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyDZ1kE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7C4206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNB3-0002WP-TE
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaN9i-0001J0-1a
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:05:10 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaN9e-0004sI-EP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:05:09 -0500
Received: by mail-ej1-x642.google.com with SMTP id j24so30981152ejc.11
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sI7TAhW2Sw37Yt5Y0QzVWuDziEmYYPc05s8hLAg4L6E=;
 b=OyDZ1kE9xDzZQacxCdqTEw0dym2WiocLAxmad9kq2nprR1+dqi8QnU/F8deerS4c8B
 aRdynzoPl1jCQwTUbg7aNeUcoeIX45+jMlS/whVXZItJKZvC6SyTIT5iMpE1ytZqH7AG
 e6RDC/zky5oUXcTo6AkjIKw59o0mdScflj1vf6gyEcXkG6TNdPOsWCP2BrjMVwq2OxSS
 mtzN/lhjyzi3ITABOlF7qAnBrT+n022BkXyeDqBBHLqTW+/65jhxVu34KBkQy1F5NFjd
 mqsrLce6ttrXgp0bqPUsZTbsgasvPqwiXkzaYdfoBxxIOSV2ZxxE+p/+3twrEva+/yWo
 MA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sI7TAhW2Sw37Yt5Y0QzVWuDziEmYYPc05s8hLAg4L6E=;
 b=fs2xOeLlr/CYsBmx6xz1q6KWko/OuYdzF0mAS3T7nc3pxYmaa1lrOP8RSr+IhexkbF
 eG4sOnROvm70scIRm65BLFiacNJ6ClOTzDB5Gg31VLfxcp2QMTw5Ckd1Qw28hFW54LcI
 R8dYr9oBsyX6cp4B+dyBtSaG1Qu8bTXYKRJMiUtBG3vv2FKjgL7fVdMIbJULJZ4UH05z
 aYgmKBynpYuRV8KUTtMpvBRbTIxn1IHxhi6FWayq5tWanevEUO990JKpya5AFBep180N
 EFNCkCGVxNo3Iu2QuRa1TbJ0n9Pq4mGWAyymPExXsadCTlohHZlIL/rA6BCYEnRGKbNF
 6ZwA==
X-Gm-Message-State: AOAM5336a0hlwxYnww3xYS5uOBMenmj4XDLv/TZowgwGFnda12/u+4wZ
 7PnZ1amgasgd41IIuhW81KUyF84sqYQdgkU2PHR7hQ==
X-Google-Smtp-Source: ABdhPJxvsf1uBhxn3y4+wYYKYNQLAQIBRLbIILDbz8g5JwKjkhBqoz+vIPH4cOh/2OZD3Rgu5wdOjzVGpbWJZ8wtwBg=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr25016901ejk.382.1604513104937; 
 Wed, 04 Nov 2020 10:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20201103114529.638233-1-zhangxinhao1@huawei.com>
In-Reply-To: <20201103114529.638233-1-zhangxinhao1@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 18:04:53 +0000
Message-ID: <CAFEAcA-EXS2czmGNePYcTPT+qJSp7jjHjECdaVRbwSda-zQOcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/arm: add spaces around operator
To: Xinhao Zhang <zhangxinhao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: AlexChen <alex.chen@huawei.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 11:47, Xinhao Zhang <zhangxinhao1@huawei.com> wrote:
>
> Fix code style. Operator needs spaces both sides.

Thanks; I have applied this series to target-arm.next.

For future patch submissions, please could you include a
cover letter if you're submitting a series with more
than one patch in it? (Single patches don't need a cover
letter). The individual patches should all then be
follow-ups to the cover letter (in the usual way that
git format-patch --cover-letter sets up).

(We document this and other conventions for our code
submission process at:
https://wiki.qemu.org/Contribute/SubmitAPatch )

thanks
-- PMM

