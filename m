Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95789C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61865206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7P4/Bgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61865206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJF1-0003cJ-JI
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idIxN-0004nf-Mt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idIxJ-00048i-Ex
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:07:59 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idIxI-00042h-0T
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:07:56 -0500
Received: by mail-oi1-x244.google.com with SMTP id v140so771188oie.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oqe8pI/PWg/1Tvf6B/YngEW4CJMUyRS0ReGi/U+z2S8=;
 b=s7P4/BgoLoiMcq2MZXeCr2Ns/b5m3hND2Li/aDOeD+/31e704AGQ8oaY7Rlb6Dzyy8
 x7LbjjF4wFOzBlx91fRxu2rqQwjXEwU8os3pbFCXbMlJdjMT4l1ZCfPYvqlom0ETXPK3
 elwycRQMMoaQsImLOtCKy+e2AMvyrkiQLywyetm+xiEBt0nwO+dUzSvWtxt+JGDwyXdD
 pA+jj/ZSOfxIPttSuXdglodAUumvmATxOcVjy7EpqPEKJPjnuBmZI5Ef+TpFL2RwAGfD
 /xutGz2hgilqa6pX0dEz6G4ueHCdavc3V6gsUTyAengXm/obB2CM2HspwTB5mOOHBhF2
 uXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oqe8pI/PWg/1Tvf6B/YngEW4CJMUyRS0ReGi/U+z2S8=;
 b=ZpOs1QrO0EJOsKCRqrifmVnN2nODSrXtd121Tzzzx8CYIqZ3palEI43KiezygqD0qK
 6mzjlDJzyu5q6LE1bb5XQHZkI+zieg7CQh1PQxhwS7X2GiHSz7BrVhuVbbCATuRTQSZ1
 EWXXoprZ+YijDcy0XloAW+EM9qiPKEBHCdZ7HovICMQWWABUaR+wuxC69gllegiXwyop
 qnA9C0vkvzz7QjJ4Ss7K5hpHkZQSRMa0YyOWHLRD/uldTgXKTHEyu7TDAH8swU498qGb
 jZn8Rjyxydci7DWNIfi7rM46fN/zUayeQ7xAthv+7NIwyr8GMTex+UdzV2aytP4I2rdG
 gGgg==
X-Gm-Message-State: APjAAAUNagMcehxxDX6KjFrLmbZa7FCL7be8eXEo2g7MkwcHLywaDV5P
 6d8tEcLVjVajXJIwEv5GLM3NwP04NxQLT3j69fluE0N8
X-Google-Smtp-Source: APXvYqwegleWn2eiodHhLvxhSa7ZsExnAD7K8RiyeXRXiO3gJLO2mIdWT7aJuRSzYLYXoqp51t4Pyp1VeqsaVELmd8E=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr13967794oih.163.1575659270565; 
 Fri, 06 Dec 2019 11:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-6-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 19:07:39 +0000
Message-ID: <CAFEAcA8-mqSToG+fNOwnDMaOL0Ykd-1C1ni0AMwQ-+rfMSn98A@mail.gmail.com>
Subject: Re: [PATCH 05/11] target/arm: Add isar_feature tests for PAN + ATS1E1
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Tue, 3 Dec 2019 at 22:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Include definitions for all of the bits in ID_MMFR3.
> We already have a definition for ID_AA64MMFR1.PAN.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

