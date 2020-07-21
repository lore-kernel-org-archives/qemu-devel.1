Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E7DC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105BF2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvI0bx4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105BF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrwT-0004ok-Ba
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxrvv-0004Oy-3A
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:03:47 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:45308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxrvt-0000Q2-Ce
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:03:46 -0400
Received: by mail-ot1-x330.google.com with SMTP id h1so14986101otq.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sVUAzy3z6JOUq3DuUZftnq4HSi5EIWF1XBPrB13YaU4=;
 b=jvI0bx4FQM5meDR4V418v+e+He89IOgv0mTyz2wLr+TH9jsa2vucOfHSy1Pl7iCLjc
 NA86rZgV8okomySoKI5+bBjS2M1CTAzA+cZdNyusqWvZgV97rKpRwsyT7HJzhFZyHBjv
 eUeyBCR32dYzgez8d63vOgcfLnsd6joqYxLr04NhWzcLE0tAaztXA9xVhw8FfFEuxB7p
 jjySjXfR2uTvnqKlAbnZ62D7pCZ3JQzu8ZaTzArYryIWRgTCTUlpkEv+CnqzVuvWHJG0
 mGe1VzAx+AHxBgw16A7Qy/B7Prpjixsl3X0PBWyOY72a7MSkUaLGAhfsgGuGeypE/0LU
 LZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sVUAzy3z6JOUq3DuUZftnq4HSi5EIWF1XBPrB13YaU4=;
 b=MLg/I2pjJk0al9mGdIrCBTZj3rrVg6LjEi6wLXRdyDigoNBAt2Cy9QySYMyD51DPoz
 Xeo7hKdagtuvrmLGr2mNa0Kl/KCZA0ygDUV6cUzS4eMU5iK5UpxwO52iyKRC1bMFcOaX
 SXd7o8n1X+apz0nlCl1Q76FczpATXmM9c5Zl3Q+cjOTAOCL/lurCIVI278ScndxZHa3G
 MfUmLkQ2nIQ87DOx5rapnEG9oiUDZdT+GWx3f7JKVCxo2OyZ1Xrg11kChutexgBzIHKy
 hKDZ7U+91Sw2FbGF7AZXU3ubWKludCzzHkxZjilLKmAB7buQgatTjAKFsMB4NIy7b9CO
 Ey6w==
X-Gm-Message-State: AOAM533Z0pMgf97F39mWxJWCMHvSRuK6h53AQQ9sCC++KTCQ04PwPja+
 0DCrgGx9kZLbjcj3yenD+npRpF+tCpHZVJm5RKykqg==
X-Google-Smtp-Source: ABdhPJxibdpE+qLvoA+BGXx8OqPEMLqMbT14DdLj7GAYuCccLAzxmbCQFlo/+hw9HRq/1Kk4NyPtlg1+BCKan4e6v8w=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr24035941ota.91.1595336624167; 
 Tue, 21 Jul 2020 06:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200721081055.14073-1-thuth@redhat.com>
In-Reply-To: <20200721081055.14073-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 14:03:33 +0100
Message-ID: <CAFEAcA8XjyBA4sBNZf3t6zwavQer+iSp9p0RnZma_P46N9jZBQ@mail.gmail.com>
Subject: Re: [PULL 00/10] qtest / fuzzer patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x330.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 09:11, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-07-21
>
> for you to fetch changes up to 7ad36e2e241bd924f774a1f9fb208c102da58e50:
>
>   hw: Mark nd_table[] misuse in realize methods FIXME (2020-07-21 08:41:15 +0200)
>
> ----------------------------------------------------------------
> * Fix memory leak in fuzzer
> * Fuzzer documentation updates
> * Some other minor fuzzer updates
> * Fix "make check-qtest SPEED=slow" (bug in msf2 instance_init)
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

