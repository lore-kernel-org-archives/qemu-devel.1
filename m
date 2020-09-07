Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BB92078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GN+JZc9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BB92078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJFL-0004dW-7C
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFJEa-00042v-9H
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:39:08 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFJEY-0000am-JP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:39:07 -0400
Received: by mail-ej1-x641.google.com with SMTP id gr14so17612003ejb.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eAN3ObEnWEdYjt9dFqcKaQcQZEkSxhKOf9zRZcbkey0=;
 b=GN+JZc9OIarba65gOW/FbgrDU9TYkedgBl8/866CordL/wG1YJ7WlKo/LS344gNwHv
 b+A3+sWeJAzgZggVaHYOPNVUTvSnrlOx2XSheBH8qnH5VA5pIllfjQPjLgGm87kvY/Mb
 HMBXDU4Cv/ANtJa7rBRmHH7AFKNaPSe1mJXQ1JTFf6CNMZ7lVHTzlX5GCvfmT3csHOzC
 WBGmOESW2/luRrWQ6OQDp6IgNlgLmUHuFWa2qE8nbcT4HPqppoRmbspFlJCsvSMVtF/c
 hh/hu1OLkukJ1tw1H+RMA0QtsKe/AKh9TZBUerKcKAtnKh+OpXceDoQLzTIwsiRM10mS
 SgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eAN3ObEnWEdYjt9dFqcKaQcQZEkSxhKOf9zRZcbkey0=;
 b=duH+5EjnH6hSstN3JahEQ6Jn1iFJnHSSkFSNN17gv8iDQ4h3440qFqJkoVuFk4xcKK
 it20kyD7l3fNCobUAiRyBcsMBtDcQ4mH9a7bAt/WyYQvkM36mZhREqeJV6L1O1uZmWNG
 n+8Yja1noKfbsDfUrPfnid+pPC526wGRbzgX+o/24dP4zkQBaPdLXbxEnxbd+mrHF17F
 Til4YtoHl9o8G3+HQsLtQhwELlCP5BgS7pUYiype16OCOiNisDELtxmw8QltNc9ibIXU
 XOAHTXSgNEXhCn/zBNAdhZDy4OXYKQ+jMZbyXNz7dQYYkzBBd/HrBbJlukRFEAA7bI9w
 gILw==
X-Gm-Message-State: AOAM5324Sdk2ZUY1h9hQb4feAqMxvumqxBzG7LG9pG1qMAxPOoxS9NXN
 XFuW1Vmydc7m0m8SKuQkqQLiNP5thZp8qdK0+I4OyQ==
X-Google-Smtp-Source: ABdhPJz29AIN4oYGF/TMqpQjLAkj5UXEBkEqU+gcRFl0O2qY/t+Lo9l3Jj8KxMH3uPzPCi3fCrTsPZwX3qGyVOMnQ4U=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr20986257ejb.85.1599493144720; 
 Mon, 07 Sep 2020 08:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144100.116742-1-f4bug@amsat.org>
In-Reply-To: <20200901144100.116742-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 16:38:53 +0100
Message-ID: <CAFEAcA9wZk4Nm+Eomsv8ATkh_MKJhzpJTmpi1+=wpJiHN6Jx_Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/misc/a9scu: Verify CPU count is valid and simplify
 a bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 at 15:41, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Trivial patches:
> - verify the A9 CPU count is in range,
> - simplify using MemoryRegionOps valid/impl,
> - log unimplemented registers.
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/misc/a9scu: Do not allow invalid CPU count
>   hw/misc/a9scu: Simplify setting MemoryRegionOps::valid fields
>   hw/misc/a9scu: Simplify setting MemoryRegionOps::impl fields
>   hw/misc/a9scu: Report unimplemented accesses with qemu_log_mask(UNIMP)
>
>  hw/misc/a9scu.c | 59 +++++++++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

