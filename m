Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D30C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316520656
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLt3w1Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joobe-0002E2-FY
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooZL-0008PQ-Ev
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:39:03 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooZJ-0008S8-Ma
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:39:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id w17so7374955oie.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g6rP+I7OcxR0JAnDkJ0llpNmylekoaWGwlpiJZqQuGQ=;
 b=KLt3w1Z7TIZW6DU3B7B+0BTVY7GMOmt1Mgf0R2bJ2NgjQ9aTnIK8w6QrItrVuzboVJ
 rfdLIllUXEi+CZRujO/g51Vmv4HC/I2NDgYghnZ9RzJzYFs/2uP2LB7yGFW50J7oIoJx
 FmOH95VjD0SNUjEF7hj6JoQcFms2aLZO8oGrcQB5Fyu3vKHa82/qgDM2oihoRuU11HLe
 zJ7550tlJ+tM64ddUeRizGze7khJG3Sy7bkodwdGYH7QSBNDrYhWU390rA5LEMYZJjhH
 0NvDHj9A1b/PX8vRGdyBfrqqcGV9I2VppVM0VPKcwoIqVudYvlSmstOPFFUPMk5nzwto
 WGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g6rP+I7OcxR0JAnDkJ0llpNmylekoaWGwlpiJZqQuGQ=;
 b=WFWuA5HMKjUKJTC/LIuulm8igsRVMQahpsiCLjDH5OsU1LwbB6ownX2ErJngTCiepz
 WUX/7wDKJOuYSLGq+XN4NGScK7Cl6TcdM06P1UejZ4ywmQ1xlzgCULfR3B+PC9Vas4MV
 Obo+NtXVjjrWyi6vHGDxebpUCkR802qGUtKhEqG1i7zBMJP/cMKJIPRaraas/kROF0IL
 Rit5xo5FMHJeAofuxbJKEvSR0LzlDmdaA2w7so+LVjkg+5n5e1HOd37g/8dnRIjS72AA
 bLbpjD75ide9K8kpmB58oyYavb5pNRF1FWTLX7IcH3516ZlYMYUxuwr4pwigR5oRCYB6
 qU0g==
X-Gm-Message-State: AOAM530Bmtu60+3clwzWlXluZk3Eap+Vlg+U+Gopdin3vexVkKEItL1u
 tnkJ2VgibRPqJfRVO+Rx7vqaJfh/zzuuMHzEfyJGCy08S8WwyQ==
X-Google-Smtp-Source: ABdhPJwFVbeelNmlR/2iQBDQq4UYCMbXhBak0Vw3g5umyciLpQeZBmjN0hSMWSaxUE0JFNTHO4fz1cfqzSzUDzrsNYA=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2442216oia.163.1593178740487; 
 Fri, 26 Jun 2020 06:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwDLw2BJ9Cf0kEyUW+J+rTPOOvebRPPkBSiWdD50wct5Q@mail.gmail.com>
In-Reply-To: <CA+XhMqwDLw2BJ9Cf0kEyUW+J+rTPOOvebRPPkBSiWdD50wct5Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 14:38:49 +0100
Message-ID: <CAFEAcA8mpiPcwgz9-7c0GgSWz2hujzegOBvHn5qasCBtuyG8ww@mail.gmail.com>
Subject: Re: [PATCH 1/3] haiku build fix second batch
To: David CARLIER <devnexen@gmail.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 14:02, David CARLIER <devnexen@gmail.com> wrote:
>
> From 95ef79ddff73eebd1f1bec6673c2c68209fab107 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 26 Jun 2020 13:56:14 +0000
> Subject: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros build
>  failure.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

I'm afraid I'm now confused about which is the right version
of the various patches you've sent to the list. Our
https://wiki.qemu.org/Contribute/SubmitAPatch
documentation asks:
 * Include a meaningful cover letter
 * When resending patches add a version tag
 * even if you only change one patch, you resend the entire series
   and mark it as "v2"

Please could you send the whole set of patches you'd like
applied, with the subject header including "[PATCH v2]" and
with a cover letter email that describes the whole series?

thanks
-- PMM

