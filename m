Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EAEC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64968208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoIWM+VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64968208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLKa8-0005np-EW
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 02:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLKZD-0004la-GV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLKZB-0000Xk-Li
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600928236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjuAs3xurAQ+p7FiGGufckxielAvPaGPzu8pvuvyP1I=;
 b=UoIWM+VEoj0GFF6gMc/1AtpvpRqPuT18MfpMUKzkcfmaGQPrkOxudz5R8Gy2vS6hw7+307
 G8TC6/ekmK5XIa6Jlk68E2rwxEHcUJDjpu4nJvZ8wv4xbWdl18cMApzk9HOJVNTbWjDZzu
 aVglLXeDOLiUZ8NuwPojO7+DylBRYIk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-dlwsk805NHOH7bTSaWz3FA-1; Thu, 24 Sep 2020 02:17:14 -0400
X-MC-Unique: dlwsk805NHOH7bTSaWz3FA-1
Received: by mail-wm1-f70.google.com with SMTP id l15so806241wmh.9
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 23:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LjuAs3xurAQ+p7FiGGufckxielAvPaGPzu8pvuvyP1I=;
 b=g3GzC7w7pJO09wZr25xF0iq9fCAqRYjC1O5HOknMYhzSKelodlbKU52fU3Jx99mfZn
 Rkqr5ZtDXq2QU1DNJ9EEpt9/39Ci08wiOAJdEf0DvGSUzNdOl/CMC/bRiRZH+2UY4Z+/
 PYSNoSQ9mpYdUom1XZKi3l00UsPHiBDrNFpAJB3x/5XjzwbuahQyGxfj309GnAhd/UTb
 QGcAqtsnC/bQKiJJbM9b4kxS+7gSyGG9MYkqD3qdS3ahN8fEZiE06JgPJGtLUGV7E2Y3
 e+wuYS65J+cfPh6m1rNd8CfZofzvOeIcQhNt+2+8gTfsYXyX3BPdrqtqTRdyX7FWfTrK
 2nNg==
X-Gm-Message-State: AOAM533LFALGVCIPvOxNyGwtUeKMWdcz/GqzvvTY/8JEDwRhh81o/T+z
 BD9kRXPPMd0C1ZZzbQ/AWZLwu/6HZvZCupM8JQj97l2UPnCuQ2ASgJGtz18h8/tTiH/KAwBjN7X
 V/W8v49M19vVPn8I=
X-Received: by 2002:adf:eb04:: with SMTP id s4mr3426811wrn.81.1600928233629;
 Wed, 23 Sep 2020 23:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0MUM9G0tQA6U0qi+P36QtVB5kHcVsJhCI8KkgiVMCsTXjxw80xX0wE/qHQEoRXCsubiqUmw==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr3426796wrn.81.1600928233443;
 Wed, 23 Sep 2020 23:17:13 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d19sm2131421wmd.0.2020.09.23.23.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 23:17:12 -0700 (PDT)
Date: Thu, 24 Sep 2020 02:17:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/i386/acpi-build: Explain bits in OSC method
Message-ID: <20200924021247-mutt-send-email-mst@kernel.org>
References: <20200923075514.110478-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200923075514.110478-1-jusual@redhat.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 09:55:14AM +0200, Julia Suvorova wrote:
> Provide a better explanation for the enabled bits in the _OSC control
> field. Base it on the latest specification due to new bits 5 and 6.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/i386/acpi-build.h | 11 +++++++++++
>  hw/i386/acpi-build.c |  7 ++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 74df5fc612..bb5269d162 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -5,6 +5,17 @@
>  
>  extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>  
> +/* PCI Firmware Specification 3.2, Table 4-5 */
> +typedef enum {
> +    ACPI_OSC_NATIVE_HP_EN = 0,
> +    ACPI_OSC_SHPC_EN = 1,
> +    ACPI_OSC_PME_EN = 2,
> +    ACPI_OSC_AER_EN = 3,
> +    ACPI_OSC_PCIE_CAP_EN = 4,
> +    ACPI_OSC_LTR_EN = 5,
> +    ACPI_OSC_ALLONES_INVALID = 6,
> +} AcpiOSCField;
> +
>  void acpi_setup(void);
>  
>  #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0e0535d2e3..b08f005a35 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1417,6 +1417,7 @@ static Aml *build_q35_osc_method(void)
>      Aml *method;
>      Aml *a_cwd1 = aml_name("CDW1");
>      Aml *a_ctrl = aml_local(0);
> +    unsigned osc_ctrl;
>  
>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> @@ -1432,7 +1433,11 @@ static Aml *build_q35_osc_method(void)
>       * Always allow native PME, AER (no dependencies)
>       * Allow SHPC (PCI bridges can have SHPC controller)
>       */
> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
> +    osc_ctrl = BIT(ACPI_OSC_PME_EN) | BIT(ACPI_OSC_AER_EN) |
> +               BIT(ACPI_OSC_PCIE_CAP_EN) | BIT(ACPI_OSC_NATIVE_HP_EN) |
> +               BIT(ACPI_OSC_SHPC_EN);
> +
> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(osc_ctrl), a_ctrl));

Now the comment above somewhat duplicates the enums.  And decoding what
does each value mean is a head scratcher.  As long as there's a single
use, we prefer comments to an enum, they can match spec exactly:

BIT(0) /* PCI Express Native Hotplug control */ |
BIT(4) /* SHPC Native Hotplug control */ |

etc ...

>      if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>      /* Unknown revision */
> -- 
> 2.25.4


