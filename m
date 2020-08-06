Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6150C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A357C23117
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gay2+h1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A357C23117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fRa-00067W-Np
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3fQd-000561-UZ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:55:27 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3fQb-0006Bb-SZ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:55:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so25521529ota.10
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PQju2RyxO1lbrYUXrxcgdWwgDLJPYib9FQfWj5UiMfQ=;
 b=gay2+h1ehcLHXfNO2lflVOXzNHG+CuQovdf93FLzjb7OrS1zhtwOgixDetKUesmWCO
 fDbekmxZAxTEW2CgaDyMLJRspmqO7VznmGddlN6uMQeA+7vtXS0EmJSwcIH+Q+uuV0tB
 uDff8vJW9XE4ILcvq7qjos+q/lpafHnWo3HFomhcSnU9lKnkhRUD+KTggNWM8OH0jDll
 PIknQxTj/QneIUqPv64bPhY7WdcpHnyuRQl8IYV8rhSQ4Jnz3O79/4r8H8KZegV79QBF
 HuAez9LU9WTE7oo0/80Nv/d6dTliWC8FcTgnnw0BfbIIBACL7/9kin8KzJflXoR432R/
 qiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PQju2RyxO1lbrYUXrxcgdWwgDLJPYib9FQfWj5UiMfQ=;
 b=owE1aP0R6ZCp7f+DFuxNoA1Ki/oC+BgdjfhUhQRR8+vv51ABO0WbqlGkk26zQ1syZX
 AbCPsyIWYYTWGBwq6w34Ksg4C0dxHSsj+3x1sDKTIT1lYwwXUt7Vh4N28MkiyBHIAnBW
 4/f69gV5BzaQlQXAjvpvhDaL7Gt39EZKewzm5wIr+o5Qo6wwWToKkAmv1WXV8igq2A5r
 yv3nUl31EuyeQhHXVhqoZ/STweuH+4iOE3s1tmggI14jWLbnFBo/0WzXtcTd3hOi76Ai
 njT8kZt3m8I/QRMWTOvY6C3uyDw0YAugSEASJC6nDWoN1ZYSWfVf1xByY2aOFgQkby2I
 HKKw==
X-Gm-Message-State: AOAM531FyT1p2F9L9RaNuxo+N96iKUZfhW6T08tGamTnLnNlu1cqb93n
 I4Sw0Elo39NBi13PdjMiRGEHHNfrf1rmLqxv0o0dug==
X-Google-Smtp-Source: ABdhPJyJWwWU3PNTfVBJMD+ju/z3AhNg/waW2mF43v6lTUA8yRl7BsILG6iu47brBY4PORGWrvC6sHCMTN2EpweNr9I=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr7002073otb.91.1596718524844; 
 Thu, 06 Aug 2020 05:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200728150815.11446-1-eric.auger@redhat.com>
 <CAFEAcA9Dh=cNr95ajznpQHCLQ0REFmjSZCTaygGOZEP8vg3swA@mail.gmail.com>
In-Reply-To: <CAFEAcA9Dh=cNr95ajznpQHCLQ0REFmjSZCTaygGOZEP8vg3swA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 13:55:13 +0100
Message-ID: <CAFEAcA8k--w5yvdhX_Cu_sS=KaUEg0KyirZ4=JG8NdGFKGRweQ@mail.gmail.com>
Subject: Re: [PATCH for-5.2 v4 00/11] SMMUv3.2 Range-based TLB Invalidation
 Support
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 14:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 28 Jul 2020 at 16:08, Eric Auger <eric.auger@redhat.com> wrote:
> >
> > SMMU3.2 brings the support of range-based TLB invalidation and
> > level hint. When this feature is supported, the SMMUv3 driver
> > is allowed to send TLB invalidations for a range of IOVAs instead
> > of using page based invalidation.

> I think this is all reviewed now; I've put it on my list
> of series to apply to target-arm.next in once 5.1 is out
> and we reopen the trunk for 5.2.



Applied to target-arm.next for 5.2, thanks.

-- PMM

