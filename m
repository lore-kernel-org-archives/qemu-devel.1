Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ACFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE352082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FusXl2te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE352082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtqSW-0001dG-IF
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 06:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqRd-0000zr-AE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:39:53 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqRb-0004zb-KD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:39:52 -0400
Received: by mail-oi1-x242.google.com with SMTP id t198so4407852oie.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eP8LHJiBGTJ/JvaKaJ9BSg5MWkkRp2VWgwzipAVH3C4=;
 b=FusXl2tec8llWzKj06NLGhAaClK5GtqoPHE9Iz8myUn88qSNed/7xA+pfHfE8csbxb
 QsPrgqgLj6Fj684ng6f8bcyYu4vF6B5Zc5DMaUOpoSX5p+MGr65nuxyU7TgSq0skv3Oh
 yQb/OMMiRh2RT491aKIE/Lqg0acCH9B7vQ/53us0QgoZiDWRBFbKrHlbct2pwFOHSWzb
 dQso5t1JJMN/0CumpupWc+I5ng5rKaw9tO+fFXue3wOpRqo4g5p9FU0zBedjU4oVKPJp
 0OzGG5IjVKulYuF8vDvZ5V1pK1p9glLNVvQPY+sSLJXB5sePFdMYnZPHbawxhTEn4OBv
 uULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eP8LHJiBGTJ/JvaKaJ9BSg5MWkkRp2VWgwzipAVH3C4=;
 b=neLpsRP4b0Db4tllfXt/4bd6KpJNMhIlXK8/NQ512EwIhAzXRqWV1XwCk2kBtDHuxx
 DbxZZMERy1Iw+X2o25//pIL+FJ5PJSW4F6CBlKwq3cINva+Ms8zdUiKBKGvRXlVkibDS
 5RiCvp+fZPvLiJuCK9zjPtiumug1xrKDBg278ed9BQGPfUgMBsVNx7BZXY5D/snjUCDO
 3keBCwGuBK5g+bou7BJNuHi2WQwpl/6OmCAejUOG806IgzVfvnVAvVniKmN5eUY6d3sE
 zHSdgbciwM9XRdpYPJUx+qkim8ByXvAg89HMQHQQH4XJrqRrcQ04jeb2mGtftPOCONZD
 D00Q==
X-Gm-Message-State: AOAM530zUDP85sTj75MGcmKVWT+RneW/G5oTvOsLsQZ6YVsA/Nc/uMKP
 Ngr1RiVBWLFzyYcK25V2sGtcoaKlqYlLBJhWMtXLGA==
X-Google-Smtp-Source: ABdhPJx7it7F9IXVoguej7MiyEk/nlipPajomSQgCH/HM4GwjZG+eKdftxzV5ja0LjWZxfUpeWdnVwsaXec/jOIfmWA=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3450899oix.48.1594377590286;
 Fri, 10 Jul 2020 03:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-12-eric.auger@redhat.com>
 <CAFEAcA-zXyzq5ph3U0vFuqRz9=NEq-piw_9gsYbrwg=+g9nbXw@mail.gmail.com>
 <41b72b3d-e0b5-f6b1-69a3-2940246447d7@redhat.com>
In-Reply-To: <41b72b3d-e0b5-f6b1-69a3-2940246447d7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 11:39:38 +0100
Message-ID: <CAFEAcA_7CUEwwHgYTHByzyZYSdubscYPbC--BO+nDgHrSgqeKw@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] hw/arm/smmuv3: Advertise SMMUv3.2 range
 invalidation
To: Auger Eric <eric.auger@redhat.com>
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will@kernel.org>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 11:05, Auger Eric <eric.auger@redhat.com> wrote:
> On 7/10/20 11:47 AM, Peter Maydell wrote:
> > I think that to advertise SMMUv3.2 we would also need to
> > set the IDR3.BBML field to something non-zero. That means
> > we need to analyze our implementation of the caching of page
> > table structures to see if we need to do anything different
> > (per the behaviours and guarantees described in section 3.21.1
> > of the spec).
>
> you're right. I need to further study this feature.
>
> I felt difficult to find out which features are mandatory for a given
> revision number.

Mmm. I ended up just working through all the ID register
fields looking for references to 3.1 or 3.2 in them,
but it's easy to overlook one (I failed to catch
the IDR3.HAD requirement in my initial scan,
for instance :-)).

-- PMM

