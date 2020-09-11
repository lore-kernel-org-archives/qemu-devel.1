Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE17221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Ie8RIWbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE17221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlen-0006MF-A1
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGleD-0005lC-Mc
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:11:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGleC-00063p-8W
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:11:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so12026122wrx.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m+GYAkS9v7wtHU4/AtOXIlK3Nf0QnbHXjzkHCt28+eE=;
 b=Ie8RIWbQ9nXHaJmKCBJBjByYX708FVSoJkwQqAb6wIxG64+I5xzrie1g/temtyhVfY
 cB9d9oOAwHnJBQzZi8Uoq999NH3mmtqWWeeIRHmJBh6kI8QyC5GMRf2ycmsQz9Ww7Oma
 2AxFehfDBCqrS9xsLd4tij0AuaZ7t+dJ0ZZjkF+8D0EAq6b3SKn/cnSFV++9x0yNowiu
 cI1+vnetdGwUPo+BJZNDiT2wRv6FVndDfhJZVzirVr0d2nYAxT6qMPLR73MnlCF/jWFw
 NxXDyLWoRIfUcvQNZj+7fitgdVhEl9zTMEK/GT7DA5Lp/iZ3AV+ilwo08JDcwF0ohK2w
 7Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m+GYAkS9v7wtHU4/AtOXIlK3Nf0QnbHXjzkHCt28+eE=;
 b=YIlZ5+a71q5aJuaF994dADAINrKkiK6SVfFw9j0re+sMDgMxglS/GSZR0jxbLF1dB3
 YydKS1vveTLNyVIHOxiEKtNJCjolJ40QNzyxHhlop5XIrb1Tx+o76vwHvXu/TBEzKSb7
 m6EKdV/MOpnqFfwLX19ikuotYN7v+rOgxqO6sQx6Wv9O5ShBS5VNgVkIGFVMf0WY1nnh
 89eoHPse6t4oxDdvKK24WUbg/t1qsHpNcXgRx9nUanx23c6QSZNoA0OTidMkqaPtCkKf
 g448Q2Y+CFV+J9ieHy5NGwQNdrHsTMG2qba8VEJ/TsA+fIaR0Iv0UT93Kf9/uFd8rIjs
 nBFg==
X-Gm-Message-State: AOAM532khM2z5xQuVgrKPxJMZdZ6qSTc7sa1vh2md/CenLRFvFeIhN6+
 b3RGyn7KMD8XybH1ET4bOnM5nhHCQPXzHzdOR9dyJg==
X-Google-Smtp-Source: ABdhPJweR4G3/+d0rdsbAIsnwz/JA+W1Alsb2QJ/OwX7f8TkV3eFhvCOHiQOHoe0gpAwwhYEDEirLnTSPdgbGEYAd8w=
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr2603279wrm.291.1599840694425; 
 Fri, 11 Sep 2020 09:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200905103520.12626-1-ani@anisinha.ca>
 <20200911120548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200911120548-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 11 Sep 2020 21:41:23 +0530
Message-ID: <CAARzgwz9XkQQ=9t0bMp4qf=hMa+6Bb9MHtsffKED_aOTwHfvtQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] unit tests for change 'do not add hotplug related
 amls for cold plugged bridges'
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 9:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>
> I am not sure why, but the expected files did not match for me.
>
> I dropped these for now:
>
> tests/acpi: add a new ACPI table in order to test root pci hotplug on/off
> tests/acpi: add a new unit test to test hotplug off/on feature on the root pci bus
> tests/acpi: document addition of table DSDT.roothp for unit testing root pci hotplug on/off

This was already reviewed by Igor.

> tests/acpi: add newly added acpi DSDT table blob for pci bridge hotplug flag
> tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag
> tests/acpi: list added acpi table binary file for pci bridge hotplug test
>

I will double check this one.

> I suspect you have another change in there.
>
> Pls check and post a single series with all these tests.
>
> --
> MST
>

