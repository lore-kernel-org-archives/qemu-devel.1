Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8362080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiZgY9Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8362080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooBb-0003ox-Kq
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooAe-0002wa-4J
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:13:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooAc-0007JU-HO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:13:31 -0400
Received: by mail-oi1-x242.google.com with SMTP id k4so8022296oik.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oWb36J35ESUuY1ww7E7WCjpK0nAWhNMKLe/D7pe5g4E=;
 b=tiZgY9BaFwGXcokju6PMWjDbmDbWraMlp/gx+bmcZmkfCCr1qa1JQNkcVVkBfpJICj
 SlsMORXuIIW3Y70ddeACmA51SzhHDEYlKcVctxrkobykLQv5U4QO4KjEyYQnTBan1yLB
 w5zx9Shm/SS7Vr1tgYFyMXNlotIBd+76xTXX8YhVVFUAXH2eMirdeRdqv7bxP7I9Gdqy
 kDjD4QrdIJt3zkjVaoEn7GCKqmWZiRhe1lcP3gLpZme4Y2YzlSbLMZYKe+jnxlYrKGpc
 vWlfQ31plvREZD/Gq9xcpjL4rK9QpAHMvZv/pHNU8k18R+7GI7Rxkfal2yYopXQccmVK
 LXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oWb36J35ESUuY1ww7E7WCjpK0nAWhNMKLe/D7pe5g4E=;
 b=PnKEiGOdiWnpcp5CAy0mjr+5n+NzYi1K/ZEFKS/0v+P61ifAnxiMHnF/xrC5RLKkTf
 gk4CTcWV3E3by6BZXCQBjazXxAXwf0uLGLZv41T42X5ygiET2j+b0xtD97VBw+w35Xrx
 w/uWpwQy1cZR7Yp4eYxQelIAL3ANM5fJx3DJbOxJMBsIQyJCPzotQ0ecrO1Ks7FQWfwS
 Ge7yU5czlYRg2eIs9ZxtIc2PkE32OIxKBv7YQwvwA18fwXmHxW0ZrrMZfM9x5MvGX4mk
 +2eZ8wup8ojKzTdBFW0wg03TxJAPwjl3NIAZn2sgYnDb1XxYjBbdkft1BlkpfAI3UoSD
 /FIg==
X-Gm-Message-State: AOAM5313ESw+ZFi454hA6pMQ7R1s6Am7v5b0fFRGeK1B7AcC4M80kjvF
 U7JWOB/yJ9bI1hbaMItncO9teBIVG6CR1yvsYwYNpQ==
X-Google-Smtp-Source: ABdhPJwW3e2aC97T5TerDlrGe2+aomE19AVyANSadEWX1HkXKDX86Kmc1SRj6Grm60ozxB6o4oRys2Y2ALH/hy5a9hI=
X-Received: by 2002:a54:4694:: with SMTP id k20mr2249559oic.146.1593177208881; 
 Fri, 26 Jun 2020 06:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200626033144.790098-1-richard.henderson@linaro.org>
 <20200626033144.790098-44-richard.henderson@linaro.org>
In-Reply-To: <20200626033144.790098-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 14:13:18 +0100
Message-ID: <CAFEAcA8=UGStxFYhVw3_YPd_7FD6bTnETW=OMn=ZDrtGqXq8jw@mail.gmail.com>
Subject: Re: [PATCH v9 43/46] target/arm: Create tagged ram when MTE is enabled
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: David Spickett <david.spickett@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Assign cs->num_ases to the final value first.
>     Downgrade to ID_AA64PFR1.MTE=1 if tag memory is not available.
> v6: Add secure tag memory for EL3.
> v8: Add arm,armv8.5-memtag.
> v9: Split arm,armv8.5-memtag to another patch;
>     adjust how address spaces are allocated.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

