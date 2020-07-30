Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A37920829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbk/AU5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A37920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18mf-0003PZ-Vh
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k18m4-0002h0-1Y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:39:08 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k18m1-0007uj-V0
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:39:07 -0400
Received: by mail-oi1-x242.google.com with SMTP id k4so23756396oik.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6bWr4DdkxGZRPzhYMgici00p195qNqidDZzgpfDv1v8=;
 b=qbk/AU5+g61K79+ORD2givsncFdonDZKfl6+WfZttAdC2mOLOFxa9twb95PeMRDKFB
 AfR9txB6knwIdj2ewjfLRYAJTk46bb7yPM4X8r+gFb857ASl6EnxwQ0+RpQIYlijzp8d
 lpNlHdOSWvbWZ89aWM3KwJf5rq4adeR0Q6Jf6ivoArUcYcRTjIaG8B+FqwnifAgyT7xw
 YbvYQoIYcwf5jgV/D2iR2v5wqVtBa7zxxoLhzUeOdl7+EcKqxLcqUmRLqUJwTlebEpBM
 KCInO7w2c00XrQSD6hYbVVSDQ8vrvriad5McKbmlc4pxTDtmtFdNOJqsz9n54yfbM+tl
 hniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6bWr4DdkxGZRPzhYMgici00p195qNqidDZzgpfDv1v8=;
 b=TFAAaTwrOhYmp6dwWTDPY05+MY3xNVh7hkFR3it8LAIzXzxIMD5PmXhb00psalc38h
 rMLLB+zPGLC6SpRY9tE0L21AUgDwLF0KbAFATLu2+jOzNWSaqveg7rpPQaw1HiGGWAZs
 YsD2qjAEhqXpHEu611Cj8Ni+oxFeYkaiOkUy4PVtHpj7FmCZOA76AoJib/Ux7qS0CP25
 yiDuzgY62sL96EWZIUDRS0k41y6KVMTBcNw9JYRK4VS++inCJePgV72n1dM8nuxh9KV9
 3yN7siL3JQZvDt4PEy3NDeRC4VySgD4YOB5VCBzTeTk2wfU/cz/IxKQrl0YJCJTTHFH2
 mVfA==
X-Gm-Message-State: AOAM533eiIJFwBHtfJn1XTnKbYSRxFC9dv/x5vfE7rRAWujFshYWVZU9
 sS5PMJYh+dwgsT1GzqtUsP3z4btpLKgGbr/nE6TSgw==
X-Google-Smtp-Source: ABdhPJzyCrMNtIYBY5bjDlCnNcu1k/754rqhhSgbtxARpGDffib9SnHWNzMZHalQH7X2acmB2OJRIbLwOpAJVfVTIP8=
X-Received: by 2002:aca:48d8:: with SMTP id v207mr4628338oia.48.1596116344513; 
 Thu, 30 Jul 2020 06:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200728150815.11446-1-eric.auger@redhat.com>
 <20200728150815.11446-6-eric.auger@redhat.com>
In-Reply-To: <20200728150815.11446-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 14:38:53 +0100
Message-ID: <CAFEAcA-gMh43545mnHRoRLuAV63o3r-GWFBF+zYZfd4apfw_mQ@mail.gmail.com>
Subject: Re: [PATCH for-5.2 v4 05/11] hw/arm/smmu-common: Manage IOTLB block
 entries
To: Eric Auger <eric.auger@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 28 Jul 2020 at 16:09, Eric Auger <eric.auger@redhat.com> wrote:
>
> At the moment each entry in the IOTLB corresponds to a page sized
> mapping (4K, 16K or 64K), even if the page belongs to a mapped
> block. In case of block mapping this unefficiently consumes IOTLB
> entries.
>
> Change the value of the entry so that it reflects the actual
> mapping it belongs to (block or page start address and size).
>
> Also the level/tg of the entry is encoded in the key. In subsequent
> patches we will enable range invalidation. This latter is able
> to provide the level/tg of the entry.
>
> Encoding the level/tg directly in the key will allow to invalidate
> using g_hash_table_remove() when num_pages equals to 1.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v3 -> v4:
> - also use the tg field when computing the hash
> - in the key equal function, compare the fields instead of
>   using memcmp()
> - fixed a couple of indents
> - added Peter's R-b

You say that, but you didn't :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

