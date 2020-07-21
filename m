Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002C5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4552073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJRmHOS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4552073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuYE-0000v3-2X
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxuXL-0000H6-9E
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:50:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxuXJ-0001tJ-Gs
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:50:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id h1so15412616otq.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vXNgM0lmkt/S9LlBaM7KgizasmMuWqMS0dh+MCs7Dws=;
 b=LJRmHOS6T9iE/NnXi3Zr7Mg/DOOS3sm7slbA3VJsqw+ZiENXdTvpBKesUcqqwmM0Ku
 Bhus4gmL6CKkeKETi9UQEiDzyNknMWXsl26yOQYpenDSS/FHyU/zVjZuj0GsNSUwkuMk
 6PqQJFObSi5WqwqKpWtIsLN3l7XL0g0tlTShjGFhv1mkLAcHjtCw1tAcCzGpS/5AwjzH
 mDvZExhMWG4DOFZ00hYohGGqRZDsUkhWvba+urSVGYVutqTNnyWMrqWznKJ6sHoZ1AD9
 r/o/vCWFIFa9ECaaPWacL1PLkKpsOv87TKUIjWlzAU+5SkoJpdxwdvYO5Yk6fbMCcUyg
 oIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vXNgM0lmkt/S9LlBaM7KgizasmMuWqMS0dh+MCs7Dws=;
 b=Sx9HWOmm5UAK7A+0lcjzfr+GmkEPZa39CCBxXeHDZC7J3Gj5vAZZMMuap+U+ucfFp1
 jdcEnP8D5dqNSCW2i8m7S283rzV7wgMCCjyTNL0C72Q3qPjhmYE6JWR0LoTxCPyvrv8f
 FbtNrou0tSzAxpmGN+Z0hhm+NWnP7vEIOzmafxwlhjIdHaSttkGookXE1IxIYGEIZctq
 q34JS1Tuu7COpG53sgLnrKWQuz3UXV0PFA2bGuLAAdTHtAewxYn+Vwul/uRI4QFvyB3r
 /X/COBalTfDG6kg3RaWB7id2PvfD908DUQvmSFrCX9/+IMxCZ+SK22/pk8KvaVUD+ygZ
 Iflw==
X-Gm-Message-State: AOAM531updYlqis5+7FZ6V6GOuqOeG70EmRPoJJK602viMGKiUkFEfCM
 iKHuIiOO/EkB9rktiOEurlZLiDPp9Qb2i9erD1fyQw==
X-Google-Smtp-Source: ABdhPJz5SfQ3poXC9WjJVAr1D/ippj1QVcgslrD0bqcsOjGhJTEESIIJGjIJihIQQ0mN9cPBjbFNm09ePHY017t0c/0=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr24692461ota.91.1595346632202; 
 Tue, 21 Jul 2020 08:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200721130709.1242662-1-armbru@redhat.com>
In-Reply-To: <20200721130709.1242662-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 16:50:21 +0100
Message-ID: <CAFEAcA_=921Wwq8vsRqe5yP0D=V1edCU_tmyy2MpPjhSQFetqw@mail.gmail.com>
Subject: Re: [PULL 0/1] QAPI patches patches for 2020-07-21
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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

On Tue, 21 Jul 2020 at 14:07, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-07-21
>
> for you to fetch changes up to cbf97d5b799f4bc47b9e825100d1a98d3cf77c80:
>
>   qapi: Fix visit_type_STRUCT() not to fail for null object (2020-07-21 14:38:23 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2020-07-21
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

