Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBBCC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FC52376F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inGnlyFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FC52376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLi4-0001q6-Pg
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLLgr-0001E8-5x
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLLgn-0008QA-Gi
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600932552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIfN4gb2baP3m9gO2qf2nmPpD5fGv+SmwP5XcglDPMY=;
 b=inGnlyFjxjo41pnanV+FP3bcwRG4MVOSryTIt7Ri/NoeWIsBj9kBQy56hF5SAelxZlwiwY
 +1A1ZthF0jHQXjhBp1skFRPhSvksT1whtVWlzd39dMV4WggFLTc2L55/G/ygGtRpiiwPhe
 5UUY2OAPtOshi1zYSvsJypWhhOVIy3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-jlzykvrQOD2CxZndBPGUlg-1; Thu, 24 Sep 2020 03:29:08 -0400
X-MC-Unique: jlzykvrQOD2CxZndBPGUlg-1
Received: by mail-wm1-f72.google.com with SMTP id c200so887052wmd.5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 00:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DIfN4gb2baP3m9gO2qf2nmPpD5fGv+SmwP5XcglDPMY=;
 b=Tg0uJfQ5tCI4rfdJWrWTyqIN0BAyLXvcySNd1dA6NEFXobqjLjYooGdirD4/jpcFn9
 G8Ue1RX5ZMH4P3nGBsk8O/K0hDZc+fDSRyi7NBTBsQQRc7T8V0OC45kKSO7wFnGlqkbD
 LHCPxNj1PFjvQWYXbC1ZwyNDs9prw18VVCsBlzdj+fWA6PFVFW1PMPP/x08z0ERRJT+P
 pUbPbN/3Fv4S9amsm2kl+FDZq2A8Hp+QUdHCn8xJE/1JNtbk5O7N2zCliCaAuTGa+Y7L
 FKE7kmmhENZCZzexu0QikKJApsiM8xgWG/9isA9H/o33x4sOt5Guq5PzXFXdTyHxigps
 mZeg==
X-Gm-Message-State: AOAM531sdojUUVqEh2h/X4D47xZ6DgF5Z66KgKwP+hZEZWDp/Gf7bQE+
 Iu24aCXc3D7Fv5hi0TRdy/725ZBJ/WW1WwUqxwG6G35NTQPjE0w/L2WEgM5lbs2RLFrSzlzNIkr
 HdDa9Z1TWdHXLU3k=
X-Received: by 2002:adf:e488:: with SMTP id i8mr3747398wrm.116.1600932547320; 
 Thu, 24 Sep 2020 00:29:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlWUlzsb55rWRq2kuQ7E5VkqDoGpYenGxxeQfxzO2XbF/qDUUqg4nkqqxNBlis1sHKKAaTBg==
X-Received: by 2002:adf:e488:: with SMTP id i8mr3747365wrm.116.1600932547117; 
 Thu, 24 Sep 2020 00:29:07 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id a15sm2689627wrn.3.2020.09.24.00.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 00:29:06 -0700 (PDT)
Date: Thu, 24 Sep 2020 03:29:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 00/11] microvm: add pcie support
Message-ID: <20200924032838-mutt-send-email-mst@kernel.org>
References: <20200924062734.22978-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924062734.22978-1-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 08:27:23AM +0200, Gerd Hoffmann wrote:
> v2:
>  - move aml generator to gpex and have arm virt + microvm share it.
>  - add 64bit window.
>  - add testcase.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

which tree is this for? Yours?


> Gerd Hoffmann (11):
>   move MemMapEntry
>   acpi: add acpi_dsdt_add_gpex
>   arm: use acpi_dsdt_add_gpex
>   microvm: add irq table
>   microvm: add pcie support
>   microvm/pcie: add 64bit mmio window
>   tests/acpi: allow updates for expected data files
>   tests/acpi: factor out common microvm test setup
>   tests/acpi: add microvm pcie test
>   acpi/gpex: no reason to use a method for _CRS
>   tests/acpi: update expected data files
> 
>  include/exec/hwaddr.h             |   5 +
>  include/hw/arm/virt.h             |   5 -
>  include/hw/i386/microvm.h         |  32 ++++++
>  include/hw/pci-host/gpex.h        |  11 ++
>  hw/arm/sbsa-ref.c                 |   5 -
>  hw/arm/virt-acpi-build.c          | 175 ++---------------------------
>  hw/i386/acpi-microvm.c            |  12 ++
>  hw/i386/microvm.c                 |  91 +++++++++++++++
>  hw/pci-host/gpex-acpi.c           | 177 ++++++++++++++++++++++++++++++
>  tests/qtest/bios-tables-test.c    |  27 ++++-
>  hw/i386/Kconfig                   |   1 +
>  hw/pci-host/meson.build           |   1 +
>  tests/data/acpi/microvm/DSDT.pcie | Bin 0 -> 3023 bytes
>  tests/data/acpi/virt/DSDT         | Bin 5200 -> 5196 bytes
>  tests/data/acpi/virt/DSDT.memhp   | Bin 6561 -> 6557 bytes
>  tests/data/acpi/virt/DSDT.numamem | Bin 5200 -> 5196 bytes
>  16 files changed, 361 insertions(+), 181 deletions(-)
>  create mode 100644 hw/pci-host/gpex-acpi.c
>  create mode 100644 tests/data/acpi/microvm/DSDT.pcie
> 
> -- 
> 2.27.0
> 


