Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF9C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DE4206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYL2CPn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DE4206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUT9-0001wf-3o
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYURa-0000MR-MR
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:55:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYURY-00058U-Rs
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:55:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id v128so1265804oia.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kwhkk1KP15xl2KRZ2gYDDjZY7+c2vyBdUguWtuldT3A=;
 b=tYL2CPn2NSDGKYhIqea/KdgWEYiWlVN7M5HhDqACms/9hptO8MxhE3P5s17AiloT5J
 8xMiWJCvkF1/I0dm3MuzWCYPfDh6QOwZ+oe1TtFoiu87Xfds4Xc0KqSqxNH0g5mXkR6s
 zLOXOGZ4E35xUkUF2TtKoJJ5uBod9MBjBjISWHxJBdBmx3xQtXykcH6+/4TOrJZlZ5rz
 FLkJ7VJV94Xer+2e1EL+uwmEPg5C2eHh7H4bKe3MneaVATH7aTa76vNhGWAxHjEXYbio
 QaeY7F+zQjIkRARLnaRAUmxGx2CSaWwHpdxGyKMwPOGzAd54U9EYtayKARlgSAlsb34h
 XfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kwhkk1KP15xl2KRZ2gYDDjZY7+c2vyBdUguWtuldT3A=;
 b=c93+YKHVRFvcBslAnQ5HrlkeUnrFMzVOG2ow6tA+wN+PZQufCF8UABAGWwxQWWa+Mj
 avhmHp1nNnHD95HrkcsRFlZ0uLbq+SZIJd3tTy/wpO2AlNreJfrYjOEN6l9ugAFQymQn
 x8kTLddG/geL9xLzvmqdyow68z3GqK5L0OKDFKNNOzCld6oZk5hGlD7O8pzlOTRjYHpM
 1xI5/J0Eg/DNRIsIQ8vqgpLJiXHNeB3YcBo8hUp8H5GkuYZ4QUEYXP4QtFf1OYqnvk/R
 4psI0SrAYniHVq/ZTcYvqDGs792/kIl5Hibg7E2QfV7LkYsYOpYSibeN4Goozx8a3paa
 KiPA==
X-Gm-Message-State: AGi0PuYtlYnd1Pmp5S4JB7dLka/xr2IVcG3hl7MwF/3oDnji8pWFZ4WP
 LSlgu/7eF1DQFUPvL8LGMERFo2xUNFDk6a9QsjqN0w==
X-Google-Smtp-Source: APiQypKTa+FmKSf1pcMi+P/8ejzNnw1v4hZ7NfudNoJxfvjLE4j+cH252IW/QrMk9aqZaWtrsJkYdnuxXMRJ5orZS3Q=
X-Received: by 2002:aca:895:: with SMTP id 143mr23233840oii.163.1589288131431; 
 Tue, 12 May 2020 05:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 13:55:20 +0100
Message-ID: <CAFEAcA9bcLE6kAbesKGPw-jRhuFWveH2dqMHpOYgooomW=+LxA@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] target/arm: partial vector cleanup
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is not complete, but shows the direction I'd like to go.
>
> Version 2 extracts more bits from my sve2 branch.  There's
> still more to pull back, especially for crypto_helper.c, where
> there are also tail clearing bugs to fix.
>
> Version 3 rebases on master, which has some of the arm neon
> decodetree conversion applied.

Something in this patchset produces a failure on VRSRA:
testcases/aarch32-all-v80/insn_VRSRA__INC.risu.bin
from Alex's set produces different results.

thanks
-- PMM

