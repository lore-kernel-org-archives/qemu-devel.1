Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8585C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A753C2075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTVTzUbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A753C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglu2-0006cZ-Vi
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgltE-0005h3-Fg
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:10:20 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgltD-0005x2-Ar
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:10:20 -0400
Received: by mail-oi1-x242.google.com with SMTP id a137so4469332oii.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cwnRKZH1DnxZRlyWrqvLHghevGQqxa72rg4Vyhzz2JA=;
 b=wTVTzUbHB08O8DI+tfmArh+LpTZs/tXUp2GblqOIeo34ywaQkcs5IJ5UWzRoKddDrV
 n5guqES8Ku6dmM/wcjSptNX9Y/8ZAyXVtpoD27iwZfaefPxRdKsrcN3ua1RH41IV0Yuw
 gpwlr+O7TLKRMxFxgXgMeeBKZddqjbKzoBwk9dhoQY0oekeAay/1ICID7bvXQnOopKm6
 eveLIJ58Yj5dEn79a3u5GVU+Si0qqaZE0HqHmhMgsd5UjrG6785LKfBhXz5EebY8jZpA
 M6V+151tcyhtJPYjK2MkMH6au0+A4hr1czSW7helluzRl4wdQ5WFfIzO2AHz/wMT6GO+
 C6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cwnRKZH1DnxZRlyWrqvLHghevGQqxa72rg4Vyhzz2JA=;
 b=lO1i/Q/db/zcTd/JIuF3wa5vjWy+D9oDR0c+7SnCt/rTGVcTogGgDWFaQOAZrtzavi
 bJjegDlV/FjZSON1BpjtQ+ENdsVqq7JN5uJUNmmHGdleJP8g1E46sP03VFMHC7TkfhHo
 I5NIE1bEwon12AHfMtSWXrATrU/3ixjrFYXFC/8i1ShJwOT8u8VtNTJOGgk3dvA7IjR2
 itBDyUzzxE8l/Imq82Olu0ZyC+3sA7S3VO+msa5lmcjJK/fknA+XzAX17ddxEONg6xdt
 rdVMwxCIAqEzFH2OLSXN4TLi8DoEEM26rMKLothpqByzeaeODUx2CALoX7JqLOBF8tDX
 Bytw==
X-Gm-Message-State: AOAM531ePMilS7goVoWKhTomrWdSsG4HrS9qgdoc9Aiy/Kex7ym8Czaq
 9g/r7X3BhrWhtPe6QqHGBn/Yt19c/5kE+UMNgzZn7w==
X-Google-Smtp-Source: ABdhPJyqox0+kZUy5Y3LkR+exaluXI+xTqSYUWz95fuz5Deff+1pMMlX5oVA4KDc3clCze9qTlbDUf98H7+IDtgs6Ys=
X-Received: by 2002:a54:469a:: with SMTP id k26mr2424796oic.163.1591261818065; 
 Thu, 04 Jun 2020 02:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
In-Reply-To: <20200603202251.1199170-3-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 10:10:07 +0100
Message-ID: <CAFEAcA-hApgPBn0o44sJW7=WGiLnL0PBhz+1i8MAcxwuxJ=Y=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 21:26, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While reading PCI configuration bytes, a guest may send an
> address towards the end of the configuration space. It may lead
> to an OOB access issue. Assert that 'address + len' is within
> PCI configuration space.

What does the spec say should happen when the guest does this?
Does it depend on the pci controller implementation?

thanks
-- PMM

