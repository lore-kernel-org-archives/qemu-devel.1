Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D8C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F9E206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roYbCwyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F9E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5nb-0005y5-ES
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5n4-0005ZT-Bq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:36:06 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5n2-0006PP-Hg
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:36:05 -0400
Received: by mail-ot1-x341.google.com with SMTP id z25so7091903otq.13
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2iaFPk9EyfoSNtxcEQjdK2j0hE5PEU6StVFa3LCvvBc=;
 b=roYbCwyEmD43+Dd7jU6LyUWFZ4FqZj3OByjEUtXSBMuhMtgumgOoZktrD9MgzN6KK8
 eyB/XehK7RuGC4TyMWAGjRfeo5qnUlT7Brd9hcAJx9fI9uTtlO2GLIEW8WG4Pch8oStv
 dJ9isYQ63ReVuoCQVsh2HT1WeDoPlZ9VAdGc6ZP/HSAfqfB+O6yF81CZAydGWXpPXGHF
 vY1MiYMvjf0UQzF1VopqHb4QJKxAOC+g+pAGw20QZ6spsIpMwvUICdJT/yiPdjb514dL
 T3IiJsw8phA9mCmwGSgiKrbb+L+LSZIBrszhq7ys50hNSY6FhatyPJljWN7c9ZVSQG9I
 4vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2iaFPk9EyfoSNtxcEQjdK2j0hE5PEU6StVFa3LCvvBc=;
 b=ak4rd7S7YMIL7FOXky6DvZlmoWzRQb9FB5eiLYwJlX53xYzwyeKJ7yF5OWw1ecDNtq
 xL7azbrHqLfO+R/P6LcHwQM/4HAc0BlQYujnw3SSLR+5aOMtOTpbctGVOdItI++v5elN
 z4guDqvfE3PhZFyt50Nc6z4ttpAgeG3kVA+5HHRyVn2o3ARe1iOZcfzwFIt/tpCwjQKe
 nksQtbW1qFHhnEZ3IzqhxQ0PwyI5rgZr/S4IKB5/nXYZiZi7QqdAG7u/0hNaPzdOlirv
 E6keczeOCzyl4HP5b/edzKAHq2WErIzvHhfMjVD41J4gtDiKeMd6fxEEB22TWBdPAiWt
 8bbw==
X-Gm-Message-State: AGi0PuYuT8LSsLVkNc6PcS3jOwldUSGxDiKwPT798e0724x10mn+DrNV
 9zxEoXmCfX3jLR7/riH4dgL8A62K/VCSsYT5ytl4zA==
X-Google-Smtp-Source: APiQypKojcmSQN3AFAwvpFTpitYaBzMP5nr20doevIqIvUuXbPVyJBlMiYASzt9v6KZtk3ODeyvq5tqzvkysyrme4yw=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr12304550otb.135.1589193362799; 
 Mon, 11 May 2020 03:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200508154359.7494-1-richard.henderson@linaro.org>
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:35:52 +0100
Message-ID: <CAFEAcA8B_5c1Cvfss7mo74Q17AiZf-OhTk-xmnTsobjpHc=83w@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] target/arm: sve load/store improvements
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 5 splits patch 4, as requested during review.
> The patches remaining unreviewed are:
>
> 0004-accel-tcg-Adjust-probe_access-call-to-page_check_.patch
> 0005-accel-tcg-Add-probe_access_flags.patch

Applied to target-arm.next, thanks. Sorry it took me so long
to figure out what was going on with patches 4/5.

-- PMM

