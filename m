Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B8EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8614E20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjHF/AuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8614E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngJZ-00079N-Rg
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jngJ0-0006bW-0k
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:37:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jngIy-00006z-GF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:37:29 -0400
Received: by mail-ot1-x343.google.com with SMTP id n6so16106164otl.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GNpCe9Xf5Z5FWvCiL4N3Vt3CrcsQ8Z3kIRn68Z5fG9k=;
 b=VjHF/AuUJs6qCVCVzKDfaDuwyNRhxExM3TUfmvc/v9+NeTVg+d51oGnzayhD2JEPZq
 sdMynLo2KvwyeqPxUYsTBo+cEKKD3fOogLV8WRflAu6+oJkE+zofDUHzGi4UA9ZsZpev
 +e9qcano7Yqs0RL8yMxd/2Iuz8Cy2TCk5tzbbf+xhzdnF8vWnuJKDqBHIXBS2E2gCAn6
 S2mDg2pAHrpLDjOiTRbyOjO3sjy4eDai6U8NAD9qsT2ZDsF98wguGXaVpFGGOaU8z8GQ
 MTifx3kYAufiYcoaq5QcIyUw4j1Pt9X8Q7DwGEEJJmuWtg1Wbwn4bwPSM/0vSEl0jCP1
 no0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GNpCe9Xf5Z5FWvCiL4N3Vt3CrcsQ8Z3kIRn68Z5fG9k=;
 b=Dhm8BJhVJTmdBIyYI077i8AhsN6NZXaKAKP8GgPe7krlchHjZm+KtRoIVmlAp/0N7e
 2WXH3wmI9G9/WU9LwDjPbDdTG6ThjftiYjNsANVIPTqvvuB/UYHR83o3p+eu2L5D/avC
 IA9SRRlP82hacBW/Dkq+Nym4Xj5XKPHX0nDICCHRV87YkQ73hYynnNmiYYA0tzJZA/Vp
 LL7w/ifKSnJdW/Stb0QHXfnhnVyfUlaXzpPgxMXaLxt/1dTZMSG9m0gbrNteRfnzIeVD
 jHzNLVLy2WVteb5OcCt2ahPmDvjaryPjGiOJndgiGPAvnVQtBeojirGDg37g3R3Q9pAK
 bWrg==
X-Gm-Message-State: AOAM530x0I7wby6b1ADWUAAI+MOZcDHlfutmEnwjdwJezrSYh3JRTif2
 DFVlxESHUPJY5Z0f3faz2o0O2lKU1eZK+LllCq9riSVOX7I=
X-Google-Smtp-Source: ABdhPJw8JCvGJCDSWW6g2jtVCM3CCPAA3IN9OTKM6VaitPB4wgDKD0HG139hStH4wQKFfQOgm6E5vHHBX2Uprhkv2uI=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr3586650oth.135.1592908647266; 
 Tue, 23 Jun 2020 03:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200622124157.20360-1-shameerali.kolothum.thodi@huawei.com>
 <b4d4a654-3d45-f7d7-1009-8e9f055f88d4@redhat.com>
In-Reply-To: <b4d4a654-3d45-f7d7-1009-8e9f055f88d4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 11:37:16 +0100
Message-ID: <CAFEAcA88dn8M5DSjr7WwTVEJGvN5-dKe8kiFCX06M6nruPJvQw@mail.gmail.com>
Subject: Re: [PATCH v4] arm/virt: Add memory hot remove support
To: Auger Eric <eric.auger@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Linuxarm <linuxarm@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 prime.zeng@hisilicon.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 11:15, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Shameer,
>
> On 6/22/20 2:41 PM, Shameer Kolothum wrote:
> > This adds support for memory(pc-dimm) hot remove on arm/virt that
> > uses acpi ged device.
> >
> > NVDIMM hot removal is not yet supported.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Works fine for me when passing "movable_node" in the guest kernel
> params. I am able to hotplug and hotremove PCDIMM slots several times
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks for the review, Eric.

Applied to target-arm.next, thanks.

-- PMM

