Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B839AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B6A2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phzvQD8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B6A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYr0-00026U-9a
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYqF-0000rw-8x
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:52:07 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:34658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYqD-0006YM-Ja
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:52:06 -0400
Received: by mail-oi1-x236.google.com with SMTP id e4so2277676oib.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9VDV/TJLw1Ag1YFoH4s8Zw2nQn4IhUka1tAdHuEiiqo=;
 b=phzvQD8uVK5l4teSCsbSNnX6zVK6sa3e7dkWE6b0joeOTKiier0XUcJF1at3ItSdbj
 YnPOwSD8jZooogA1I0Rd2qvBk9pACU4guBvz+WYDZ+6idJWIq5aLbkuFQtwEy4Ze1hxc
 V5ohPhDLZCfu10FLut0Zd6I8DNZVRcVDRbkv8hZR7N+QRIgrshnNOvYdYHzrJ7i4guao
 +/xRWLpojPwtLReXxGEnP4h6b0RdCgnsyaJ98GTCJm9q9d44CxybrrlFbvaZJEJqlFii
 9ZIUjEF9Tbe4+ZXARh5jQvHMso9rR5E0kqD9AkCISoCcYO02ZvLIL8iPzUjHdBBchLqq
 jpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9VDV/TJLw1Ag1YFoH4s8Zw2nQn4IhUka1tAdHuEiiqo=;
 b=iwXwv2F2iyMCtJ5NCFk6WZ/ASgjMpPACPTjPekuqMRrZhUv11Rt0PR4DsUGb0AMwVL
 i1xHJfF6X1rbch5B4lyMPriaZPh/g50wBD7gPjB/ZH1BmSIhX/MLV3zducqikLYo4axn
 8UU6DO0fvVwgPAW5PKjeEtEiTK6iq/yBMJA9J9cX1dUTvYCxQBwbOLL9LApm08zjjmBT
 WVWW0v9OfgAll1qhtGZctaJsgFlj/Q0Rvw8Q4CBXXIeUoK9mN2MXdCGa0Riv+TT86+Xf
 oXaZlnJnCTCFbXrkgICVqS6KLwmMaaI9ZbtJYC+bE8fwo4aiL1xSCt2zayiC+3E9duYS
 FD1A==
X-Gm-Message-State: AOAM532cW1bblC46LXbr6/WLptNT8wZAWiiGEggrdhYdNV7KlrkG9j6T
 d9amBv7Kea185WQhCW5h9r2ynI9hxoCtuOe83Q49yA==
X-Google-Smtp-Source: ABdhPJyc/JmrsJfjfL2inDN70flLKvIuE/0a//f2o/4XSDTP5oMcjcsHrJVveHmMfnGAOn3ZDHQc6rIlkPf2Hwe+yUI=
X-Received: by 2002:aca:1706:: with SMTP id j6mr601243oii.146.1594309924383;
 Thu, 09 Jul 2020 08:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
 <2666aec2-9872-6af6-7705-d7ce553f611c@redhat.com>
 <20200709152630.GW3753300@redhat.com>
 <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
 <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
 <874kqgn0vj.fsf@linaro.org>
In-Reply-To: <874kqgn0vj.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:51:53 +0100
Message-ID: <CAFEAcA_nk_EjsR59BGkBzYo_Gvkuqi_3AyODOxBm1Ec2gfxKww@mail.gmail.com>
Subject: Re: Is VXHS actually maintained?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 ashmit602@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 16:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> That looks more like it got missed in a clean-up series because we don't
> have coverage in our typical builds and CI?

Yes, very likely. But there's no point in fixing and then adding CI
for a config that our users have demonstrated that they do not use;
better to just remove it.

thanks
-- PMM

