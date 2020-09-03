Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A269CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2762072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSFQNHky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2762072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrda-0007pq-PJ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDrd3-0007Im-5v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:58:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:36342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDrd1-0005lJ-ER
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:58:24 -0400
Received: by mail-ej1-x631.google.com with SMTP id e23so4607031eja.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JGS3LGM60Jy/U0tWyUV3dbPurF4sL3i6GE1P1AEgI1A=;
 b=QSFQNHkyVF8+RN/kgL9PaGs5XlaLSHiCJKEs/heAL/3fxBffdHrjQ4YVgBdCvAox8G
 9+4OjpFRJ9pykDtL0tGwSnG1U6R0/kGZk/ft3ETQ0y/D1ofBkOk8IUhAzoYnsLdysF8+
 zxIhq1zfUBakwdQZB7gbmMHA26bICj3HBn8Y+LcGKZSNIgEovMT2HCl/P/SyM45Q5HOL
 y65MUQ75v8TN1ucl+mXjmN86ooPvoYA1CVT+AX15kf9XQDl/wsKu+suoBFAf6m3u6+uz
 E5y9KHTiR5E397HpAm7rYXm4ndFqAAhv6gtcwYbst9bcCKVZS+YmguUCtPb/tjtagXM1
 GYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JGS3LGM60Jy/U0tWyUV3dbPurF4sL3i6GE1P1AEgI1A=;
 b=RQEu55RwpKd5gtfxmg1AZ0XULjSj8l9iF8zqE7HnuZrYNKqaHf2Pz/B1hwQyIh5vo0
 Wl/D/jyZTPHDlunjQsLSUgRP5PEBzodddE2LZKILSFVMBHs8recOb7kZTiu7rrqGzH4B
 ZWRI7CYYu/dFvh1n5m6l7iar8qXxV0ociYW5P/kOqD8QJ8PxOAFgPRINZbzrFPvEE83r
 ZQLF8VdKOjh6W69nmopXRC9OxxXRFlg1OHX62Xhg6tVvw7YIPTtMRg0PCuT4YIdMaJK4
 g2iVf43LVNTygP5GSHXI8Zl5R+EKlWXpGXiz4a+tDMGNAUyui+WZDN3E42QQZECZp5ix
 Rd1A==
X-Gm-Message-State: AOAM530eQsvgTgfR2YyeVrjXWT7kq4ovoyyhHXtPLmREmDYPzPD/zFCl
 przX58oCdI78fk1bG0Z5IOzx1ZQw9bYW5wYeVJW9Vg==
X-Google-Smtp-Source: ABdhPJy6nI7dC6daP4FEhyhMdG5sb2+xNK7xRQ2Rc1jR5x03cy8F6YCMr/aPfVkBTyTM+a75ZbG63rLae10wLXBBp9E=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr2767940ejk.250.1599148701630; 
 Thu, 03 Sep 2020 08:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200901124525.220252-1-clg@kaod.org>
In-Reply-To: <20200901124525.220252-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2020 16:58:10 +0100
Message-ID: <CAFEAcA8Rz=0knh63e70tDSNAhXEERYhq-JMBM-pvHAr=k3O46g@mail.gmail.com>
Subject: Re: [PULL 00/20] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Tue, 1 Sep 2020 at 13:45, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d=
75:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-req=
uest' into staging (2020-08-31 19:39:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20200901
>
> for you to fetch changes up to ddd8ab19749b8639fc08bfe4d0df0204eec049f0:
>
>   hw: add a number of SPI-flash's of m25p80 family (2020-09-01 14:21:51 +=
0200)
>
> ----------------------------------------------------------------
> Various fixes of Aspeed machines :
>
> * New Supermicro X11 BMC machine (Erik)
> * Fixed valid access size on AST2400 SCU
> * Improved robustness of the ftgmac100 model.
> * New flash models in m25p80 (Igor)
> * Fixed reset sequence of SDHCI/eMMC controllers
> * Improved support of the AST2600 SDMC  (Joel)
> * Couple of SMC cleanups


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

