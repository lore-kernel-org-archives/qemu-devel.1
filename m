Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990E0C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82A020759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YE0VT1XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82A020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAh8-0007F2-QY
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTAg6-0005yi-Ai
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:20:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:41266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTAg4-0001Sz-9y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:20:49 -0400
Received: by mail-ej1-x629.google.com with SMTP id x7so155554eje.8
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y8+Y2zM9yrdeOQp2mh0qwhmQWfJvDRXzXtPEYxExPk4=;
 b=YE0VT1XDYmvzaRYevS/D6+RoCy/euPJ0aHVIaVahCzIzso6m4Z1FXcUphxhRbMHbiy
 w8ZX//30tt+4o3JnRhRh1Gtu5DqX/CSCBjNk4ABNdr2C4tsinkaYHSkLuwgUkqgMfaiI
 /wQs1yPpd7JSlPlUy7CGMD8my5If+vg09l7n/62D4dVxRmqKCIQ9i8+XD8cWT4uNP8C1
 4u69lPXq5wz2Hbs4mOowpa2ndEJQX8K0ZplyykVvT1VpP5uBzNIZNeLthJU1QNZxVh9D
 gwTu9F2qc2uFmRJY7K4Tw67aBP1ig5NIDtOuCnzOwOgbu9fgIZPcuvFRxnMMgDEhYgHc
 C5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y8+Y2zM9yrdeOQp2mh0qwhmQWfJvDRXzXtPEYxExPk4=;
 b=g3J2anqXDkm6AYyMNgOlPYsM6FGTXaZcuI6nGRMCZm4ezmJ54KpBMikwq/OFQm6jmk
 h6iK9mrT/yD4k4HDQ0f5swb2WpP/uUiGWm210XSvYwcfCMkJE0iuws7GYtagH4vGm+Yn
 rZJnQDnHmCeJQOJ6fIB/EuzPfwbKFTVgmJotl3KXinBYU2p0LSDUY0UnSzSabGERSPwg
 FpDfKhYKWu0tcaqa+AI6JXough3dRII6D6L1AJ+2Ttitcr7oYoAdLmeSub7unGNbH4l4
 gHRMHG6MXDOFNQTGLXCu0YnFNEGJEkN2Sv6C00Q7Zitxp1CiGktuOjA0pB3JMyoiuoNA
 Ah1Q==
X-Gm-Message-State: AOAM530UrIOUMzTH+3tGA+Kr4tKadEfjHzQ1S10DctLXWhr8nLEGpMKu
 P3LVxtEBgsubUfKHRbQs3ZMhndFUU9K0WcopKQHW6g==
X-Google-Smtp-Source: ABdhPJz2yhsU/BfMaqsYZmQY2zNF0rn8FOwHvmugppSrwoE3MhsKKHLfsqxNNX6u6vIkI9Fef2s3/xwaKnjveyfFl3E=
X-Received: by 2002:a17:906:ce21:: with SMTP id sd1mr355211ejb.4.1602796846032; 
 Thu, 15 Oct 2020 14:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201015045208.595044-1-richard.henderson@linaro.org>
In-Reply-To: <20201015045208.595044-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2020 22:20:35 +0100
Message-ID: <CAFEAcA98pYe1DnLEZw_ediGa0VxyiA11vLUcOyU0o=QFPAHcEA@mail.gmail.com>
Subject: Re: [PULL 0/3] microblaze patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Thu, 15 Oct 2020 at 05:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-mb-20201014
>
> for you to fetch changes up to 49e258df83e2200847cd4b331f48d8d872fba51c:
>
>   linux-user/microblaze: Remove non-rt signal frames (2020-10-14 21:19:56 -0700)
>
> ----------------------------------------------------------------
> Implement rt signal frames for microblaze-linux-user
> Adjust linux-user test for musl
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

