Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E7C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FAC207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sm7fYBVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FAC207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomoj-0002xZ-9J
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iomk3-00074a-KD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iomk2-0006Oy-2F
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:09:43 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:41284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iomk1-0006O2-Qd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:09:42 -0500
Received: by mail-ot1-x330.google.com with SMTP id r27so75965950otc.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mUAJ3tsm7IdfG+X32No9AxPGQTjUZBa6KgCtKb6tE7s=;
 b=Sm7fYBVk+1C6u9zY6fA/02/a0yAk7AYVj5m2pXJIUi7qh1u0wLy36VyXz8g58Ofm8O
 XAtMT9J5KgCUiTq/5aDZ9xsanWWmM2FB0GoPHX3Bh0lkuTaEiIS+e4+YPgXmAoZOX/AU
 jXE93gh7PkKGO3tPgCYUi9BGYaBaHHJVHNYVWlWmWpncaNbLvh1sz++3k2I1rpMqSZZw
 yZ4Sh98447QCtqsPwBYOmLPFYgeqxS5hP3ncMqfZHtFPB9yiY9Q6ZDgs10JLXBSQi1Wp
 uY/2rDB0YgHEhr3Aynp7oBPsqAvugReJMgLAOIPRk8S7HRe64AEl9NOsHsSXoFB5p7HO
 MMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mUAJ3tsm7IdfG+X32No9AxPGQTjUZBa6KgCtKb6tE7s=;
 b=gHoYsiMZPhOjIBIuSMWLYpc32jvTBftoO+UB+OA2SsG8GcVx6AiB0gmpibOBIiPzgF
 PacTWPpCqTAbR5adwYzrOjOWfGHcz8vFj6Nt9z6CuJxVdWF8X5LFR81o4JjJUYM1kjYI
 AXXMBJFSMSzBNFpNgKvHmM+7SfnMtz4sP7K6OIMZvZnC7e5M1/tERtmiZTz9t4lSJNaM
 O2QYSqX8K8NbiFM9eee5JMf0dRzEiQ9haA2QgBnJe2g5l0/NEoPY6E5kAa5rQJNvXG/L
 G22pDZxA7Wb7hhnTPKoEZCk9ULCsloxNa4BI6vdfxlanPAv8Rb0CyQcIPY0/2Cddz69z
 23Cg==
X-Gm-Message-State: APjAAAVNTa0ikqJz66cE3AwMBquoJtFEcg6lYfOZGglirhUMHXd9GyKI
 VaTqvyIlVHqkc1feqdzU6TndSKfopEfWp9WAOqs57w==
X-Google-Smtp-Source: APXvYqy2xF4B7f1AI0S4zvTwWV5LO5ZJLGMZoJATlu1jCmK1krNDy903AO1f3+Uu75AmjnOeVU3x7dCReJJKrhv1lfg=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr104908121ota.232.1578395380945; 
 Tue, 07 Jan 2020 03:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20200106200434.27646-1-jcmvbkbc@gmail.com>
In-Reply-To: <20200106200434.27646-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 11:09:30 +0000
Message-ID: <CAFEAcA9X+wS8vYaZUev69U2StzB6YZMp6R1cB6Ua20+8L=2m2A@mail.gmail.com>
Subject: Re: [PULL 0/3] target/xtensa queue
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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

On Mon, 6 Jan 2020 at 20:05, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following target/xtensa batch.
>
> The following changes since commit f4d8cf148e43d942ef1202071e0cd66ce40322e0:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-01-06' into staging (2020-01-06 17:44:22 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20200106-xtensa
>
> for you to fetch changes up to a153a3f73d8e028be996f1602fa99c7f3f53348c:
>
>   target/xtensa: use MPU background map from core configuration (2020-01-06 11:46:16 -0800)
>
> ----------------------------------------------------------------
> target/xtensa improvements for v5.0:
>
> - fix ps.ring use in MPU configs;
> - use MPU background map from the configuration overlay.
>
> ----------------------------------------------------------------
> Max Filippov (3):
>       target/xtensa: fix ps.ring use in MPU configs
>       target/xtensa: import xtensa/config/core-isa.h
>       target/xtensa: use MPU background map from core configuration


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

