Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8649E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ruFtuNZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8649E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnaJ-0005Fx-OJ
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGnXv-0002uY-85
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGnXu-00074J-1R
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:40:59 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGnXt-00073s-1l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:40:57 -0400
Received: by mail-oi1-x22a.google.com with SMTP id k9so6659181oia.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D1GfAcqadSGh4oZfhJetFLzpVXroGtEqAj1ZVmVVb3g=;
 b=ruFtuNZjt49X/eA3NIKnGbJGDEUNis6crekBLkyjlBDGyOLcji1xxK4rvbLaqRlfZi
 7zGHN8Jyqr2KZDTomQh1Qbik0rPC0iKB23aVJX+I9FWDvo9gvzU3p6QJLzCEQuv7cq23
 AnL5IQRdaYYJj5qfyLMOBTfl7OpLQVwAmjuaeCDSGGXWqEFklu8jD/+VFDhDe0f9uYtl
 A6jgt3OaI6nQx4h9QAsBhCRmFGu0WET5hGHctZRdala5m7yINFBGYgkEAN6CXYJDm/dq
 58JUKiaXvNqDqm9alY2n4m0xowH0gSPZQAdMlvIn2qPnYVq5PgzsQNfxzL1Z678frycW
 ZYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D1GfAcqadSGh4oZfhJetFLzpVXroGtEqAj1ZVmVVb3g=;
 b=h4AAqlmmiz859FYnfbesXMmmdw0DNt+GbxamEzBoILAdrwgb7rXkzrTlmH6HN/P6cT
 fpjf/75lTvNttOdoVABGO5k3qDalmhFZGZ0pxd3zQ0XtRO8d4DTdYFofwzu7g+oslIa7
 VK7VlEt//ui5sPSo8Ra5ZsdALgDVGqE2ITMZjeiv7H79UC4s94TzrqQA5O31Ylod77F0
 39z3IVLlb5M/eDmorDxIAEk83Cimumzmk/sXrtOzzmYi4ZleqxCsYT5m5TIsvM39p09Q
 Q9G0Gor4camTZUToiZ1OrVin7gn+oTAPh8J+ybxLzZvNZgL7+sZdLVsPmZ+BUZLxqtt8
 +USg==
X-Gm-Message-State: ANhLgQ2hmiTTwy/rjjzRdqfnEPxiUs1qHQOaWa1vF4jjch3U1HPdtDEO
 +rFdG1YtKJbqRpjj5kEg/hjLdQI3ksJhdwlGCLLNurGE42M=
X-Google-Smtp-Source: ADFU+vt3YDSWjSax28QSxpKU2zcOq+p3hGFjnLyWP5LYK4xDRyak4Ob0G3ABGFRv83GrlP95HWIPCpwgNDOqQ/wAShU=
X-Received: by 2002:a54:4614:: with SMTP id p20mr4084676oip.48.1585071655967; 
 Tue, 24 Mar 2020 10:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 17:40:44 +0000
Message-ID: <CAFEAcA_f=0dDVkiFqoxhGevxyWFF2Cv4=u74o5cXW9aiM2BTpg@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/5] qemu-ga patch queue for hard-freeze
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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

On Tue, 24 Mar 2020 at 16:47, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>
> The following changes since commit 62a43e53faed67a5aa4bfededca24c9079de9720:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-03-24' into staging (2020-03-24 12:24:41 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2020-03-24-tag0
>
> for you to fetch changes up to 7b46aadbbfb7b06cd45a3b113b1f7c003c68f603:
>
>   qemu-ga: document vsock-listen in the man page (2020-03-24 11:32:19 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for hard-freeze
>
> * fix undefined C behavior with guest-file-* interfaces
> * fix w32 installer issues
> * fix crash for large file reads via guest-file-read on windows
> * add missing man page documentation for virtio-vsock
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

