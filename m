Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C940C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C6E20787
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RranYTo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C6E20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4kf-0007a0-Ba
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw4jz-000784-RZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:20:03 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw4jx-0004Jh-1B
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:20:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id t198so5194521oie.7
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uASRpqHPiXfiRa6C+pweZx7I5OV8LvEDShTlFbn4CpY=;
 b=RranYTo7menvidtLK7PNdChPcF5H4ZD0pIoMFVjBXktVJgjUYqGhyZXULe01Epx0op
 Wy82Tqo5yVKVZocFsEKN42QZFCPQzq2HOgsYN/KY06GbvLu9NqQWU1OcGjQFQ0ctbiMn
 xsUS/A7NHMd25uqR13Xl9EaSzJ/98GejH8kNQB9ffPy08xHUZN7S8AUsy5Vesmf1iK4U
 71ghzbCEcgByVBs9MaBK9LIBLoR9jgCY1t6w1r6y4rORayZRskUIpuhCrF392QyCdc+L
 qAGrR84NVaEQpElpumezwAIWmcTmJ0zZq4vO3LeoH+CaOYboU4OUn471viRdX4IGMj5d
 kg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uASRpqHPiXfiRa6C+pweZx7I5OV8LvEDShTlFbn4CpY=;
 b=HgY6FMxbf+6SLmOpNe94TxFEgW5SyeJzIEAxFHdsEreCzEyRSnaSaaLWv0sbw3HSbd
 8eP1FsGsrWZbeNqUX0ORTTMNQNkdGk0Hr6pBMJhIkELT6qww9oLKV3GNJNZxdunmrcLN
 nD0DaBgq9F6HVAVo4bP0cLshErI5FAyjHf4XIaWxpTx3sfAs8epPDdegT2IjEu71daOk
 SAC1g8uK5HfS1g7fSFNbWTQs+L0kAjjv3m4n17hDU/EsOyYaf1WeAZ4rJ14UToxRL7Y7
 14nyF1xJ/F2KDSv2QhwN511TwAfcnM3hHpF0P7dL1/YBITMUUGnxvVaRlT/08otV1+H/
 7cjg==
X-Gm-Message-State: AOAM532peeJ6PTjtkXNwMVcZcC889x9hr2flmufnuN7cseqda0jtU3wx
 2WxP2pjQcwF6z99AIqNrpMYCNqrgNkLiG57uP2Id7A==
X-Google-Smtp-Source: ABdhPJz9GRxWyD1TfzCnbtiC7SNOTI0N6zpWy1dyTh9UYc1hHmAH9yeYuVdqttfTfnv7BqvWD47pAiuhHEvBo1M3YDo=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3727900oix.48.1594909199636;
 Thu, 16 Jul 2020 07:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200713213341.590275-1-richard.henderson@linaro.org>
In-Reply-To: <20200713213341.590275-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 15:19:48 +0100
Message-ID: <CAFEAcA-VGqwpZTWZ054h+Sy3_db65Rdv5TfbsJEmpB2dzpnLCA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 0/3] target/arm: MTE improvements
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Mon, 13 Jul 2020 at 22:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since MTE is new, and guest support for MTE is still under
> development, let's disable it by default.
>
> Peter mentioned memory hotplug on IRC as something that
> would break MTE's assumptions.  By putting the enable flag
> on the machine it's much easier to control.
>
> For 5.1, we won't have kvm support, so error for that combo.

Applied to target-arm.next for 5.1, thanks.

-- PMM

