Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8CBC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08997216F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPSuO/8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08997216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEtCM-0001Az-03
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEtB4-0000bK-AE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEtB3-0007Bh-0N
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:45:13 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEtB2-0007At-RO
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:45:12 -0400
Received: by mail-oi1-x244.google.com with SMTP id e18so10688331oii.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=/FPjJA77sysVQvLWjS0MNUqSTUBeOpjVJToJgbmxKv4=;
 b=NPSuO/8FWXYcclZCaRaY4DzEGnI/MJnr4PiAQtla+830u+O9Gyq2vr7Jh9cL3W2ET9
 mI+J3i7BZpyFNlGR2uPeYCL3TeBsfErG70XMOFb35AHPIT5ByqU1sM0iqYtG/qkNhb/j
 BrJaDsvvgSUYR20i3w9VBOUOuk8bRvNl+AwPIINUNndx0fldKo98wyM5X6ejGrqVMcH2
 kT8d1RWl7TpxWczEEeNDgAU0fD48FyVm1BfBz6jwV6Vdy9JdNot3qhno+RgZ5Ylo8eXj
 PSDAo9l2eimvBToqVnPwvaWc64oI6iWc2CmqTWg8F+3w3t4DgB8NPqw0CQ1wf/C/MTdN
 JxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=/FPjJA77sysVQvLWjS0MNUqSTUBeOpjVJToJgbmxKv4=;
 b=Lo6fbhHtW4iZ0AQsGmySiVhcIasDjnavoqoTerrwQqN1cQ5LmonhKXYCxweDenMTXR
 x/iJm3qis+PlUOuhpH5qth/U9p5070AjG2n8c6Rn1WRpkPO2Ni+ewQMumjqgD8lPAEvn
 Qjt9YNVOiNijAZevU1dlFJ/P4XXiOm+S0eFFzyrO1D0rG0RmpuqtAkXDpsfT1O3N1/KV
 M35K+CS6+EUiVUgUTkHjWI3iHKjhMAqsJ4MVm+6/z6Abom+28yYkHVF6SzYRcE71a7oA
 Jj1i64zoaY16j+nQYlah2qjxX8v9zmi9Jhd/wBesL1V6/heV4eOU8iJVy70oTptyBq0G
 u7uQ==
X-Gm-Message-State: APjAAAWqwljSDZOcTHxXIYQUmdwtznhCyzL57+iomK5ZePhXU+5sc0ny
 NQjhnlOpBWsKBn8gJwWV+1nlplieV8KIDoMrVYpLDO+ExJU=
X-Google-Smtp-Source: APXvYqyLTLs50rE3QQQZXDd2Uh5Nm1pxrV66A/o/4zVlXzVzRNp6/wehLxepxXwKq1T1a1NOBX8cBATkIpYcMWtgMoA=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr16434762oib.48.1569840311745; 
 Mon, 30 Sep 2019 03:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144249.29999-1-peter.maydell@linaro.org>
In-Reply-To: <20190927144249.29999-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 11:45:01 +0100
Message-ID: <CAFEAcA8qXt8cySSwsQHXOm2L0B3ZsybE4HwEZb2hsswR-CjR7g@mail.gmail.com>
Subject: Re: [PULL 0/9] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Sep 2019 at 15:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue: nothing major here, but no point
> sitting on them waiting for more stuff to come along.
>
> thanks
> -- PMM
>
> The following changes since commit 1329132d28bf14b9508f7a1f04a2c63422bc3f99:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-09-26 16:14:03 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190927
>
> for you to fetch changes up to e4e34855e658b78ecac50a651cc847662ff02cfd:
>
>   hw/arm/boot: Use the IEC binary prefix definitions (2019-09-27 11:44:39 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix the CBAR register implementation for Cortex-A53,
>    Cortex-A57, Cortex-A72
>  * Fix direct booting of Linux kernels on emulated CPUs
>    which have an AArch32 EL3 (incorrect NSACR settings
>    meant they could not access the FPU)
>  * semihosting cleanup: do more work at translate time
>    and less work at runtime


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

