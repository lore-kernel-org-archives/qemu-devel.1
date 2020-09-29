Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B1BC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2798D21D41
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwUeTjxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2798D21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDxO-0001XS-84
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDuY-00086V-FL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDuU-0007FN-LI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:35:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601379305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9Gw/mCCvGDtFXAvYIB9OON/RW0VJR9vIGjCv4DeDLE=;
 b=KwUeTjxqJn9i+520aus4iaQQjAnvCOMFWqhJyQHL3raacWW12y0YkkKHD9NCwEj10+LNi8
 Rrtdm5AoGVsfTK3m5DLzpUJJEURppmadZ0Z7Yv0FynmXNLaVdUuqlpM4NYZSlLuZP3+4vI
 RW2dAodBiTYAGkYZNfrP2nCladkvr5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-H7q_MeyoN2CAO8FmGAKqQA-1; Tue, 29 Sep 2020 07:35:03 -0400
X-MC-Unique: H7q_MeyoN2CAO8FmGAKqQA-1
Received: by mail-wm1-f69.google.com with SMTP id s24so1604953wmh.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O9Gw/mCCvGDtFXAvYIB9OON/RW0VJR9vIGjCv4DeDLE=;
 b=iRYfwSH9aqyAizY1OHN2lVAq5EzMOhWdamUJ4iMrmptCvYE1WyQbhS34rHLU7SfRjA
 gx9rp3eqOndTS6CaG/U9m479Jjp8AgRzva3oDkRaODPtzS9JRMt7G3Wp77cgevX8tq1m
 Wzf/cYG1V6vgss9eFGnCwoGwCgxjOwkofzq6lqOibZlQCgdNOrbkRHa3Uj6YMnvR9T8n
 FX4d4rbz8NXt6XSmbWG0Pr4OaR1taTROG8KZMTRS2A1A4/rtC0qoZql8Qj6jA8A499MI
 BP9ZKE3XmoRots2Oes1EGlfZoSj7O61B4vWkGxXHb+JCfBolHhIgNXb9JvOB8R9frOT2
 xbqA==
X-Gm-Message-State: AOAM533t5BkZuG8Xr0nTsi38F5PC58K6Lipj39tYElNqWkWjK7GL0j/j
 Z0I6/OcD9/IvoEVoHJYbtjLOrKB2GwhG+RSIN+PvBZVFceqEHLVpsU9tZCxOYY0w2U83gIPxvmC
 719/oFD1XQsAEHqo=
X-Received: by 2002:adf:f890:: with SMTP id u16mr3628019wrp.183.1601379301270; 
 Tue, 29 Sep 2020 04:35:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxtvmAWN4pY0fYaPn0EUbmL3Q01RocC+BhpNDjtC0YL1UWkp85UZ7bDmD6uMKsA+h4w0hngA==
X-Received: by 2002:adf:f890:: with SMTP id u16mr3627990wrp.183.1601379300959; 
 Tue, 29 Sep 2020 04:35:00 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id o4sm5533607wrv.86.2020.09.29.04.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 04:34:59 -0700 (PDT)
Date: Tue, 29 Sep 2020 07:34:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 1/1] tests/acpi: drop unnecessary files
Message-ID: <20200929073247-mutt-send-email-mst@kernel.org>
References: <20200929111255.381871-1-mst@redhat.com>
 <20200929111255.381871-2-mst@redhat.com>
 <8cfaa1ed-a6c5-d286-bb05-421ca3d6d7ed@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8cfaa1ed-a6c5-d286-bb05-421ca3d6d7ed@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 01:27:35PM +0200, Thomas Huth wrote:
> On 29/09/2020 13.13, Michael S. Tsirkin wrote:
> > The last pull added a ton of useless files by mistake.
> > Drop them all.
> > 
> > Fixes: 0ed93f4c05896 ("update golden master DSDT binary table blobs for q35")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  tests/test-qapi-event.c                       |  198 -
> >  tests/test-qmp-introspect.c                   |   58 -
> >  tests/test-qmp-marshal.c                      |  383 --
> >  tests/.vhost-user-test.c.swo                  |  Bin 16384 -> 0 bytes
> >  tests/Makefile.include.orig                   | 1012 -----
> >  tests/Makefile.orig                           |  569 ---
> >  tests/bios-tables-test.c.orig                 |  925 -----
> >  tests/data/acpi/diff-aml.sh                   |    0
> >  tests/data/acpi/disassemle-aml.py             |   21 -
> >  tests/data/acpi/microvm/APIC.dsl              |   56 -
> >  tests/data/acpi/microvm/DSDT.dsl              |  121 -
> >  tests/data/acpi/microvm/FACP.dsl              |  196 -
> >  tests/data/acpi/pc/APIC.acpihmat.dsl          |  112 -
> >  tests/data/acpi/pc/APIC.bridge                |  Bin 120 -> 0 bytes
> >  tests/data/acpi/pc/APIC.bridge.dsl            |  104 -
> >  tests/data/acpi/pc/APIC.cphp.dsl              |  146 -
> >  tests/data/acpi/pc/APIC.dimmpxm.dsl           |  129 -
> >  tests/data/acpi/pc/APIC.dsl                   |  104 -
> >  tests/data/acpi/pc/APIC.hpbridge              |  Bin 120 -> 0 bytes
> >  tests/data/acpi/pc/APIC.ipmikcs               |  Bin 120 -> 0 bytes
> >  tests/data/acpi/pc/APIC.ipmikcs.dsl           |  104 -
> >  tests/data/acpi/pc/APIC.memhp                 |  Bin 120 -> 0 bytes
> >  tests/data/acpi/pc/APIC.memhp.dsl             |  104 -
> >  tests/data/acpi/pc/APIC.numamem               |  Bin 120 -> 0 bytes
> >  tests/data/acpi/pc/APIC.numamem.dsl           |  104 -
> >  tests/data/acpi/pc/APIC.roothp                |  Bin 120 -> 0 bytes
> >  tests/data/acpi/pc/DSDT.acpihmat.dsl          | 1619 --------
> >  tests/data/acpi/pc/DSDT.bridge.dsl            | 1800 ---------
> >  tests/data/acpi/pc/DSDT.cphp.dsl              | 1466 -------
> >  tests/data/acpi/pc/DSDT.dimmpxm.dsl           | 1719 --------
> >  tests/data/acpi/pc/DSDT.dsl                   | 1407 -------
> >  tests/data/acpi/pc/DSDT.ipmikcs.dsl           | 1337 -------
> >  tests/data/acpi/pc/DSDT.memhp.dsl             | 1625 --------
> >  tests/data/acpi/pc/DSDT.numamem.dsl           | 1321 ------
> >  tests/data/acpi/pc/FACP.acpihmat              |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.acpihmat.dsl          |   99 -
> >  tests/data/acpi/pc/FACP.bridge                |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.bridge.dsl            |   99 -
> >  tests/data/acpi/pc/FACP.cphp                  |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.cphp.dsl              |   99 -
> >  tests/data/acpi/pc/FACP.dimmpxm               |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.dimmpxm.dsl           |   99 -
> >  tests/data/acpi/pc/FACP.dsl                   |   99 -
> >  tests/data/acpi/pc/FACP.hpbridge              |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.ipmikcs               |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.ipmikcs.dsl           |   99 -
> >  tests/data/acpi/pc/FACP.memhp                 |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.memhp.dsl             |   99 -
> >  tests/data/acpi/pc/FACP.numamem               |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACP.numamem.dsl           |   99 -
> >  tests/data/acpi/pc/FACP.roothp                |  Bin 116 -> 0 bytes
> >  tests/data/acpi/pc/FACS.acpihmat              |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.acpihmat.dsl          |   32 -
> >  tests/data/acpi/pc/FACS.bridge                |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.bridge.dsl            |   32 -
> >  tests/data/acpi/pc/FACS.cphp                  |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.cphp.dsl              |   32 -
> >  tests/data/acpi/pc/FACS.dimmpxm               |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.dimmpxm.dsl           |   32 -
> >  tests/data/acpi/pc/FACS.dsl                   |   32 -
> >  tests/data/acpi/pc/FACS.hpbridge              |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.ipmikcs               |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.ipmikcs.dsl           |   32 -
> >  tests/data/acpi/pc/FACS.memhp                 |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.memhp.dsl             |   32 -
> >  tests/data/acpi/pc/FACS.numamem               |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/FACS.numamem.dsl           |   32 -
> >  tests/data/acpi/pc/FACS.roothp                |  Bin 64 -> 0 bytes
> >  tests/data/acpi/pc/HMAT.acpihmat.dsl          |  132 -
> >  tests/data/acpi/pc/HMAT.dsl                   |  132 -
> >  tests/data/acpi/pc/HPET.acpihmat              |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.acpihmat.dsl          |   43 -
> >  tests/data/acpi/pc/HPET.bridge                |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.bridge.dsl            |   43 -
> >  tests/data/acpi/pc/HPET.cphp                  |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.cphp.dsl              |   43 -
> >  tests/data/acpi/pc/HPET.dimmpxm               |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.dimmpxm.dsl           |   43 -
> >  tests/data/acpi/pc/HPET.dsl                   |   43 -
> >  tests/data/acpi/pc/HPET.hpbridge              |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.ipmikcs               |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.ipmikcs.dsl           |   43 -
> >  tests/data/acpi/pc/HPET.memhp                 |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.memhp.dsl             |   43 -
> >  tests/data/acpi/pc/HPET.numamem               |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/HPET.numamem.dsl           |   43 -
> >  tests/data/acpi/pc/HPET.roothp                |  Bin 56 -> 0 bytes
> >  tests/data/acpi/pc/NFIT.dimmpxm.dsl           |  115 -
> >  tests/data/acpi/pc/NFIT.dsl                   |  115 -
> >  tests/data/acpi/pc/SLIT.cphp.dsl              |   31 -
> >  tests/data/acpi/pc/SLIT.dsl                   |   31 -
> >  tests/data/acpi/pc/SLIT.memhp.dsl             |   31 -
> >  tests/data/acpi/pc/SRAT.acpihmat.dsl          |  137 -
> >  tests/data/acpi/pc/SRAT.cphp.dsl              |  168 -
> >  tests/data/acpi/pc/SRAT.dimmpxm.dsl           |  194 -
> >  tests/data/acpi/pc/SRAT.dsl                   |  108 -
> >  tests/data/acpi/pc/SRAT.memhp.dsl             |  125 -
> >  tests/data/acpi/pc/SRAT.numamem.dsl           |  108 -
> >  tests/data/acpi/pc/SSDT.dsl                   |  205 -
> >  tests/data/acpi/pc/WAET.acpihmat              |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.acpihmat.dsl          |   31 -
> >  tests/data/acpi/pc/WAET.bridge                |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.bridge.dsl            |   31 -
> >  tests/data/acpi/pc/WAET.cphp                  |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.cphp.dsl              |   31 -
> >  tests/data/acpi/pc/WAET.dimmpxm               |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.dimmpxm.dsl           |   31 -
> >  tests/data/acpi/pc/WAET.dsl                   |   31 -
> >  tests/data/acpi/pc/WAET.hpbridge              |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.ipmikcs               |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.ipmikcs.dsl           |   31 -
> >  tests/data/acpi/pc/WAET.memhp                 |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.memhp.dsl             |   31 -
> >  tests/data/acpi/pc/WAET.numamem               |  Bin 40 -> 0 bytes
> >  tests/data/acpi/pc/WAET.numamem.dsl           |   31 -
> >  tests/data/acpi/pc/WAET.roothp                |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/APIC.acpihmat.dsl         |  112 -
> >  tests/data/acpi/q35/APIC.bridge               |  Bin 120 -> 0 bytes
> >  tests/data/acpi/q35/APIC.bridge.dsl           |  104 -
> >  tests/data/acpi/q35/APIC.cphp.dsl             |  146 -
> >  tests/data/acpi/q35/APIC.dimmpxm.dsl          |  129 -
> >  tests/data/acpi/q35/APIC.dsl                  |  104 -
> >  tests/data/acpi/q35/APIC.ipmibt               |  Bin 120 -> 0 bytes
> >  tests/data/acpi/q35/APIC.ipmibt.dsl           |  104 -
> >  tests/data/acpi/q35/APIC.memhp                |  Bin 120 -> 0 bytes
> >  tests/data/acpi/q35/APIC.memhp.dsl            |  104 -
> >  tests/data/acpi/q35/APIC.mmio64               |  Bin 120 -> 0 bytes
> >  tests/data/acpi/q35/APIC.mmio64.dsl           |  104 -
> >  tests/data/acpi/q35/APIC.numamem              |  Bin 120 -> 0 bytes
> >  tests/data/acpi/q35/APIC.numamem.dsl          |  104 -
> >  tests/data/acpi/q35/APIC.tis                  |  Bin 120 -> 0 bytes
> >  tests/data/acpi/q35/APIC.tis.dsl              |  104 -
> >  tests/data/acpi/q35/DSDT.acpihmat.dsl         | 3436 ----------------
> >  tests/data/acpi/q35/DSDT.bridge.dsl           | 3141 ---------------
> >  tests/data/acpi/q35/DSDT.cphp.dsl             | 3283 ---------------
> >  tests/data/acpi/q35/DSDT.dimmpxm.dsl          | 3535 -----------------
> >  tests/data/acpi/q35/DSDT.dsl                  | 3351 ----------------
> >  tests/data/acpi/q35/DSDT.ipmibt.dsl           | 3156 ---------------
> >  tests/data/acpi/q35/DSDT.memhp.dsl            | 3442 ----------------
> >  tests/data/acpi/q35/DSDT.mmio64.dsl           | 3377 ----------------
> >  tests/data/acpi/q35/DSDT.numamem.dsl          | 3138 ---------------
> >  tests/data/acpi/q35/DSDT.tis.dsl              | 3321 ----------------
> >  tests/data/acpi/q35/FACP.acpihmat             |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.acpihmat.dsl         |  179 -
> >  tests/data/acpi/q35/FACP.bridge               |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.bridge.dsl           |  179 -
> >  tests/data/acpi/q35/FACP.cphp                 |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.cphp.dsl             |  179 -
> >  tests/data/acpi/q35/FACP.dimmpxm              |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.dimmpxm.dsl          |  179 -
> >  tests/data/acpi/q35/FACP.dsl                  |  179 -
> >  tests/data/acpi/q35/FACP.ipmibt               |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.ipmibt.dsl           |  179 -
> >  tests/data/acpi/q35/FACP.memhp                |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.memhp.dsl            |  179 -
> >  tests/data/acpi/q35/FACP.mmio64               |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.mmio64.dsl           |  179 -
> >  tests/data/acpi/q35/FACP.numamem              |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.numamem.dsl          |  179 -
> >  tests/data/acpi/q35/FACP.tis                  |  Bin 244 -> 0 bytes
> >  tests/data/acpi/q35/FACP.tis.dsl              |  179 -
> >  tests/data/acpi/q35/FACS.acpihmat             |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.acpihmat.dsl         |   32 -
> >  tests/data/acpi/q35/FACS.bridge               |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.bridge.dsl           |   32 -
> >  tests/data/acpi/q35/FACS.cphp                 |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.cphp.dsl             |   32 -
> >  tests/data/acpi/q35/FACS.dimmpxm              |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.dimmpxm.dsl          |   32 -
> >  tests/data/acpi/q35/FACS.dsl                  |   32 -
> >  tests/data/acpi/q35/FACS.ipmibt               |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.ipmibt.dsl           |   32 -
> >  tests/data/acpi/q35/FACS.memhp                |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.memhp.dsl            |   32 -
> >  tests/data/acpi/q35/FACS.mmio64               |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.mmio64.dsl           |   32 -
> >  tests/data/acpi/q35/FACS.numamem              |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.numamem.dsl          |   32 -
> >  tests/data/acpi/q35/FACS.tis                  |  Bin 64 -> 0 bytes
> >  tests/data/acpi/q35/FACS.tis.dsl              |   32 -
> >  tests/data/acpi/q35/HMAT.acpihmat.dsl         |  132 -
> >  tests/data/acpi/q35/HMAT.dsl                  |  132 -
> >  tests/data/acpi/q35/HPET.acpihmat             |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.acpihmat.dsl         |   43 -
> >  tests/data/acpi/q35/HPET.bridge               |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.bridge.dsl           |   43 -
> >  tests/data/acpi/q35/HPET.cphp                 |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.cphp.dsl             |   43 -
> >  tests/data/acpi/q35/HPET.dimmpxm              |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.dimmpxm.dsl          |   43 -
> >  tests/data/acpi/q35/HPET.dsl                  |   43 -
> >  tests/data/acpi/q35/HPET.ipmibt               |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.ipmibt.dsl           |   43 -
> >  tests/data/acpi/q35/HPET.memhp                |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.memhp.dsl            |   43 -
> >  tests/data/acpi/q35/HPET.mmio64               |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.mmio64.dsl           |   43 -
> >  tests/data/acpi/q35/HPET.numamem              |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.numamem.dsl          |   43 -
> >  tests/data/acpi/q35/HPET.tis                  |  Bin 56 -> 0 bytes
> >  tests/data/acpi/q35/HPET.tis.dsl              |   43 -
> >  tests/data/acpi/q35/MCFG.acpihmat             |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.acpihmat.dsl         |   36 -
> >  tests/data/acpi/q35/MCFG.bridge               |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.bridge.dsl           |   36 -
> >  tests/data/acpi/q35/MCFG.cphp                 |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.cphp.dsl             |   36 -
> >  tests/data/acpi/q35/MCFG.dimmpxm              |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.dimmpxm.dsl          |   36 -
> >  tests/data/acpi/q35/MCFG.dsl                  |   36 -
> >  tests/data/acpi/q35/MCFG.ipmibt               |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.ipmibt.dsl           |   36 -
> >  tests/data/acpi/q35/MCFG.memhp                |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.memhp.dsl            |   36 -
> >  tests/data/acpi/q35/MCFG.mmio64               |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.mmio64.dsl           |   36 -
> >  tests/data/acpi/q35/MCFG.numamem              |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.numamem.dsl          |   36 -
> >  tests/data/acpi/q35/MCFG.tis                  |  Bin 60 -> 0 bytes
> >  tests/data/acpi/q35/MCFG.tis.dsl              |   36 -
> >  tests/data/acpi/q35/NFIT.dimmpxm.dsl          |  115 -
> >  tests/data/acpi/q35/NFIT.dsl                  |  115 -
> >  tests/data/acpi/q35/SLIT.cphp.dsl             |   31 -
> >  tests/data/acpi/q35/SLIT.dsl                  |   31 -
> >  tests/data/acpi/q35/SLIT.memhp.dsl            |   31 -
> >  tests/data/acpi/q35/SRAT.acpihmat.dsl         |  137 -
> >  tests/data/acpi/q35/SRAT.cphp.dsl             |  168 -
> >  tests/data/acpi/q35/SRAT.dimmpxm.dsl          |  194 -
> >  tests/data/acpi/q35/SRAT.dsl                  |  108 -
> >  tests/data/acpi/q35/SRAT.memhp.dsl            |  125 -
> >  tests/data/acpi/q35/SRAT.mmio64.dsl           |  108 -
> >  tests/data/acpi/q35/SRAT.numamem.dsl          |  108 -
> >  tests/data/acpi/q35/SSDT.dsl                  |  205 -
> >  tests/data/acpi/q35/TPM2.dsl                  |   38 -
> >  tests/data/acpi/q35/TPM2.tis.dsl              |   38 -
> >  tests/data/acpi/q35/WAET.acpihmat             |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.acpihmat.dsl         |   31 -
> >  tests/data/acpi/q35/WAET.bridge               |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.bridge.dsl           |   31 -
> >  tests/data/acpi/q35/WAET.cphp                 |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.cphp.dsl             |   31 -
> >  tests/data/acpi/q35/WAET.dimmpxm              |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.dimmpxm.dsl          |   31 -
> >  tests/data/acpi/q35/WAET.dsl                  |   31 -
> >  tests/data/acpi/q35/WAET.ipmibt               |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.ipmibt.dsl           |   31 -
> >  tests/data/acpi/q35/WAET.memhp                |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.memhp.dsl            |   31 -
> >  tests/data/acpi/q35/WAET.mmio64               |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.mmio64.dsl           |   31 -
> >  tests/data/acpi/q35/WAET.numamem              |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.numamem.dsl          |   31 -
> >  tests/data/acpi/q35/WAET.tis                  |  Bin 40 -> 0 bytes
> >  tests/data/acpi/q35/WAET.tis.dsl              |   31 -
> >  tests/data/acpi/virt/APIC.dsl                 |   78 -
> >  tests/data/acpi/virt/APIC.memhp.dsl           |   78 -
> >  tests/data/acpi/virt/APIC.numamem.dsl         |   78 -
> >  tests/data/acpi/virt/DSDT.dsl                 | 1906 ---------
> >  tests/data/acpi/virt/DSDT.memhp.dsl           | 2215 -----------
> >  tests/data/acpi/virt/DSDT.numamem.dsl         | 1906 ---------
> >  tests/data/acpi/virt/FACP.dsl                 |  196 -
> >  tests/data/acpi/virt/FACP.memhp.dsl           |  196 -
> >  tests/data/acpi/virt/FACP.numamem.dsl         |  196 -
> >  tests/data/acpi/virt/GTDT.dsl                 |   61 -
> >  tests/data/acpi/virt/GTDT.memhp.dsl           |   61 -
> >  tests/data/acpi/virt/GTDT.numamem.dsl         |   61 -
> >  tests/data/acpi/virt/MCFG.dsl                 |   36 -
> >  tests/data/acpi/virt/MCFG.memhp.dsl           |   36 -
> >  tests/data/acpi/virt/MCFG.numamem.dsl         |   36 -
> >  tests/data/acpi/virt/NFIT.dsl                 |  103 -
> >  tests/data/acpi/virt/NFIT.memhp.dsl           |  103 -
> >  tests/data/acpi/virt/SLIT.dsl                 |   31 -
> >  tests/data/acpi/virt/SLIT.memhp.dsl           |   31 -
> >  tests/data/acpi/virt/SPCR.dsl                 |   57 -
> >  tests/data/acpi/virt/SPCR.memhp.dsl           |   57 -
> >  tests/data/acpi/virt/SPCR.numamem.dsl         |   57 -
> >  tests/data/acpi/virt/SRAT.dsl                 |   57 -
> >  tests/data/acpi/virt/SRAT.memhp.dsl           |  107 -
> >  tests/data/acpi/virt/SRAT.numamem.dsl         |   57 -
> >  tests/data/acpi/virt/SSDT.dsl                 |  205 -
> >  .../bios-tables-test.x86_64.iso.raw           |  Bin 425984 -> 0 bytes
> Hmm, how could that happen? Why were these generated in the source
> directory, and not in the build directory?
> 
>  Thomas

Because I run tests/data/acpi/disassemle-aml.sh in the source
directory, then did git add tests/ ...
Verified a clean checkout passes make check but did not look
at the list of files added :(

-- 
MST


