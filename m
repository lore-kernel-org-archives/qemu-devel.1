Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80522072C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2YEE5xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80522072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3w5-0001TG-SU
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3p0-0001tq-Ig
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:50:07 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:40504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3oy-0002GF-CF
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:50:05 -0400
Received: by mail-ej1-x62d.google.com with SMTP id z5so13953841ejw.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fCzMZ4/zBnaNjDQMNHnoegvUGFLvTjrtT6DGtzRtX8s=;
 b=t2YEE5xPisrhAKJV6q1BMitGWQUKKiFfBygY15UV5+lRDPRGs2uJTZbcH098iUDJHL
 VPASPFpBSy6oKVavoPu0BCVGgFNHUYC93+llOIu1R92qZmWfLE8xdQ9IleyX8AltKts6
 O59cIhGLSDyw8rXNVFpFETlV1NcvPWWDHo9EA2S9nWZ90xr1FvRo8+pv9LzP20FKY6SM
 ujLwjO9rf7IcRECHOPv5vuABM/w2Fj3P37iZrrsHImfgxjO8fex5iYcPbTdXrh5QAuVS
 umOlcy11jol5E8wvJicb20lbcNx/PAhl74IbhTXNVx6K+D3ivqxSuUCVZhU/xsS8CQn9
 /nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fCzMZ4/zBnaNjDQMNHnoegvUGFLvTjrtT6DGtzRtX8s=;
 b=orjNdqz/p0BufIJDJivCjAEad7EuGxDP6cxBzNdVegIetIx9uHtxm6vpc0j9Qs9d6j
 aP8KpFCL5l154JDv76+49+2es+tqcCHbsPKS7r0RvPeAoMFiQtGwjR56KJ50IZ1/MQ3+
 BEwsmP8lQkoD3UIZ3dwg6xleDqxZjWWUadPIxeu7IPiilegEIxUSdLARmUYQNki7TNCE
 TsXtAeq9fFJVlBbxHxwAz6G33VZzZvhCRdNWOXpAJOSjPMukEL0WBDZSfOhvUuQVaJol
 8ccCYOAwbNNFJhuBFFCsOpvr+NWP6Lq3++OAlrOYpEs+ewPwX8pxo2c4Zf6yDNha2HrR
 yEJA==
X-Gm-Message-State: AOAM530RinAw557yaT++cQn4vqKiQ45CBPJJRMHcSaIjr7IfVaSAMcYc
 KVsSC933Glbd6Ps4T4jfqSQt2rtA4UNDZ2lKqNA7lf54mX8=
X-Google-Smtp-Source: ABdhPJwqC6meC4jCEcK+4YJmTSYVSMVYUza2zIqriPt05cFi2AGpaPaZh1C5uggRA1BQjL//DH+mlDpwXuSW3rglL38=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr16723341ejf.56.1603723802631; 
 Mon, 26 Oct 2020 07:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201026100632.212530-1-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 14:49:51 +0000
Message-ID: <CAFEAcA-AiPpGUy28y=pm907Km9FCt1UBy-tWyCn0N8NCfduJmA@mail.gmail.com>
Subject: Re: [PULL 00/31] qtests and gitlab-CI/acceptance patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 10:06, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-10-26
>
> for you to fetch changes up to 28bbe20ce281659e317b807f34f568bde6d99760:
>
>   tests/acceptance: Use .ppm extention for Portable PixMap files (2020-10-26 09:54:16 +0100)
>
> ----------------------------------------------------------------
> * qtest fixes (e.g. memory leaks)
> * Fix for Xen dummy cpu loop (which happened due to qtest accel rework)
> * Introduction of the generic device fuzzer
> * Run more check-acceptance tests in the gitlab-CI
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

