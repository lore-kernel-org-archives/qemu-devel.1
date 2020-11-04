Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E66C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DECD2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8A3p/BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DECD2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaM1k-0003XI-SE
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaM1B-00036q-Kf
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:52:17 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:41590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaM19-0003Ym-Q8
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:52:17 -0500
Received: by mail-ed1-x52a.google.com with SMTP id l24so23131761edj.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k4jSRRFzoRbguAZezJSW6oheX3UjW0JRhvFSd+h7jJI=;
 b=h8A3p/BOguWwcjT/9tBC5sSkl0rqkD8NQ36OlYDOdPg+LJzvNluhHDG5cfQkDj887F
 wr+LPIgOt/Q1UIrR0LUc2EQP/iVlRfxNuHJDLsDN9xyWpnI2SmqCdE/Le2FzIeJ7Isxa
 WFVsH/1givYPwxTch1G1wicDkhBywr5eKMNlCESTpxByAhraQqs/XzYIxWLmfQ2LV+cN
 e4+YpCmEGxQmebsmilMZugvsXQ01Xj4TG7q2vphexAOF926MrZnq21Ubs8Uy4kOC1LGZ
 8mcCt0AG+sMPu7SVre6oL0m+NzAeITvso0x6uKZgAjszUcf06uURDNnmgBATe6zfh+pM
 rYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k4jSRRFzoRbguAZezJSW6oheX3UjW0JRhvFSd+h7jJI=;
 b=jF6rCn1d3jZ3w7pZOA1ssjL1Av2VW4k+tSFbGBhRbcRTdIMazPUgBgJIXzon73jGan
 sS2IS+Ajnr/C42XH/vkYmlmNY5rjKUjvUuwuB5oRZAG2O6aT3Tzd3zwuyKXxctN5gO1O
 zpB1rxeNEqSxDZ6EqhKumVVV4/YdiyZFwPzOvX+ubQvoctWOeNUdQSq9meSH2YccpDPM
 iJ9K41XwIp/fp08wrsFoZYvgcK8X4IrWOjE6mns+ubOUNeCD6NPso1O6DrzkiNUgEKoG
 IDcAWakv9uBpdWQbcHBMha5VQoc2rBsOOwdqkIUZrAkg+zliKUvR0EO1eO1v3gtFsjzp
 DZZw==
X-Gm-Message-State: AOAM530CtidvpTh/lzSxvfKznxYEiaZofp8cykYTOU1+tFjBnFqJhaWp
 jA447brQ8gefGM/x+2eoul5yZJuVd+F6N25UT5p3eQ==
X-Google-Smtp-Source: ABdhPJx7Cv/gTx84wFvCbtUtdKZpRlHp8vE6+ViDUZrvzgsQdd0LSBJvbEM1jFI59wzBFHsc4dJE9zibpFA1wf22T9I=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr27240392edq.146.1604508733971; 
 Wed, 04 Nov 2020 08:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20201104121321.7772-1-kraxel@redhat.com>
In-Reply-To: <20201104121321.7772-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 16:52:02 +0000
Message-ID: <CAFEAcA8odz-+rX=1J3N6rcSBamVrrc+NSGZJzTKyGhtrotzt=g@mail.gmail.com>
Subject: Re: [PULL 0/8] Usb 20201104 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 12:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 3d6e32347a3b57dac7f469a07c5f520e69bd070a:
>
>   Update version for v5.2.0-rc0 release (2020-11-03 21:11:57 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20201104-pull-request
>
> for you to fetch changes up to 963a7bed570ce12604a48755c78244a2b6e179b3:
>
>   dev-serial: store flow control and xon/xoff characters (2020-11-04 07:22:37 +0100)
>
> ----------------------------------------------------------------
> usb: bugfixes for usb-serial
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

