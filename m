Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3283C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 20:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1763420723
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 20:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8o5Fu/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1763420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYxby-0006Ra-Ua
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 16:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYxaJ-0005u9-QB
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 16:34:47 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:45098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYxaI-0000mc-3M
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 16:34:47 -0400
Received: by mail-ej1-x633.google.com with SMTP id dk16so12687465ejb.12
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jXCuEcrRPfQAqTsDB0aZSahUbAlUMYhyGr95vR50wIs=;
 b=j8o5Fu/OdyCA4RrgI5hFRFHW83SIsezKjRfLY1rQe2E2DWllFjh3pjDCQgyFg0EuVn
 3PVa41SaPRqrqk6UICryxuM4PrK70FF6T/J5RgbP2crwjqCBrgANwJsYa2WqavOCGXlz
 TGJS1NN+y151/xNJXdRAsGJIfw0NfRL/rRqnqmGJWflsZM0hwn8YNP4Wr0MvwSCcZaeK
 5QUg06fnOk043QyKG1BiJFoDt25dg0TlxuoSD3ubq51xXXRuDZd3O17OA9/xfDhnUXn0
 9pm2pcuDouMeehYMC4JAho6svapcddMu20ZEUlpIpo5YkOoSqiF1cG4GE+K7Uweis4Dz
 IDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jXCuEcrRPfQAqTsDB0aZSahUbAlUMYhyGr95vR50wIs=;
 b=YdKdTSVoTlpPHSVZ9qXvXygJd0FHAN4aiMW3t6Kx6cNCU0UUJjlVlNjsO3BDmuzF4t
 ny5757fD2ASuqDS17e2z7lVu8cViVsCmy1/JYNfHqOvOw8/vmpqrb7rvOk7ROds4fVXG
 AoriTQKuOZaQWM9YT1xHuvbWAHnZRvtCzM8dbG9Zquwvrl4BqpBtGdhxOtt9W5KQgzGY
 4iMAItwrYbOS56XOU5a5NjmjrL1/fgOteitJ3jFiHzgjWLdnXv3F4yqvTNol7ZuxaoKl
 mTpsft3LpQu/1/z6WJZQM8Kkpoi3GBzU4JZiDa72XYXfNomz1UEfetekK6f7PGfl3IKX
 AV0Q==
X-Gm-Message-State: AOAM531ktX2oHoTltvqnUp1IfxnA5WdRGKSvpRwt9FmKBxXb+5tUfc9k
 Kh0kZyyRkUhhzCl5+QLe0A3DhzjnTTgl0m9OS/Gu1A==
X-Google-Smtp-Source: ABdhPJz6mx9RlPPXFKb73PguJJSYOLFzRznFRXV4hHrA7FI3Jk1MZ/1GJID9opzTG4Lg65xcuXoVB+P3ZRg0+7563qI=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr8484310ejb.482.1604176482871; 
 Sat, 31 Oct 2020 13:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
 <fd3237f7b005b1b73c954ccd5c6011e8228e19a3.1604067568.git.qemu_oss@crudebyte.com>
 <5877759.JlKFulrene@silver>
In-Reply-To: <5877759.JlKFulrene@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 31 Oct 2020 20:34:31 +0000
Message-ID: <CAFEAcA-pQP0DZP003cKnj8k0DXjH0KR+K_joWdtdNhV1eGkfkA@mail.gmail.com>
Subject: Re: [PULL v2 01/16] tests/9pfs: fix test dir for parallel tests
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Oct 2020 at 13:20, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Freitag, 30. Oktober 2020 13:07:03 CET Christian Schoenebeck wrote:
> > Use mkdtemp() to generate a unique directory for the 9p 'local' tests.
> >
> > This fixes occasional 9p test failures when running 'make check -jN' if
> > QEMU was compiled for multiple target architectures, because the individual
> > architecture's test suites would run in parallel and interfere with each
> > other's data as the test directory was previously hard coded and hence the
> > same directory was used by all of them simultaniously.
> >
> > This also requires a change how the test directory is created and deleted:
> > As the test path is now randomized and virtio_9p_register_nodes() being
> > called in a somewhat undeterministic way, that's no longer an appropriate
> > place to create and remove the test directory. Use a constructor and
> > destructor function for creating and removing the test directory instead.
> > Unfortunately libqos currently does not support setup/teardown callbacks
> > to handle this more cleanly.
>
> Peter, please ignore this PR. This patch needs rework:

OK. As a general rule you need to make "please drop this PR"
requests as replies to the top level cover letter, though --
otherwise it's pot luck whether I happen to notice them or not.

thanks
-- PMM

