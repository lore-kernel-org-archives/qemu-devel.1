Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C7BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E1E21734
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfKpgO8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E1E21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItiY-0005qB-UR
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIthG-00055w-3S
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:11:34 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:46288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIthE-0001oY-BM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:11:33 -0400
Received: by mail-ej1-x634.google.com with SMTP id z23so3128200ejr.13
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hSvFJmJQ34Ur5olB4u/kLjRQNm9e7g59MqLhlIX4XWo=;
 b=HfKpgO8r4g8maOWnNiON3OiuBi/SDfFtaPh4fCp9rzHhwOJdldlKPy07CGWO2BQ+7R
 lAdSsMaLzvNp4cn8RbJ/qw5HfrlAabU/KqAzuk2OjUR8GW9BZ6ZvPk/y7/in2784e32S
 +DGldXmigRtCVNPQqSNm4p3cCFcApdq5eYhv39DhNuw3SRUmSZ1VKBXDmL4VqdCR0d6f
 AHOkSLx27kglF5TPScLwSf/yH9ABQY6hs7DIsEFoXqYpqNTm3uILIqpokDnNXEdzKEdD
 TwJZwmK+Kr+leGbSDTkJCgPwW84qGQmKSJ+Ua55vSR0atE8f66dCSFzewExVjCrVBeba
 ranw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hSvFJmJQ34Ur5olB4u/kLjRQNm9e7g59MqLhlIX4XWo=;
 b=To+14UpLnYpTB0YZyrN1Vvp7Xk2DRZruT+SAoiPn1V1xi4poArQVuQ6w9Qe9b09zx0
 6UQwQ4Kzc757hgcBcEjLSbjVyZwsVhSHG5+zMYKQsYKMeAHlDeNzGrhZZlTH+5qUz8rj
 z0jY6sH1eaTnpW2yVAz4VAY6NggSdY3O5Kh5tAi41ilKrIEcTEVjYFnb/nuiwvKXcgWi
 W+MTFE/4Lu6LD1eHmh412SemRZa3cHvtDq4w9o6nFhlAuYYHVJnCINYktUeZIkPgs6p6
 GwY2PEFbPh2XzTvDTa33NVbqSODZyyxHpzaSnoDs2k7i6Eee9ZTXWLC1QQibhCkcsynz
 Vq4A==
X-Gm-Message-State: AOAM530jdwzjCGRmXL3dWPi+mwp8vC12LZHHRnWePr+e6LdCesIQGmyJ
 6I1/ADJ/S68fS+wn3MLdRqILIf1iVZZb5+9FFG0AqQ==
X-Google-Smtp-Source: ABdhPJxAXYLA8/mbuajfnTCxJn3SMLB7nO0mB+7iSVkY6+4ARrjSqveGjWHtHK0iN7j5GymFiBzJ7V/HQbYZLpnsfr8=
X-Received: by 2002:a17:906:552:: with SMTP id
 k18mr18299431eja.482.1600348290518; 
 Thu, 17 Sep 2020 06:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <1836935.RIYQIvKipu@silver> <20200917093756.GC1568038@redhat.com>
 <8e3f59a3-925e-d89f-2073-6c9654bff75f@redhat.com>
 <2029663.ApTj1TM13Z@silver> <a60c566c-986c-2534-3e8e-6a3ff23b9d00@redhat.com>
In-Reply-To: <a60c566c-986c-2534-3e8e-6a3ff23b9d00@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 14:11:18 +0100
Message-ID: <CAFEAcA8yTpHE2WaBL3B8fbQtetqmH5uXgCudtfHXuYuA+LpavQ@mail.gmail.com>
Subject: Re: QEMU policy for real file tests
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 at 14:04, Thomas Huth <thuth@redhat.com> wrote:
>
> On 17/09/2020 14.06, Christian Schoenebeck wrote:
> [...]
> > Final question: if at some later point one large file needs to be created for
> > some test case, is there some approximate size limit to stay below for not
> > causing issues with free CI cloud services?
>
> FWIW, I know that 4G is already too big for some containers on Travis,
> see commit 178d383f10e15f5e5a7.

Yes. Also "it's sparse" doesn't always help -- eg on OSX there is
no sparse-file support so a 4GB file really does take 4GB even
if it's mostly zeroes...

thanks
-- PMM

