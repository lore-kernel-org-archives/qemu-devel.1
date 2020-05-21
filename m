Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41042C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F277820826
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNRXcZyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F277820826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnrV-0001lx-8R
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnqr-0001CN-RO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:15:21 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:34286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnqq-0000VS-SS
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:15:21 -0400
Received: by mail-oi1-x236.google.com with SMTP id w4so6701384oia.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mST48vKTJPQwqL7r+JqNlFUosCbyEUOyrmPYw8Il1cc=;
 b=RNRXcZynlQKRj+DqKiGIddWAUpJi8eRFM+9uq9WjVSUyS8Je3tvuK2xkcYngHM2CG0
 kwreVf+EiOwI+TiP+iiejgYRO1U3ndh7WYz4OUa21bZWlawAjL88+c3pVaot+l8wtplF
 5HHwaZTKuNGgXMOMkb4WRzr9rFPLij5f7zVuprnEJ+gNY06lr51dPe3ZzHbowxCZrcQ9
 g2B5OnYEeRDPkzORtGXfJzRKUUsOxrDzA2+I+/TqShpqRILwWFFIy5fQ8NXMdFtfM361
 K2aBCAriXc9vC1CL8LBGa9P5GB2U2gujRpwbGO5+uG1LeeeITfJhna8Fe73YGvw33+WZ
 HtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mST48vKTJPQwqL7r+JqNlFUosCbyEUOyrmPYw8Il1cc=;
 b=E6IWPNjwk6rqUluhY+xSGGvU+9MsxzuUEB4ah4KEML5pXiHXa9btlZvP3H/maJrqbJ
 7ikYqGbjXDu1tRAVC4WmzMKRgUR4qmTtxjfSWB+D2mLZI1bY4i6w6Xf4yIIA0hB1UVkF
 NtcWBdpIc88qJSzlOyreO23Woo0rqwChSs1TpFA4crso7ewwuUEC/bJ7fKPeBEI2kMIU
 i2Q9ur2qhwDJ3N/sCbKkHhwL234Lsobxgu7w/uOZZYAcBJL68ruB1jW2WtB3qew3qLpi
 I9zCVeywEZC0kArdvvG3lweGDb1JcFZNJxDpwJvYQclcKMMtBphYHdzhrlYK7RaRzAEo
 svqA==
X-Gm-Message-State: AOAM532QZJXvJhKXjS2f8c6KZ70gBLLBKAooo0zXC+aT575nVoHqg1g0
 W4RiBQO/B4c8Laun7A6FTw9It7oUo1tMbWmww9Gqcg==
X-Google-Smtp-Source: ABdhPJwhYX8FRqaMyVSETtovz1wC3JYHi34lVyqNCJWNoF8szkm5OcE8fQ93QYPT70kZ++JuRuymx3Tz0DVyZhdvRQc=
X-Received: by 2002:a05:6808:6c6:: with SMTP id
 m6mr5890261oih.163.1590077719381; 
 Thu, 21 May 2020 09:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200519212453.28494-1-richard.henderson@linaro.org>
In-Reply-To: <20200519212453.28494-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 17:15:08 +0100
Message-ID: <CAFEAcA_7QOLP2-wMM+Byak-s1+Dbh6NWHVOfQv0Q7gejjd0uHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] target/arm: vector tail cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

On Tue, 19 May 2020 at 22:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 3 fixes the reported bug in EXT.
>
> I should make sure I have fixed the bug wherein RISU prints a
> mismatch and still exits with success, which hid this problem
> in the scrollback.


Applied to target-arm.next, thanks.

-- PMM

