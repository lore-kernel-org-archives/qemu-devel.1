Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC87C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8942220663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RX3WaqbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8942220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIZF-0002uh-Ro
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqIWn-0000pn-8m
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:50:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqIWl-0005cE-GD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:50:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id w17so17169298oie.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6lB44BMNpK9yW8Es4rQx+p4Y7as+yKp6SJ+BkG8X7iY=;
 b=RX3WaqbWydL5FNPuV7InT6pPVgLKx/65Vl/Oe0ds712OVeK1RjoLqonmZbbavMFpv8
 N8LTsIcF0LVa6aefTDnldn6NWo9mvnZm0gN3o4opmO6DhEiQSyddHokgxYYAmtlIUG9Z
 d1JZb0hB7RIqns4Ep+MvKw7y1AbRyn7xnlT75UX807MRgEvI+m2NDLjluAsP0LVMPj1+
 V//nq33X/Yadnp0A+EiJYj5/Y9/w30iL/rVr9/tZUfdJ8+Rg655yVi0Z9hgD9fln8+5t
 xsQjpTsibP8Lo+jcuwX+dZWxyKpSDIBE/DBZNzBNxkKWr1sy83UmfEmhaQIbJPYrG+56
 fD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6lB44BMNpK9yW8Es4rQx+p4Y7as+yKp6SJ+BkG8X7iY=;
 b=NkkmpJeO/Fym7wrPTyz3j+FdKplvG3mz11Xl1iHPNBM93fERd60hbXhWJSSZoRGhVo
 YIOLRukPrIWZIPZ6x1dQOvwYXOYle2lZYiUG9ACsezfZ1eRgQVYN0xIAsRULaX+FQf7i
 w1uhKe6lpogtIE0u37n/1QL2H8Lg3i9gwtSkthdiX0lUkBZ7HpYEBpxD78aBuRfhsckL
 JWhl9ZUOi8AFyTYJ6GAsRUdLId1NiItvEsCMbAuDcfoMkwkVKG4qFjHgtANLnchCRFQa
 dVZULBLWJbrmHT69GQMAHjVGp1zlcmcTJ2gtH07qeojDJPKdeiEC5QG5lAX6hqkkUiEP
 XVrg==
X-Gm-Message-State: AOAM533JE++cScmiYnNuxXJgbVeV0VtMZ87T7LVKPOEGbFgzP/QoqLAr
 EcBtAK3DdncdhLfXkYEzpMcZOnyvM07KnfCQht+eKg==
X-Google-Smtp-Source: ABdhPJyWSWsS8+b6rXEauoiOwSHvLSg+Nc+gaABlL0aOQBa4QQXpL5nzIFzuMBcA2mTr6VzdMtGvqOJ0+brW0vq3CVE=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr10062926oib.163.1593532230034; 
 Tue, 30 Jun 2020 08:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-7-eric.auger@redhat.com>
 <CAFEAcA9FZV=jSk_9aJ_tHy=KLy+YrTFNoiqvCv7BMs0dWrHWFA@mail.gmail.com>
 <db6d92ba-2716-40df-54d3-84fb51ab3ad3@redhat.com>
In-Reply-To: <db6d92ba-2716-40df-54d3-84fb51ab3ad3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jun 2020 16:50:18 +0100
Message-ID: <CAFEAcA8ez0ycijFSZrVA3haaoKGho2Q2gQR=cDiiAm7S=-t6OQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 6/9] hw/arm/smmu-common: Manage IOTLB block entries
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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

On Fri, 26 Jun 2020 at 14:53, Auger Eric <eric.auger@redhat.com> wrote:
> On 6/25/20 5:30 PM, Peter Maydell wrote:
> > Rather than looping around doing multiple hash table lookups like
> > this, why not just avoid including the tg and level in the
> > key equality test?
> >
> > If I understand the range-based-invalidation feature correctly,
> > the only time we care about the TG/LVL is if we're processing
> > an invalidate-range command that specifies them. But in that
> > case there should never be multiple entries in the bs->iotlb
> > with the same iova, so we can just check whether the entry
> > matches the requested TG/LVL once we've pulled it out of the
> > hash table. (Or we could architecturally validly just blow
> > it away regardless of requested TG/LVL -- they are only hints,
> > not required-to-match.)
>
> This change could have been done independently on the RIL feature. As we
> now put block entries in the IOTLB , when we look for an iova
> translation, the IOVA can be mapped using different block sizes or using
> page entries. So we start looking at blocks of the bigger size (entry
> level) downto the page, for instance 4TB/512MB/64KB. We cannot know
> which block and size the address belongs to.

Yes, but we wouldn't need to care which TG and LVL the
address belongs to if we didn't put them into
the key, would we? I'm probably missing something here, but
just because the hardware might want to use the hints in
the invalidation-command about TG and LVL doesn't inherently
mean QEMU is most efficient if it cares about the hints.

thanks
-- PMM

