Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B341C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90477235F7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDeYeW/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90477235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL74X-0004B1-Oi
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL70S-0001fw-11
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:48:32 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:39501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL70Q-00016I-2w
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:48:31 -0400
Received: by mail-ej1-x636.google.com with SMTP id p9so303197ejf.6
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hoSLV7QrRg7nM7klqgMFYGs5i8RNjXEV33ulkcSfcew=;
 b=jDeYeW/8TZlaaC2aKVYW3I//EjNV7mh5L8mYg9q++ru607RgCQv464+lmxbUE8JFIJ
 P+tA/liJd649/2BHyjyf3ypfG0vsC3pZNaF7XK0Q2bcUOR24IEetzhroJ37l5du/ZFMC
 KbV+6hxvwZ5sydaULMGeZqrArl62UcQP5gZieD3faMULUeE3wLqM3LvIAzV1CdXh8grw
 6VjNHOfWRmJieOt+YbIEaD3HRxYoAxk+Cp4180ax9g5yaGGePscOjmHNsqxa9/+1ul71
 j9+ny3pBMhGrhVhOqFxzjw7Tbo/JuQsFSOCL5/oKkGTz0eFg8RffZUe/UmLRLr+GfYp0
 f4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hoSLV7QrRg7nM7klqgMFYGs5i8RNjXEV33ulkcSfcew=;
 b=kzTOadtsjeUjM360r30/oRiT0a3jHS9UjDNPqkCt+Y8z0i/IBaRm/eOuaIa13rz1xb
 t2t6M0TBlSRHEnJL1m0FGfiw6lJJhjs8W0v5L75MOpbG+cwQgZ/fYkGAKeDLI/xHb6Zz
 oWVgs4Bb2yMHTnStWZD4J45NV6T7kxEq9eIJKzr515mX6ewHAvDDWCnBJOJT/Fo0/lnW
 pYYOIPYnrisDLSGevadm62LD6hsL4HcUbQCpUt8sIV1bljh7DjopsEOnw9PHyo7gvPpR
 3o8+F2TQxXD+av2L3CH63RtfDP0pmdi1WGT11MgiF1Pctv9ou0xnDWR3pybSLsxL9sLu
 bhDQ==
X-Gm-Message-State: AOAM533k6xjlIjAe3yNFw4IImi9Yx6krLMIKuAFYlOS6YrNUCgJdRlb2
 nUvcJ+7OgAWYX/3FLaWMPw3mVpK+zZ6/kZyxeZ7ytw==
X-Google-Smtp-Source: ABdhPJyICVlgpTqvzkOAP0k5lgSFdNesI6tP9FnlcNuDyyqc3eQnSbeHNo8Rnj6txr0qa2+cYMxg/jJb7nKODkTuD98=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr329003ejb.4.1600876107709; 
 Wed, 23 Sep 2020 08:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200922010335.1578850-1-eblake@redhat.com>
In-Reply-To: <20200922010335.1578850-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Sep 2020 16:48:16 +0100
Message-ID: <CAFEAcA-vZJFpopt6KQchSvtFZv=eMbg+nsDZPPM-ibQ7m9yBBg@mail.gmail.com>
Subject: Re: [PULL 0/1] bitmaps patches for 2020-09-21
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Sep 2020 at 02:06, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 5df6c87e8080e0021e975c8387baa20cfe43c932:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-09-21 17:41:32 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-09-21
>
> for you to fetch changes up to 14f16bf9474c860ecc127a66a86961942319f7af:
>
>   qemu-img: Support bitmap --merge into backing image (2020-09-21 17:01:09 -0500)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-09-21
>
> - Eric Blake: Improve 'qemu-img bitmap --merge' by not opening backing images
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

