Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C3C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9430E21A4A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N37QnV4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9430E21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFHg5-0003p8-Nd
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 08:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFHfC-0003Lh-AR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFHfA-0007cW-1D
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:53:57 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFHf8-0007Y4-FI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:53:55 -0400
Received: by mail-oi1-x242.google.com with SMTP id e18so14298162oii.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=62cdd8whoUsIcuO8Bop7ENGYNGZyziZSLqVWv1hBCDI=;
 b=N37QnV4dE9iJJRB6rAcSkoouEDChP6OL8l5NGtEXQ1+VgYUc0yh6Pnhp67zgbr7Klq
 HIxZVh8G5xzH3qVkNCPAcuQi0f3hmUsMjO4Cand2Ncha5TRkgiMzlFC8H+L0Q2FxiCfF
 BG1JuBZwAA2fAkZfyhoJgafjnZ/rK4ZDNzEXECqsTJMlsriPQ2P5mblzl0Q9d1cvnYt3
 v5kJeBN7bbQoRDZtGgPhnQzcXNm6mX6mhTErbLvWdHjnHKjjmyPFGbYCu5ZjkLatsXtV
 CqVhp3oYj7NXTwb/zIyDigYkT18kReVAKv6pusqZi2rYXXZRza4UBI4wga1txp8iIxNc
 vR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=62cdd8whoUsIcuO8Bop7ENGYNGZyziZSLqVWv1hBCDI=;
 b=Hn+gXLwng2buS0n3L1yAqIC5E1RubZdpVucUG46rSH6PfRE1H5wEY2oW/WnJ31vodJ
 o/5To3QcOx4VOI+VnN19zJkFSReM7wXpIAleHBLMiWf5jKLuHAuk9REFkm+tmLwo5Lkd
 H4Z/k2FDPQR/IOq94DPH4jOIlZhMHgCaHEx4J5UB9aDLMN5f400MuNFBG1/S7I3MtbvF
 KSnFAqV77ov1wHxI2+ZojgeFaQVe0ToK0EB0sAxYN1eDKMkUmALxjK0jSbiGB0h330eJ
 eL2+Jo+87Fp0hTNAH8JamreVzWuzVo+Ygh7ShpN+U5IQ3NSbWiiFjnO2bq1HUMnO9q26
 mcOw==
X-Gm-Message-State: APjAAAXPFQJMLWwA8BnWCvP3c/l3YLvH/xBrth7z0rAbAH3fedFpV8MC
 ipKVOLF5t3akwRSUK/BJ3icqP0uUzJlQggoxy3oUkA==
X-Google-Smtp-Source: APXvYqzHkzBdwcvUMHyXI4cqg+hyG4CD7NpSkt8tXJ/zVRy0debD6BnJ9zX+qF/ngO3Gf2mwv05yeJA5WiomyTTcWFE=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr3416667oib.48.1569934432820; 
 Tue, 01 Oct 2019 05:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191001105057.3949-1-thuth@redhat.com>
In-Reply-To: <20191001105057.3949-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2019 13:53:41 +0100
Message-ID: <CAFEAcA-Nfo2zot5W+j0KYqkruWQ34FL=tf42i3BoK_cWTkSTiA@mail.gmail.com>
Subject: Re: [PULL 0/5] qtest and misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Tue, 1 Oct 2019 at 11:51, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 95e9d74fe4281f7ad79a5a7511400541729aa44a:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20190930' into staging (2019-09-30 14:21:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-10-01
>
> for you to fetch changes up to 3d5e90a50bd4ffa199166e01a365f5c5995534ae:
>
>   Disallow colons in the parameter of "-accel" (2019-10-01 11:54:17 +0200)
>
> ----------------------------------------------------------------
> - Fix and re-enable the usb-hcd-ehci-test
> - Silence a Coverity warning in hw/m68k/next-cube.c
> - Fix crash that can occur when using bad binaries with "-kernel"
> - Disallow colons in the "-accel" parameter
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

