Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC3AC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AB12395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Orn7MyRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AB12395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOxM-00030j-8u
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLOwU-0002Va-EW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:57:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLOwS-0001T4-Ta
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:57:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id d4so3046223wmd.5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZlOuwbtOWVJiGOliwwdL5ozUyfgjCDoic0NbitpJN4M=;
 b=Orn7MyRiv/6VvOsWoaS3wXpVS+NU2+kuEsYUkGCsv/0Co4gojhy1wlQZqt9O4ze6G2
 3iWaNZnsggeQoOF80JTO4NWzTPUmJKvkAT9SH3ExVmVTIVfV9eM3UZHNdJgvvDSEFz7X
 OB5UPBa+tEsobbaQGWyLHGwIwas096vn6UEw9kTRVtlG0zkLGgcxamAf8AvlqGtoG/bV
 llN+KJdrLxRnEJym2LnHJ/Ki72irMSQj+DdBpoSGceL4Cgrtp/Ufr/iBPbE6u3TXOfq+
 eRM/5uGY/y3FQs9mq9PyoKEvLNkPoiJ94/5dOO3zWD8JrtNCLYaFO++XijTGxDSim58N
 TMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZlOuwbtOWVJiGOliwwdL5ozUyfgjCDoic0NbitpJN4M=;
 b=OenhDAoW6N/vfz8M5tq+OxPM9a/W2zlBSoV2H1asSL3my1E+r1ihJYOl0afPcTjPV0
 7PHNtOb/oFGHRVO1iKbeBxfdH/s861xavg/N7NM4+wT4sGrGebvtgH4YfrL5qAx3Pp9S
 38mS7a6ZJnMs+A4XmTcTR0W93rZXdF56b03FRHJA7Jv/jRdrnGMr73q4RdmowhtUII3D
 xTCZM9IxaXBPU/hVCxiqx0j9/vBYKkx9lBFc7051QFu6nx9EVS3UiCqRTprwUF0T9ZPu
 LyvoeA8fPYQVw1k+eJXtXsvo4wkCBVHHY5m7X1fBgo/2L9TpE4iPb4YruSEWnnkon4gh
 HFww==
X-Gm-Message-State: AOAM533eQzXnBbSq0DQmhIhdVS1BGM4WBvcotZEXI5zAiNAd76gAMS+M
 4oScSgR7j/Ung8l29pwIKi23mn7H1ZykOiJe+D5ygw==
X-Google-Smtp-Source: ABdhPJyac0HTau6QQcXGnT1rPC/QgG39CrOxeSdyy2zZDksctfpJANtzV6jEPkpnEO4v7N7Djr2Izw7TcW8BXycTPpk=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr4129375wmf.20.1600945051051; 
 Thu, 24 Sep 2020 03:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-6-jusual@redhat.com>
In-Reply-To: <20200924070013.165026-6-jusual@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 24 Sep 2020 16:27:19 +0530
Message-ID: <CAARzgwzq3mTXS9ESeHP0JCOUD=9Xfa6W+R5Q76QFvbZ0cj4yNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/7] bios-tables-test: Allow changes in DSDT ACPI
 tables
To: Julia Suvorova <jusual@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 12:30 PM Julia Suvorova <jusual@redhat.com> wrote:
>
> All DSDT Q35 tables will be modified because ACPI hot-plug is enabled
> by default.
>
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
Acked-by: Ani Sinha <ani@anisinha.ca>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..84f56b14db 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,11 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT",
> +"tests/data/acpi/q35/DSDT.tis",
> +"tests/data/acpi/q35/DSDT.bridge",
> +"tests/data/acpi/q35/DSDT.mmio64",
> +"tests/data/acpi/q35/DSDT.ipmibt",
> +"tests/data/acpi/q35/DSDT.cphp",
> +"tests/data/acpi/q35/DSDT.memhp",
> +"tests/data/acpi/q35/DSDT.acpihmat",
> +"tests/data/acpi/q35/DSDT.numamem",
> +"tests/data/acpi/q35/DSDT.dimmpxm",
> --
> 2.25.4
>

