Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4466C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DBA2088E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+1JwcZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DBA2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joULG-0008Ai-QH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joU9a-000578-Lb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:51:06 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joU9Y-0003j9-Ma
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:51:06 -0400
Received: by mail-oi1-x236.google.com with SMTP id l63so5340055oih.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K+p06Jf57EbEv8jUo9zuAl0cwALSt9/uJraMe9mgTqs=;
 b=T+1JwcZI7viWWou3g5aDUqpvTAqrvltA8g9nFFbmGZJaIepgmf565PRsIWuts1rxhy
 iyikFfO/TR+32rn5qrKIE2pJsu23wTNxQy4n9hnSZgzQlY1BbBzfVrw3VSvgSrGCoQ9k
 GW5iLkPSKl1uJbgSoORRjzdIHL1oQg+9VGlvUx5QDOwglmWQcBQ6JWnNX0yd+4/o8pc9
 akr0HcxciOB6KrTPOHUMGBLmbFw0ZX41vcN7LramJ0Dbi5i/pnNlhD0wdPp5oZjA/5q9
 gaVaCWW0guqQhhuALX0HbeNVQ9l6/yGm/Y0YO02cLlCSQU5if9CIqwWhFmYHJBSzlbJQ
 eV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K+p06Jf57EbEv8jUo9zuAl0cwALSt9/uJraMe9mgTqs=;
 b=blccrta4Pp8DIgeOwfsRCByhvHqJorlfekOMMEaj93LyhNLVfrgNwYp0JOka/JWIpU
 9IIYneJfJA3S7soqxDx/3vCI5a5IVjDLuUmS5c2W28z3gcvlXp20rEmi6nsKZM1liPMW
 T4bvy5Mx0P4t8GTaEn/4U5ueuPMtiE30KFKh7IhPB5EutoAbeHrkVG8KUcytNQbciw4S
 wmfdy1+xhxtoiIjZ9K6AzdVZyofUXVSVgwDRd9AzW8NdxH0N2h1mgHozW2q7I1MZAe7y
 DtAc5NHle35U/9V9/fTVES6OgT1lGMdk0hp+0JMPZUQO8F/Gj8WQjFHqjEBQAO+Xm1Gb
 Pn3g==
X-Gm-Message-State: AOAM532iYyiF6naXbGBROkn48TCSsJ/a42nPQH7j18oXN0ZDcjDIV/P1
 4ytIEXGwOstqz7TvROPQK/xJPb71SGTs2tVi2fAAKw==
X-Google-Smtp-Source: ABdhPJx9cN4O+YS5kO9A6JznpZginqKkNDbLC/oTwvPL8DmYbpNwXJQQ2VjsnTPtr3u+kuiqPrNMn/pBWm8IOOA07bc=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2604156oib.48.1593100263233; 
 Thu, 25 Jun 2020 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200624104917.375143-1-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 16:50:52 +0100
Message-ID: <CAFEAcA_qGeAaKbfRn4TsP4sAA-Q2XYjh+0o5s4p2dp5SN6Mirg@mail.gmail.com>
Subject: Re: [PULL 00/31] Misc patches for 2020-06-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x236.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200619-3' into staging (2020-06-22 14:45:25 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7fc58934d34e939489e20af4c97aeb095c1f2b20:
>
>   i386: Mask SVM features if nested SVM is disabled (2020-06-24 04:37:59 -0400)
>

Hi; this has a 32-bit/64-bit format string issue, I'm afraid:

/Users/pm215/src/qemu-for-merges/exec.c:2383:32: error: format
specifies type 'unsigned long' but the argument has type 'uint64_t'
(aka 'unsigned long long') [-Werror,-Wformat]
                   file_align, mr->align);
                   ~~~~~~~~~~~~^~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
expanded from macro 'error_setg'
                        (fmt), ## __VA_ARGS__)
                         ~~~      ^~~~~~~~~~~

(It also had a trivial rebase conflict with master in hw/arm/virt.c.)

thanks
-- PMM

