Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733CBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A192070C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZfVCZaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A192070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js9bY-0004uT-Ef
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 14:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js9ak-0004Mb-7u
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:42:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js9ai-0008Rg-EK
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:42:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id k6so26532323oij.11
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+VBUPvv7JPbp5onrmM9gmropKQo/GrbKz49Cmzn+/n8=;
 b=fZfVCZazYgoYPnGEHTV+32ZXBQn/HnMC0/iSzLVV+zY+BRzWtf79qwpAAipATErFoK
 1fI+P0fiRtzBbs8kJMKTOCa/sdO5aMEzNp2bxaL4IxkZr2UOjT04s+ulM2IbjyxC9eSQ
 cXKFBURVCYdGWS9Lh4kd5+T2P0+wR6AmiOmrgbOKAh+YeoL5Qs00kVx5DD4I43c+MTrp
 2OvdnF1aJ4OindKV5VRfqXKkKNiwFYYtqKViCxg60zdYMLPktNg827cNwDd1GECdk/Di
 a56SzCNkyq7mM5tsquVe+KwIKOwyIdHUMzoJlV8ZwPGnHYzy6+kg2RYSIvOPMNxCwFJK
 LrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+VBUPvv7JPbp5onrmM9gmropKQo/GrbKz49Cmzn+/n8=;
 b=dxLq0rjmyfbzxSL9XO77SEgS0hBBDOIMdrX1Rj0Ect/AZwnAr4QP1oyUNxZFGYF//D
 +xhirJXyfgfpomWjKJUOsPsoIGpdvw+PKimksoazK0lSZ3DP/WbwJZKptrSsB2EYUWbR
 3MwT1qVMKL05MeSo963GnnLJFmow+TfEc6GCK2O2DCPG3U0Zwa4fr0xXDmH7SByH4KIp
 eo0uX0q1kg5IzgZ7Ola2J7RSq/FA2q2xY+wFuw9IfwxgWf+YDx+WTP0H61uTQw1hjso4
 aIuRjBi2c9kCOyfEeyzvGwfxPf2TWfbf/lE+z09F6cQe6uLTfPexVfsdhJShdeMke4WR
 W8Ww==
X-Gm-Message-State: AOAM530FSB24YuqhlHBtN5khCPkhihGubJHKljoY2X31ga5KFdjmxvio
 u7YgldDxDFp9LUjyW6mHFh3bihMZru1oxcxK8xD2QNl0bq0=
X-Google-Smtp-Source: ABdhPJz16aDcVdOpHL9DXsTMvYCVr9T57u0sBkGu2HYIYDp9p0jJedTvPPj1GQsFcCYTx4VlDr/lsyF8oBo4k+49juo=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr27781143oib.163.1593974534784; 
 Sun, 05 Jul 2020 11:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200705140315.260514-1-huth@tuxfamily.org>
 <159395934458.22113.4571211972557020419@d1fd068a5071>
 <20200705203013.26739b5d@thl530.multi.box>
In-Reply-To: <20200705203013.26739b5d@thl530.multi.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 Jul 2020 19:42:04 +0100
Message-ID: <CAFEAcA-sS1rnfpNmM5UmBop6S+Y__U6QCd4Svm_kvh3bHZmx3Q@mail.gmail.com>
Subject: Re: [PATCH rc6 00/30] target/avr merger
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Sun, 5 Jul 2020 at 19:31, Thomas Huth <huth@tuxfamily.org> wrote:
>
> Am Sun, 5 Jul 2020 07:29:06 -0700 (PDT)
> schrieb no-reply@patchew.org:
>
> > Patchew URL:
> > https://patchew.org/QEMU/20200705140315.260514-1-huth@tuxfamily.org/
> [...]
> > === OUTPUT BEGIN ===
> > 1/30 Checking commit b5e3116a3591 (target/avr: Add basic parameters
> > of the new platform) WARNING: added, moved or deleted file(s), does
> > MAINTAINERS need updating? #42:
> > new file mode 100644
>
> These warnings are really annoying. The target/avr folder is added to
> MAINTAINERS in the first patch, so they should not occur...?

checkpatch's logic for this is extremely simplistic: it will
warn if:
 * the patch adds, moves or deletes a file
 * the patch does not itself modify MAINTAINERS

This naturally leads to a ton of false-positives.

thanks
-- PMM

