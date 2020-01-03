Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDEAC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696BE215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QprWBQ16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696BE215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inNyd-0005Zx-I4
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 09:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1inNxN-0004DI-Qw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1inNxM-0006O7-Br
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:29:41 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1inNxM-0006KN-4G
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:29:40 -0500
Received: by mail-ot1-x341.google.com with SMTP id k8so44195828otl.13
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UIapnTfcT6EWiT0i8ZWVwyA9XLv7MTGS6f6qT/tTUVo=;
 b=QprWBQ16odgxFxaQe+m8CLYyHIZJ1AavXCh/8OUGxaBMdkDgZ75udGhgr558fpT35f
 43SIQlvQNz+TBOedBOULJ3w9w1WHY6ADiN58L3F0I0QWasJRrJ8wdBKxk5Bh9h2yywxP
 ZjSidZ1Dwe29PT9XhuSr+HECPiev6/1Lp4AploBKUm/Usv9VKpw4ZcZrLiX6vqofv+WG
 zdaa7LYT+Ex0+g1ja9A64sDAeXRT5wPljgXcj6UAULgdGmWlGOLTR3M84rhxDC1+yxho
 CdfcZ7QulVmBot3FvSLXujxHji36zq6OAdv3A6GrETVZ+nU+kPbC/X9y5YyDB0MSDEy5
 GMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UIapnTfcT6EWiT0i8ZWVwyA9XLv7MTGS6f6qT/tTUVo=;
 b=RRnKrQ6pW5vdLyLM3BXSwTAisBosDBFXkrVEqdolLIRyBYJaf3KgduHERpefAasR5T
 1gw0tfdXSBxDZGw1tbzFlsUlnqPAf6pGCLC5n5u762W1z/zX/g50y0hMw1UyjKbZB/FV
 tod5HeuEsYXm8GDXU6zAEVRE1PwUy6O4KpcMerCNvFzNNey8JngzsKzL9nTgmccXS/NF
 KUOls+eJN3gtzGOftsbh3SXRKYcK8IkDcIr3gkx5J6qDv9YsaUZnlF/evKfyiFc07N7V
 Re+A4AdkxjpJkzdjyzfGoQ5K9XLvwdH3jo1em49yWr5kcjvIJ0sC/TWv2TlY21wUsUpb
 7jvg==
X-Gm-Message-State: APjAAAUI+PKIZ3+1m/akAAZsS7BkuDgEpnKysfd137JBhMgsMN/OhGJV
 w4pYpAke3RAibsYVVRRlFPdMqC8oNSv2+pVXhkXHxA==
X-Google-Smtp-Source: APXvYqyorFaonW1ZtewCxlC1zS5zxoNh9X8+TItPz/okFUZYm+iTdugPmvQP2m7R2E0mDfpsd8OzpubBD4Trh11ifcM=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr82121978ota.232.1578061779375; 
 Fri, 03 Jan 2020 06:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20191219172441.7289-1-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jan 2020 14:29:28 +0000
Message-ID: <CAFEAcA9-vT2Grs2MP3AUkjzKu5Bw8_40HcPse3r8O7DZNaLUwA@mail.gmail.com>
Subject: Re: [PULL 00/30] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Dec 2019 at 17:24, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to f62f08ab7a9d902da70078992248ec5c98f652ad:
>
>   iotests: Test external snapshot with VM state (2019-12-19 18:04:25 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qemu-img: fix info --backing-chain --image-opts
> - Error out on image creation with conflicting size options
> - Fix external snapshot with VM state
> - hmp: Allow using qdev ID for qemu-io command
> - Misc code cleanup
> - Many iotests improvements


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

