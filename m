Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90509C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBE322D2B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7rbrkMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBE322D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSK1j-0005fw-84
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSK0L-000560-Po
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:06:13 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:32932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSK0I-0006aQ-TD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:06:13 -0400
Received: by mail-ej1-x644.google.com with SMTP id c22so28197906ejx.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jn1s2hHxU5hUVgakbGiGaClW5Se1Y4Rk1oWVrmZlnPk=;
 b=t7rbrkMSsLrdeIAL0fIX/VGz99EdMfBJaQDCOywQEc4qgg8JRgnmLiB6q44IP1wlkv
 X+Eb9+KNj+DRsv0Ip5K/5YxLS3zt/w33Eme9nxdc812Nq7h7pa36BBpxFC2347VLqtE9
 /Hi73laU8s7jniQ8+9P2/bjwmxkt9EOKiHmQhEpoctIvFc9ATt8qDceR3s0dHfJ9XRit
 ojXV1vqrC6flAT8PS83SvzJYkpPuQ5urOfZtX8lGlmtQC//6MXCXEkIwL7o6RLxYr70g
 g0wMSg7cWGz3tu4Wy9OfIQ3fRJwrhEk4nRJMl8qt/7hq+Zip4QZF4H5gDaqWWDza4a9Q
 zQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jn1s2hHxU5hUVgakbGiGaClW5Se1Y4Rk1oWVrmZlnPk=;
 b=paEwHAlll3lsmWSUAwAq9fH132eoiW4ROb1ov3se9Vii0nf3H32Wo6JMA4Raitsig9
 0S0/U7aSEJSvG0J/SiImY5vDs8aP2S5xIzQZEGsSe7RglLtCGvn0CYEzSyxHia6O3y+0
 AoalZY/t74z/hWt0FT6NnBqMI5w7yilQBG/7Tt+m/19jrrj0Q1AforLV5X80Yr9Ds58d
 hNidZDqEZv1blp4QBdyKOye4fOTZ+WGhyqCdXrXeebYOvIxKTpIA9DAkXdwyfwN8/qy2
 PuY516EzAZPHafshkZFbIallasZ2GHHVsNX0tVvq4v122pIb0QdFx3YfyKeR5FJKCkxF
 ojkg==
X-Gm-Message-State: AOAM532YkgX3oqoKB59Dq2tKnDYAuD8VXkjmmuEw8rMkd/TKVYk+8+Ul
 v3esSSB9YZnnVqK3lQliQcrwo+RwZUBXEeDOUTdPMg==
X-Google-Smtp-Source: ABdhPJzbVvdPUlr+3ZTYkjDZ5o31cqDWvNt3Ic6IzTzqfZBpEfly8fYADxvFtn8YMlPYFtv9qBcIV5s+sgrW/E0ReYQ=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr33311935ejk.250.1602594366029; 
 Tue, 13 Oct 2020 06:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201013105527.20088-1-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2020 14:05:54 +0100
Message-ID: <CAFEAcA-Sae0r+JESZLmtmwHPDfpWM2Fdb=jOcBe1VLCG7r5YFQ@mail.gmail.com>
Subject: Re: [PULL 00/23] qtests, gitlab-CI and misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Oct 2020 at 11:55, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit a0bdf866873467271eff9a92f179ab0f77d735cb:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201012a' into staging (2020-10-12 13:12:04 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-10-13
>
> for you to fetch changes up to ea8bf1e514d2f442dd1a008794eb1563e2ee1c48:
>
>   scripts/ci/gitlab-pipeline-status: wait for pipeline creation (2020-10-13 12:48:17 +0200)
>
> ----------------------------------------------------------------
> * qtest improvements (test for crash found with the fuzzer, increase
>   downtime in migration test, less verbose output when running w/o KVM)
> * Improve handling of acceptance tests in the Gitlab-CI
> * Run checkpatch.pl in the Gitlab-CI
> * Improve the gitlab-pipeline-status script
> * Misc patches (mark 'moxie' as deprecated, remove stale .gitignore files, ...)
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

