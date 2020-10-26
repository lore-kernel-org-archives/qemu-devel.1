Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B56C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4D6207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lhd5j/fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4D6207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9Ec-00049x-JL
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX9DP-0002rM-0P
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:35:39 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX9DN-0001kF-DL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:35:38 -0400
Received: by mail-ed1-x542.google.com with SMTP id dn5so10958052edb.10
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3+gJPdgxJeehdTnI2InRs0AcqiXokE1aL5jQyui9O4s=;
 b=Lhd5j/fYiMdz7QwGBbpso46AqlAlkbi10Ln8alajU1Yxn8VwHRAPWqnTApuQGK3mOg
 C51seFcekJUZbUlS3WjM7Cf2KAelfspwZC26u14dkxUjnXsgcagbVtF4GJT5ltbwOusS
 eqGRfVQbgVp56vYjIz51IIBKWRHK3ZR0DlgIwIsaTfijqwLI+QYjYojUXINen90DJ6S8
 UrDwp03z1rb+IwJb0ASzew0ITuEJLAbXZ3fuhMHgdVufLNtt+AOebb7eyabzSt15daPx
 lC9viHqom0VLwo6CfdhUG0iFpHInI7RO7krn0BHYfemDKXI07kusYjGqVtdlXNQF2OEE
 uRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3+gJPdgxJeehdTnI2InRs0AcqiXokE1aL5jQyui9O4s=;
 b=rdEPLJExeoNqaH/QX6L4y8K5LE5pSgCwMF8w7AvvfTV6TAvcG8ibfdOMI7wj0dH4vM
 vZFiI+sf9QWa4OIXyfqIuLTR2m7rz7wHx+vwoumtNJ2LT/v1emOXKoV569O43mwAy9Ou
 y7cps3wLvrAZ+iKOs25sezCEElxFfCKttjICG0u3uYXZVOjAEhZhKJBF5Fb6dxJ8iITh
 OPJoQe/uCJk5D8OEXCieMZL+rt5tXKj0ghU9JPksoVo6AWXFmhCqRbQdTmD/hvuF9Pcx
 rAUZG1HkFhSZdxnwGbhmDQLft3FJoAdIN/m7WgOpafAdbRNXQpSTOESt2Nd6C30wn9OT
 PaBg==
X-Gm-Message-State: AOAM5320a7XWWm4JF4+tjFIxVizuD8uZTBoTjIpffj9WQw4J5vjiYw8t
 ZdGHFF5QXm/4rKdwMTuSthboOfKehXvb5eBHfij3yA==
X-Google-Smtp-Source: ABdhPJwsEk5jgrdxj5nxj2nReGxvq7yO//AaFfJDqqDQXlSMUz+hGa10yYjiI7GkLz5L71oIFOSOsj0Grg4vL9Qjs7A=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr18044021edb.100.1603744534809; 
 Mon, 26 Oct 2020 13:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200814213938.369628-1-richard.henderson@linaro.org>
 <bcab99e8-f738-4d07-d42a-7dfbe9ac2b49@linaro.org>
In-Reply-To: <bcab99e8-f738-4d07-d42a-7dfbe9ac2b49@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 20:35:23 +0000
Message-ID: <CAFEAcA_3MXa+h7Wum6x14wgic4V2hh0zAn2NfB72_UB62je5+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/arm: Implement an IMPDEF pauth algorithm
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Oct 2020 at 19:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Ping.

Sorry I kind of ignored this series. (It's in that set of
things where it would require thought about whether it's
definitely what we want to do, and I haven't made time to
think about it).

Anyway, I tried to rebase it on current master, but it
fails 'make check':

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_IMG=./qemu-img
G_TEST_DBUS_DAEMON=/home/petmay01/linaro/qemu-from-laptop/qemu/tests/dbus-vmstate-daemon.sh
QTEST_QEMU_BINARY=./qemu-system-aarch64 tests/qtest/arm-cpu-features
--tap -k
**
ERROR:../../tests/qtest/arm-cpu-features.c:439:pauth_tests_default:
assertion failed: (_error)
ERROR qtest-aarch64: arm-cpu-features - Bail out!
ERROR:../../tests/qtest/arm-cpu-features.c:439:pauth_tests_default:
assertion failed: (_error)

That's the "can't enable pauth-impdef without pauth" test, I think.

thanks
-- PMM

