Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A39821789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2nq1e5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A39821789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQX3V-0000pG-4R
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWsM-0004mX-9g
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:34 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:40730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWsK-00063L-7U
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:33 -0400
Received: by mail-ed1-x52c.google.com with SMTP id p13so6042549edi.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ENzPui0FFSiuhabXv2sBl7CjwRphAxv2OmzMN9IQUJ4=;
 b=s2nq1e5huZLlVZZDqqB0pxl9w7rNf5biwJ8s0xT+EuMnhmi2dMHsYH72dxyaE8DS5N
 VL30xgY3CZdaTIeDQOJ5x8x/bec3gVem70RBxPHvqrWhXmRanoiTq9bJM87QyDlFV3d2
 X9bh2Cfur/6aYqgDjHExcgHp30ivNeWmcYQz0fKJuEhBctferCdQSgpFqsakjWzEm5aL
 GUiqbyR74fh+cazCnKWWOdzndZgK6rUaJyanvzzBwNMYLNL3XM3XbbalDvHlFbGChox2
 YcnlvO4bDi2RWFF6szs0lfIAUhfPVeJU7XdlEVfIQKEupSadzG972ntAlpe7WJm6ul5c
 BTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ENzPui0FFSiuhabXv2sBl7CjwRphAxv2OmzMN9IQUJ4=;
 b=HpKao+WcCGvbmDVnSpp5pDFgzo8kC7BtF6I5iDHcJvVyP+9TmyFDox9/IAj7ahx4R/
 PyJW31O5NaZK29Df5sxPc0iW2EBqtn+cKZEq7M5dm4ZAyas/kataoFdXg250sZj9Vj6i
 rpWdqK5umASRrQ0luiB3EC8LnMQ6tiqGHyfYdq5gLo7AQmBOPgrknZ8Csy47mHiATji1
 WySWaQ2F1acTbKqwhyiizX70MBdLace7qRc6lCdIljs4+sF4AGAChMddXM6DFp4fBMwQ
 1qn3qHydVG+8LP3KGb9Z4JNpRh15002FwXjnGijvoj7uDeW1b7IZevxXG1BcTDxl8Cmh
 qRuQ==
X-Gm-Message-State: AOAM532rFrqQre+RkuJgwVmdGo6NpxpeeZ0zdbLLXrgWwQ9V3wZJX7Y4
 U9W0YWt44SgbLTtjkudWPU/nGkyuUu9v6sEJgFf4Zg==
X-Google-Smtp-Source: ABdhPJwMedzinlUFJ/wAFOoqYIV7zG5GmqHPqkOEmzgUMzmpohrJ0p1Na1o70qd6LxfutZK81t5/SE8MsZXW70Rv9BQ=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr9398249edq.204.1602167190635; 
 Thu, 08 Oct 2020 07:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201006220930.908275-1-ehabkost@redhat.com>
In-Reply-To: <20201006220930.908275-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 15:26:19 +0100
Message-ID: <CAFEAcA_fUUWRWLTExQQ_YZFzZB5PzyT56Ci+iHj-OCFgCjdJfQ@mail.gmail.com>
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-06
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Oct 2020 at 23:09, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit d7c5b788295426c1ef48a9ffc3432c51220f69=
ba:
>
>   Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/block-pull-r=
equest' into staging (2020-10-06 12:15:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 1b5e843ab68c4afa611da22f303a5b0daa979ad8:
>
>   numa: hmat: require parent cache description before the next level one =
(2020-10-06 11:09:41 -0400)
>
> ----------------------------------------------------------------
> machine + QOM queue, 2020-10-06
>
> * QOM documentation fixes and cleanups (Eduardo Habkost)
> * user-mode: Prune build dependencies (Philippe Mathieu-Daud=C3=A9)
> * qom: Improve error message (Philippe Mathieu-Daud=C3=A9)
> * numa: hmat: require parent cache description before the next
>   level one (Igor Mammedov)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

