Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC502C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF672076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clPC1D3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF672076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWdC-0005Ng-Nr
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEWca-0004t5-Mu
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEWcZ-0005Fc-PQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:12:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEWcZ-0005Aw-IW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:12:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id k26so25112424otr.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5hvrnbjfCybmHx4wVyAh+W03c3dhkl1uw+Zrvs/s25o=;
 b=clPC1D3/PZTBksxqd/8p2Liv835eM0uYYqNpQiTIuUmFgInwrduaVfOQtV2D6q0jwB
 omwIFOL3Z9j5sUngwvw6LCWYw+PzcOXahVDQH2HX0gGIB7QLZB/gdrmrLC3SjdgyYQ3y
 nnmu+BDNdmZxU4wl6K8J2s/LrU7rCOMY0dt+jbZhAZr+wIBaWEdrATKpY2GF1o0o41BI
 BY4G3n7u/QE/DUhI99Uf1x2AirxehIOObJhNAB26/ew/kt4+VwCw1X7hA8inZVFTkOa5
 6VxlzeBv+ZF4flRYMQb+WgQc761hj1cjcLeWFEp4+guOZoglGidV27kZBqGhcVdalJ/C
 /unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5hvrnbjfCybmHx4wVyAh+W03c3dhkl1uw+Zrvs/s25o=;
 b=G7H+vcWyK6MsAZ5yBzz9LO3Uw1WzYgKv4ilS5VdkpgkIDr2JzastUMl7nfh7FV78Kj
 /tOf/fxnsrNaUakmUMhF99kBOWq+cp92yjvbjcqTGtF0OCRNVOh4GTM6cDZIMK/S+Owl
 W94Za3Bx2FGpZUOhFRzt3P/p5xCJCwAfmK1V1HiyWL09Xl0m2soU4YBS0tsmirCz4vwl
 xYQSCHPN5YpsoIX4r4o1/kAr6ORb9uQWu+W1txMcaHkyvi+PWX3Z/+1hJ9aPs8F6FGSH
 bSrHyPqM07HENDh1zBHDBK/2kcCLSB0/XjZBR6MXhmtFWG8MYIZEW4gZ1xYBAOUlwxLz
 2Mzg==
X-Gm-Message-State: ANhLgQ23AFQSkjNH+8nHDa+DfQbL05Q94bhkG1As24QEzhVzos2vhMFS
 /w39VXm7V6JqoQOAKJidi8etDIqsco5G06tl12E2IQ==
X-Google-Smtp-Source: ADFU+vvieniM5Qs5+dE48WrmrhQ2E6eJx0G2bGYowRDlx1cNiqBOHcFhJAnTmYsCZP+4u32t1jBqf/4Cl3YeYPlv+VM=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr3370445otk.232.1584529942676; 
 Wed, 18 Mar 2020 04:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200318103940.1169-1-cohuck@redhat.com>
In-Reply-To: <20200318103940.1169-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2020 11:12:11 +0000
Message-ID: <CAFEAcA_6SBf61GpVVMc6m_zQHbtr9HUfiwP00wKjartH70k2tA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: create/move s390x documentation
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 10:39, Cornelia Huck <cohuck@redhat.com> wrote:
>
> Create a subdirectory for s390x under docs/system/ and move the
> existing vfio-ap documentation there.
>
> Create an initial document describing s390x system emulation.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> Mostly an initial version so that Janosch can base his protected virt
> documentation on something; there's room for more here :)
>
> If this looks good, I'll queue it on my s390-next branch for 5.1.

I would be happy to take documentation cleanups like this
for 5.0 during the early to mid part of freeze.

thanks
-- PMM

