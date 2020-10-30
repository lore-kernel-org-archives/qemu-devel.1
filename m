Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB44BC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D483206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4a2vQSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D483206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVYb-0007lj-Rh
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVVp-0005TD-Sv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:36:18 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:36537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVVo-00023x-2F
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:36:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id l16so6924721eds.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oo+Ia0mQ7kCl1S2sinh0tTOX+6Nu7pGHMFWay0b7uQk=;
 b=M4a2vQSmEuCb09MfHJHEOJDlIFoMhAY8OgKOxOpk5vnDOIgpGJg2I+kC65Cfo+48Dd
 MEp7K2DPOo1buMKPuRTz15iV61ynWUhpt28ICIYU5pjtyOg2nxXuLPDde6T0QzgrEXHO
 ewPWm2d8E3C0K1UbXiPcNzm/SscexDrTbPysJauAR63rdBTDOJex6QH/2UmWFExVnXxR
 I+zt4xWgbkqbtSQXPdTBtyNb9XInwmDBjy1VtkNDPLG5U64D/j1zLp9JWnmrprIjm05m
 IX6WtPdLROjbJR3ayBT9Nf/kjHu5Me73LKRTnvMwhmhZ0dIxATah9Ww2/rqILgBota5f
 6ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oo+Ia0mQ7kCl1S2sinh0tTOX+6Nu7pGHMFWay0b7uQk=;
 b=hJBdYV/EKPjQMkBUX9ih9PNubn8nD8gnAkIrNSVRQB9NjIMVPzjZwnKMKXxaOoXUr1
 +maXXI/+Mv4Gw0AWKZ6ktR6D11G1fCIay6zOVW1ySGpj42n1bPs18DnKftAFGC2ZA+RH
 oa0Zq14wUoNDBKIoBWsr6wr4FEoxqZJSQN3QAtbIsY4UdAJUwjHHNjYKm3Dn4UxeIL2l
 ExAH/RsQHKURz2Miw375dO8SCUQrIbGlgmBWUmEaZ3HXQmcf4eVzFS5HI67iLaK4alJH
 x25QO8+EGgrqxhBHQKASJCrBj++knZq8QAc4B85LobAvevpo7gqjISK65HeISCbZmV/p
 kCJA==
X-Gm-Message-State: AOAM530mDj5toErgw0wAtjT8ZIsEb2fh5K+5ItpAXGiuMsnTwGqPzxG2
 VT0FZra+tUdsBiYpXg0ItImYiT61TCELglvQXjCHatpFZuw=
X-Google-Smtp-Source: ABdhPJyRxk5tgd0PupsQxIEINjSPK2Yiiwnr4QUNa9j6ItfTRyZgGK5hZnWksX0TRRcgHFrBiIw8yKsboXPlHErnA+8=
X-Received: by 2002:a50:f41a:: with SMTP id r26mr2604225edm.251.1604068574618; 
 Fri, 30 Oct 2020 07:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201027144255.77478-1-jsnow@redhat.com>
In-Reply-To: <20201027144255.77478-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:36:03 +0000
Message-ID: <CAFEAcA_yQifGfyBFDGeVWgN98FFORGqVg57vggzRyOaNzG6P1w@mail.gmail.com>
Subject: Re: [PULL 0/3] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 14:43, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit a95e0396c805735c491a049b01de6f5a713fb91b:
>
>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-26 15:49:11 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 1a9925e3390b6adf1125e3abaa17c80ca012bede:
>
>   ide: clear SRST after SRST finishes (2020-10-27 10:39:06 -0400)
>
> ----------------------------------------------------------------
> IDE Pull request
>
> ----------------------------------------------------------------
>
> John Snow (3):
>   ide: run diagnostic after SRST
>   ide: perform SRST as early as possible
>   ide: clear SRST after SRST finishes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

