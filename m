Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38B62071A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rw/ldGEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38B62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlslR-0007OK-TZ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsju-0005XO-8U
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:29:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsjs-00018S-KM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:29:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id k15so4228758otp.8
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zk7CuJDbnYiYd0ZkXIw98BzOuhxD4Zd+aQ4kaAV749k=;
 b=rw/ldGEJvuLkhvO//5QsKFRWM6T9u8OOQI8U+ZRqmOq3X3eMlKfbcxZhrjLQBvRW19
 IvG5X3rf9ufmUHI30/p/g5fcgTw78sm7cWkXQgAC0uuZnEJ9NnIiDgVlH15zjiiyD3Ux
 kDLlzgIWt29VQHxc64GZcLHeP1DGzMcuo/8y1TFAkkk9NznPpYlVnZ9xd0X15ZHtITfQ
 vAZFcx8VfjF63fe+K50wjhuQZVZs5lUXlslycZsj4dFY/l8Dzfu0qvl6e/DradH2wHUa
 3rsU8JPSVSrRJvtQ8mz6TTtQZxRIwGLYJEVRbujgXy/eCODmq5TP6I5cXpHI5mL8/xWh
 RYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zk7CuJDbnYiYd0ZkXIw98BzOuhxD4Zd+aQ4kaAV749k=;
 b=rYqLZZ3jGETSHGbhynPppuwvr18aJhjpJaQcFPRSl4FH5C33LB7WcY/L0Kx36ep8sQ
 iZUZRc9C86d17HhH0QKOOiuFn1mE53euifEYTTdTS9VqRY0p6nn4Fhk87eDSTz+nYsXi
 jOy9ljkYATpgS4z7ZOzy+SCw/cBEwPuM3xtXQzlbXvW6d71BI57cejFLvwxPsprMmCx7
 Ucaz7tYWKh936RcXT6LfTznCLQKOdF0LSV81My+zFcfL/mbLFYStFf8FIGENhj5209JR
 831tDZNHnaQHFFUc3SRBcdmxWWw+ntTRf+6A7jANu0x0iaqsZ84X5HPj5B6Rs/ZJ8m2G
 TcfQ==
X-Gm-Message-State: AOAM533pUf7myOazlo7HpDeYyZXfphR5B09F8solK7t7IGfg1nQVBvyb
 0/aOP/WP/0e+Mq5kvlMIxMSFQ7J4/b2Z/MgGxBprRw==
X-Google-Smtp-Source: ABdhPJzMALbWPOPjCnlG+HbzITIHc6cHlr99/JAUaMymQzZRcRxgedqR0MWkXT9erzUNlUd60bLe0cYq03bEwNYrwP4=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr2853887otn.221.1592479787329; 
 Thu, 18 Jun 2020 04:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-8-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 12:29:35 +0100
Message-ID: <CAFEAcA8Nwuapyq2e292P_DM0KWRvZY6nSsGwUZn5yO+K3_jLCw@mail.gmail.com>
Subject: Re: [PATCH v7 07/42] target/arm: Add MTE system registers
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is TFSRE0_EL1, TFSR_EL1, TFSR_EL2, TFSR_EL3,
> RGSR_EL1, GCR_EL1, GMID_EL1, and PSTATE.TCO.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

