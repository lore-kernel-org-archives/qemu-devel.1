Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E20C20789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDqds2a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E20C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5Yg-0002dT-G8
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc5Xf-0001X9-4r
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:40:59 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:41739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc5Xc-0001a6-Io
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:40:58 -0500
Received: by mail-ed1-x52c.google.com with SMTP id t9so5000924edq.8
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XG0SOwja1RDaaocnQZLSCPPfozCHS44al741rtl/Fn8=;
 b=CDqds2a2LK2KOwyQHsJh7ZCSW9VhGA8uKOhoX8pZDE2KIY4ka8NF3QgcTzOihknmn+
 eJpvbE00u3foE3GKKDyRevGz7Cvemqd8ENXXKNOnT79h9z2z1ORPyFqT/jW8Tav8u01c
 Akb9RVOkTNESiC/wXCKPyMluy/XCstgt4lBHtg4ayMcJ/hGDiAe3Rd9y1AxgOXpYypt2
 3wiQJl+EnsIAOV16LvFUOaVAjDCB5BMtdXfbrYGwVCTHInnl1zqswHy/HWkL6Jo23FQh
 685dHmMKGTCl4SSDYIlzU7PuKy48J9qv8l9N90qWefuJG0jdkn1YcyxtlVSrvoVIYBm4
 wzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XG0SOwja1RDaaocnQZLSCPPfozCHS44al741rtl/Fn8=;
 b=rn9INQiyVMNo4SiAJbQwt5IUAon2FQIQTesqxiR1zmyPTSLZ6y1LwSZhG/IPQveQi6
 s2XRfHJWCCTboVkm6+45cCwkTDinYL0+AaYZzpb96x4OmU4WVkffacP8IAb0fRsoOfpe
 WKylnPpl3COCDgnRZ1AwMwq+11N/TSGN44DgX9eIbiNMou6tebCOqeb0tNqfvv9QvSfP
 rxvZbNshJAxZ+q2kjgEOzUjg5bS1YDDtRQ6qXn83flUSas5brhmvoetcAgomrFYXOUMA
 j+YHu+Dexr68zsnY0XU1BLxgq4KJfxQqXDguZ6SWbIGL6ZiXt6DY52xJf94BN7BqAILG
 VCtg==
X-Gm-Message-State: AOAM530H5ae+WtCSxWE5B3BUCwCrtDaQMcfkH6lA56bUCIAiKIpg6rxk
 H6cI/+y/qITBHK57Q8d/SJo34dUODjSTVNxZUQBK8w==
X-Google-Smtp-Source: ABdhPJy8Rb8vKQu9Wyj80VFgP/qukM8sBMCugZ0siTTz+1DJ+h8S7CdLxUXWopNB7jYBFAZUW9wY8+HHDze/59rTll8=
X-Received: by 2002:aa7:db8a:: with SMTP id u10mr13729883edt.204.1604922054795; 
 Mon, 09 Nov 2020 03:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20201104165254.24822-1-alex.bennee@linaro.org>
In-Reply-To: <20201104165254.24822-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2020 11:40:43 +0000
Message-ID: <CAFEAcA9oWroNyZMzesaMSoAPXZRiR17oFWcENfZSorXTTG6ULw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: add some notes on the sbsa-ref machine
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Shashi Mallela <shashi.mallela@linaro.org>, Leif Lindholm <leif@nuviainc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 16:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> We should at least document what this machine is about.
>
> Reviewed-by: Graeme Gregory <graeme@nuviainc.com>
> Cc: Leif Lindholm <leif@nuviainc.com>
> Cc: Shashi Mallela <shashi.mallela@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---



Applied to target-arm.next, thanks.

-- PMM

