Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F185D206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTOak7rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F185D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjgkY-00047u-98
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 06:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjgjs-0003iE-Dj
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 06:16:44 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34979)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjgjq-0003nh-FN
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 06:16:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so8208664oik.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X5ZOolZkD3TRJB3LinnATQSz7CpGg17Ou/RxfFKZjfs=;
 b=WTOak7rjwX798iSvL9pchPBXseN1ISnUC94RZQCUWEu36j3HbHAhVV25pGXWQDep2l
 iFvFeMHoNm8hH6nMrMk2o6yhKuWKQiK9G46iFcyHNXbn2qAUV9wJludcOIMbe/5sReIb
 2BWxXDQm7kEJBpYLj6OHqgWbCTgzeOlxCTfDauuXFdbJ4/n9LeCO4u0NtUqeH1w+gQBs
 LAnBxEndgZcd12W2ApY5udNXjTbYfvWrebMRX96R+rljEMaOjiciP9Ler25y515gECcP
 CXRMYtMuVmDPcsc+AiWzNFLdyTyy0osXi9d5zBL2UrGcZk4zu9WfuZiPczGdJhGfjL7G
 wBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X5ZOolZkD3TRJB3LinnATQSz7CpGg17Ou/RxfFKZjfs=;
 b=iozpLUMnXY5R/qzVJ2fGQ5JlyBPW/0eiCZwMhrWZy0Vxc0QbUGagh1M8vJMRmZZIug
 PHlqE17fs8rhPyLbWzUc+dhDLSZajI2NInpchjCBG5KCPdNoqXtXtaEhz1acjU3JUFPJ
 en/EC1bnS5YDq6aDnb+dbL0dFwnQduS4SHUdiHMBFGt7CRiTReYE1fbeZKzDdRjHyc5S
 /noEJGTiGnWNV3t5gVXGjjytEWsWeZaaHzvY5r+5X2wdokpXMzKeT97ydoJq5+Ryx+Wh
 ywS1WUb7bFDxWpXFGZCbBc/U5QTKnKfpVnzCNwHM/FcU1bxtRK8ryTQbZmC9pluS/xhf
 YWqw==
X-Gm-Message-State: AOAM532T5CvKpYofCBgoCS7QGWfhL3YUuXO5oiqkLFCV5W8M4mhTOvW8
 bnL5KGubbkenaWv5QhO+RDospJ6TV1czXqm0x1Eakg==
X-Google-Smtp-Source: ABdhPJzy+rQZsRGCZrwFfz1gl8wc4XosktP16acejhGZi8MNcaO+BTOg8ZH+Xr5iZR56ecxypgymIvyLPMEOEbtdFu0=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr1550445oia.163.1591956993623; 
 Fri, 12 Jun 2020 03:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <159190218710.22110.16614504111613456036.stgit@gimli.home>
In-Reply-To: <159190218710.22110.16614504111613456036.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jun 2020 11:16:22 +0100
Message-ID: <CAFEAcA_xzEzTfvZvypkqHKGOE3CzZ6bBEnXF-BaEeCM3yBdS+w@mail.gmail.com>
Subject: Re: [PULL 0/2] VFIO update 2020-06-11
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 at 20:06, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The following changes since commit 3666f684761a3cccd86d13c752273be207ecade4:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-06-09' into staging (2020-06-11 15:35:44 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20200611.0
>
> for you to fetch changes up to 643a4eacef87a318cf71800a4fb2ae1f78c4b245:
>
>   hw/vfio/pci-quirks: Fix broken legacy IGD passthrough (2020-06-11 11:36:40 -0600)
>
> ----------------------------------------------------------------
> VFIO update 2020-06-11
>
>  - Fix IGD split, include header to honor Kconfig (Thomas Huth)
>
>  - New VMD device paravirt quirk (Jon Derrick)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

