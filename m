Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB4BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D1B2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gb0cXEX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D1B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGxb-0005ED-HQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiGwk-0004oa-Ds
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:32:10 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiGwi-0003vH-DM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:32:09 -0400
Received: by mail-oi1-x229.google.com with SMTP id j189so15075109oih.10
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4+SWXOfwdeCUekvzA0kQiWKzgG+rcYlbXpHrrQKrmtg=;
 b=gb0cXEX53GuBsDSanY9kuPUFj7nKhp30HDWPbKGmts6MCOHJJpTF8uL3NJzVALOQcB
 1W3iMW5YXwMrJWJqygtIQfLj1v+N3SGn/ThRymiwdHIiAgtzwFuiN4Y2s84vgHzgHfsp
 rjfhbkmlMnNdgPL6jH1Hx6O1Aw3prCqiH+boV3SJ/fhNhoMsCLr0pqnPP5WVVHntmGwz
 dE3rUv68tLkp2hoSFknYt616Jl4wwL6qFfRS4geuoJ/8O6D8zLxcI6P8qLIKKxj9DXIz
 g+xV5o3yv2aeWTMOXNnRDy9Gh34H6/F+QH9UYlqI4b/V3hEk4VSV2ijp+9Idj7hESK/2
 aeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4+SWXOfwdeCUekvzA0kQiWKzgG+rcYlbXpHrrQKrmtg=;
 b=ZLAX5T1gmyoQpxzgIyl6jnu8gYcUYW14f5DoDmSbu9+bdIh76g4wpBXLIGXB0EPqUH
 aA+xQSRySvD6/4Dvrk11z48UpMniLCmtDWVCbJ22c/3JfYRWZ8JtV8w27049QwkWuPFi
 8w7TNiUXMNK2tM5EL7kNhsfo/b4VuMDGsGTPsKnlqXXB1OBig5Lhpsew7iXpIZv0vVof
 Kw5n5mVXP6neD9lwDcCOFZP4PuSyAllrceBRTEATmKjZaOXOClZ7WWwuSfwvyizJkz6V
 B3fCUIV3hGY58Xi9sC0xAa8N6Dp+yTnl/rataEgloYVyGbAjBhxo8yA0xZ7m8fmPWNug
 K9VQ==
X-Gm-Message-State: AOAM532ZSReLMn2Ic9PrUOqb2rdJx5hvq6gXslvVCOEnHIZOYck4YwjO
 tJt7F3ZX0XB3Z39DQ081awyzcM0qByMUKjrTkYkdCQ==
X-Google-Smtp-Source: ABdhPJzt+DHa1JxqObi6Lqej03bBHXlCD9F8ZB4Soe0B746zTadDo3PMD+yaDAbYhtrM29lKFu/e4gXrQFuuJJUa0QY=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr6042140oia.163.1591619525939; 
 Mon, 08 Jun 2020 05:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200606131607.1250819-1-laurent@vivier.eu>
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 13:31:54 +0100
Message-ID: <CAFEAcA_SkRPR+2heaTY9U=K-A4sSHAOHN7AUOT2dU0865vvmqw@mail.gmail.com>
Subject: Re: [PULL v2 00/19] Linux user for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x229.google.com
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 6 Jun 2020 at 14:19, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into s=
> taging (2020-05-26 14:05:53 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
>
> for you to fetch changes up to 95722b27845b972250a7d4f93b693b01e2a0c3a1:
>
>   stubs: Restrict ui/win32-kbd-hook to system-mode (2020-06-05 21:23:22 +0200)
>
> ----------------------------------------------------------------
> linux-user pull request 20200605-v2
>
> Implement F_OFD_ fcntl() command, /proc/cpuinfo for hppa
> Fix socket(), prnctl() error codes, underflow in target_mremap,
>     epoll_create() strace, oldumount for alpha
> User-mode build dependencies improvement
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

