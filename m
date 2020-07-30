Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902C1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CA720829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZHBX+tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CA720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18ne-0004UI-LY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k18mr-0003ip-1F
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:39:57 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k18mo-0007yh-Hy
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:39:56 -0400
Received: by mail-oi1-x244.google.com with SMTP id h3so155148oie.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hdyRaw+MpaZ1o/hv+4EuxaYQmnmMM0DvdREl5n2wCGQ=;
 b=xZHBX+tv4T2K5aDn2kS15RGDFqJmFBhMgv2ThCzxcJHpRz2y2Sl3O9M83Uyr5RvnrC
 RKEl5gEn4O/he2iYb4lhvyMht3Po0jhRlRvrL6x6D1PeNKoNMKIyFcLtsjl3aRT5I49b
 QLivo3gecmT7fw+mrRhkt50JORu3Opf07yhevWWsBpwE5TCHm44mZvcwuD/5b3yNrlxB
 +n+9xzwUJG8TWK6rfC1kpGP9knXA1Q5ucNsQxklwLAch81a8JLhjouIdwhXwZaym9faD
 wK99ZT84vCAgRo5Y/hnsXD8XYwRirbxih2r6mER3yIxwUdR23r7I1CdXDr0G0rVh8RRe
 hV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hdyRaw+MpaZ1o/hv+4EuxaYQmnmMM0DvdREl5n2wCGQ=;
 b=Nev00d86GdU67eVAPW+vtR+zgr11ZL3c10NI2xehEdJaVNQZxDJQwScG/rz5bHrb6T
 sf6Bg0vwoy0meV4+sZSozzelL6hh84Chij6dcnGc+3jelATn2xFJDDEpb9utFzT5eC8h
 oFD70U+z1GHAJ+Zoh6rxOAsD62NEwgQIRh8QnCFmfrRYM8T3o0WGmeA9uSZawsu5h2jH
 yAFL6y7nlF4Rgx3KzkI4v+wf13HAN4W6se4ObEzmL2hFGRbp8jb28GUlGQDWBXg10oEt
 htTW3NEBl6vOej1TLl6kEoGDBTD+KjNgVIKHS1JT7py8/CrMtj3P1pZnlrptn0nobt5W
 PntA==
X-Gm-Message-State: AOAM531MCKy05dWJIi1xldl2h5k0iNJC1Y9Ip6PojmjL0bAa4ZWPsK1T
 J+5o4E2Sux0Skpzp0sNwwOcyyQV1wKHtVnlorBUSQg==
X-Google-Smtp-Source: ABdhPJw4HOfczgkMJFfzLn6yYwF9GejJoibBGdKXLX7TOguLznpukPzfz4FxYc/yZqs/E626+qaBrTEn4Bb6MfreHps=
X-Received: by 2002:aca:4a96:: with SMTP id
 x144mr11531005oia.163.1596116393306; 
 Thu, 30 Jul 2020 06:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200728150815.11446-1-eric.auger@redhat.com>
In-Reply-To: <20200728150815.11446-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 14:39:42 +0100
Message-ID: <CAFEAcA9Dh=cNr95ajznpQHCLQ0REFmjSZCTaygGOZEP8vg3swA@mail.gmail.com>
Subject: Re: [PATCH for-5.2 v4 00/11] SMMUv3.2 Range-based TLB Invalidation
 Support
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 28 Jul 2020 at 16:08, Eric Auger <eric.auger@redhat.com> wrote:
>
> SMMU3.2 brings the support of range-based TLB invalidation and
> level hint. When this feature is supported, the SMMUv3 driver
> is allowed to send TLB invalidations for a range of IOVAs instead
> of using page based invalidation.
>
> Implementing this feature in the virtual SMMUv3 device is
> mandated for DPDK on guest use case: DPDK uses hugepage
> buffers and guest sends invalidations for blocks. Without
> this feature, a guest invalidation of a block of 1GB for instance
> translates into a storm of page invalidations. Each of them
> is trapped by the VMM and cascaded downto the physical IOMMU.
> This completely stalls the execution. This integration issue
> was initially reported in [1].
>
> Now SMMUv3.2 specifies additional parameters to NH_VA and NH_VAA
> stage 1 invalidation commands so we can support those extensions.
>
> Supporting block mappings in the IOTLB look sensible in terms of
> TLB entry consumption. However looking at virtio/vhost device usage,
> without block mapping and without range invalidation (< 5.7 kernels
> it may be less performant. However for recent guest kernels
> supporting range invalidations [2], the performance should be similar.

I think this is all reviewed now; I've put it on my list
of series to apply to target-arm.next in once 5.1 is out
and we reopen the trunk for 5.2.

thanks
-- PMM

