Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953B221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9uH592q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953B221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BGs-00028Q-R5
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1BE1-000883-0D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1BDz-0001RV-NQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:11:36 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:45128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1BDz-0001RB-I2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:11:35 -0400
Received: by mail-ot1-x329.google.com with SMTP id m24so9029476otp.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lm640zrH4mz7W6z5S5SAsE7tGO6rb9vaMQRb3+m+l0Y=;
 b=C9uH592qIvrJo3I//hu0/RWvlgnrxbWvlnOCGlJEP2PtdoyAdBV0CkcFpxAPmU1amj
 0wNTDLXa59rGx5bmEcbTXSS1JwC7vJbxlbIWAIfFkYlPMG3NDfWI+kxpVGBNO7UmA2o9
 ude12UfSV4sktWkQjE+4SWofs9jZDWKUR3J/z/d/Lo4VlaKnZugHH5JeBX7PlFihD3+s
 yjLm8bM29jCyiTSLKWhS4z83V/LSAYekQbPbCJGFVxibZYTLv9j8kDEt9GrPQg8dQc4G
 ewUjGp6XY5KVk9LQ8DxWnCGPeN1NxPYscw9aMq2rua+Plsm7iurIQARoI01LdLfHnxZC
 xImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lm640zrH4mz7W6z5S5SAsE7tGO6rb9vaMQRb3+m+l0Y=;
 b=IbwRlm4NYnaqhik2BlTn2b+gsAWrJekF1THsDCGUZWZC++svQ88GQLVF/zl/nzjeV+
 hRu7/2lyu3FmQa7xC8kGwkdZsvndIuWVzgZXtxGZOouyyaGL/khzxn7ka5Sp3AbSlK+J
 Ewk8qM766CLaNRxkHyITUs+4uQDpxaDlMpWPKxapErMGexNIKHjSFWB1hcYiNQzKbXKO
 v+hEWyUJsiyQBcj8SI9lxKNI2LGdTd9JGn0LIMGryCfrZnWVmtgXjjW/1rqWC1SLbbV8
 RY0/LMiS8h7wdeaFIw2fySGeY9saqBO7yM9lO1u8zDh89Mvl3TBv3UQa1R9f0e1WMRTS
 mSJA==
X-Gm-Message-State: APjAAAU0uCipv087VXpoJ7Xe4X52800tzECVJq90oi+h8uo6WSCpeHfr
 pz1DIIDtsxy++ScIV76rxMDYAAfo1coG7T+Y3IoA1Q==
X-Google-Smtp-Source: APXvYqz2w0TBLKJ5CEAxF4m+JVsUilLVrZdb6ptuiuFV6Vgh+Ny0ct4g2+2UD9xUe280fo3q5m+rWGrZmGDIVGyUp1Q=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr4785289oti.91.1566573094769; 
 Fri, 23 Aug 2019 08:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190822135839.32340-1-cohuck@redhat.com>
In-Reply-To: <20190822135839.32340-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 16:11:23 +0100
Message-ID: <CAFEAcA9CvFDYdXNNcFt-KDhCxZ+Wa8kKh3UiA4GErODmvn6XVQ@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PULL 0/7] First batch of s390x changes for 4.2
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 14:58, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit f3b8f18ebf344ab359e8f79f6ed777e740dae77c:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-08-21' into staging (2019-08-22 10:31:21 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190822
>
> for you to fetch changes up to 065fe80fe03ff0f36a0cbebbd2d4b3c05110d96d:
>
>   s390x/mmu: Factor out storage key handling (2019-08-22 14:53:49 +0200)
>
> ----------------------------------------------------------------
> s390x updates:
> - fix a bug in tcg vector handling
> - improved skey handling
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

