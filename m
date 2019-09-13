Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD2C4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DCC206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKU2zHoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DCC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lpd-0001Sp-HK
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8llk-0005qq-QZ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8llj-0003tl-DI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:37:48 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:38226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8llj-0003tO-7K
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:37:47 -0400
Received: by mail-oi1-x22d.google.com with SMTP id 7so2485062oip.5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fyxr3a37vqCtU8K0xrXBUrT+NllG5NhQ29KAT6gZqgg=;
 b=HKU2zHoeUmb9IeCHByftLN+Yhbz9UHQB3mYWK41ScRDhoniCAOFHPTpwEaEXpHnicX
 V51t+odwtQak0QlF24OpywxDJCXOvxu91jyQN+rwaiU574Ywn800zzp0unMTmFbikWBF
 yHz7i8xqA4LTRFeQeUlTJo1jhPnCn1dOkK+ghrHVVFj4YfJkrRs/lUvCJLX8RzWCUU7l
 iZhaZJL2K60yvVmyute3WOBF+89tJGzB6pRC8tLBvpeJabE/iBFGZq3s6FzNv5d9EXmC
 /BaT/AxTCuQplmpI20s1XAwKIsXumInhls9gAIqd8PaZP75rp/RkVHjJ///LAe4EWHUB
 5mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fyxr3a37vqCtU8K0xrXBUrT+NllG5NhQ29KAT6gZqgg=;
 b=pJlpP4tWe4TjEyMEafxS6rAyVQfEkoA9Pizy9fMHTE3hGuJLBmUajpVhG3A2Rwji0J
 RqnF/JwMW3eZLzYr/wATYUIDYKjjd1IANRt3PLuLOB0om7xyBwzTq/yzcPrneW+4I+/V
 QC7+WInxS7mhUMj537F6J16Xfy/e5JaNlgROCDPo7S08iy7ae8Hs83vtYJIBRc+9qepS
 G2yzKE8Y77ITARvhCGZynWQLgWmPY2j0GuKc5gsdzt+oNk1dyQZOF1q6Ib2TUZlv4xc3
 FTGQXvyiz6MNH0Li7wbvtjB2+ifA89BsxREAdOJb6Z4AcdrOKl3XX4809zvIyCTPjU0I
 I+3Q==
X-Gm-Message-State: APjAAAXSp1X+oK04b5z34NVq9c9RPShvj97tOodZeRuv4UbegmUNW8Ff
 fj83dOcKcNqFavgdfb3w+51PiB9z6tDAL1I7awhMoJaZBq4=
X-Google-Smtp-Source: APXvYqw3v6d3fOqSeabssAJNatynIt+W7/pXcaRDPMG4SKE3RGzbo3iRM6BWcZdWPNd8s4lL9ovQFthhUWQdYPGEfkU=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr3341345oih.170.1568381866289; 
 Fri, 13 Sep 2019 06:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190912134604.22019-1-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:37:35 +0100
Message-ID: <CAFEAcA9m3ohGQDeO=0hCkL45gXrtPgsn0O74Hg-7TiZ5N+1FFw@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL 00/22] Block layer patches
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

On Thu, 12 Sep 2019 at 14:46, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 65f9f0c2a53b1572043501bb4e99500914e88cc6:
>
>   qcow2: Stop overwriting compressed clusters one by one (2019-09-12 11:26:59 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Allow overwriting multiple compressed clusters at once for
>   better performance
> - nfs: add support for nfs_umount
> - file-posix: write_zeroes fixes
> - qemu-io, blockdev-create, pr-manager: Fix crashes and memory leaks
> - qcow2: Fix the calculation of the maximum L2 cache size
> - vpc: Fix return code for vpc_co_create()
> - blockjob: Code cleanup
> - iotests improvements (e.g. for use with valgrind)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

