Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C8FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD92206FA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhfqnVXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD92206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnihB-0007Ce-6B
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnigO-0006kz-IY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:09:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnigM-0005Z2-Kv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592917785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ftNVvr7o2kixxqU+15fnHbqtnCG16g4/IFaY19W+FWE=;
 b=LhfqnVXljjSu9kC7FRmIENfYfKSytIxmcbWn1lphUb6iFJTtZLp6U3z5dQvIzuX+Fj9PhP
 SuOTipAvBbynpETgYW9DiJ4F27WMPpDXW0WsXeOMw3lxHPeL7ijdRG2V73597A6xc9cwAt
 bRDNCUQ0hfbQ7EMz5DB4lmm+V5qnC1I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-xKryCeo0P9eMWDauJbDSgQ-1; Tue, 23 Jun 2020 09:09:43 -0400
X-MC-Unique: xKryCeo0P9eMWDauJbDSgQ-1
Received: by mail-wr1-f69.google.com with SMTP id l3so6401636wrw.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 06:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ftNVvr7o2kixxqU+15fnHbqtnCG16g4/IFaY19W+FWE=;
 b=GvChLlNBriBMU4ZUvWeiOU4giXpyTnqAwrBOkcDDQd07n0rIatsU4txtG2gb/Gu/EI
 JYvYbkJmZsj43ryh8PkWGHwxhBHF9oQGaEJ71g/rRBjFhbRBfirv/1FnRGUCbFHp0e0A
 YAH1bRYiETPGB70Uo6fBCWWcWwMf9IMp1p7B/5t1eCvGKXRpkSUiFGz4TTB8eMw58OpS
 Fi5M9KxlP3JN9wwUQej9ToNrNJTdjRfDkvl5qUeda1Y184X8aIeElfZgVpNmn7T/kFGy
 8M968bUiUl3sbWWX5Zt1LFYJ4P9EENIm0RhAHbqM6yY6Sc5m508h6RaZbiqgamVMw1DD
 Imsg==
X-Gm-Message-State: AOAM532uTvnWCeHLkCyDbex5uyzCgvvlShN6wwuvzT3fOImTrcHh05kq
 uwOjZKIvtBuFN9XQygndEM09IAP0CF2dcB05dhPdKvSIiE/2tDNjV7imJ7L3Kpmq9qEa/ltWBbK
 7ttRyEAj4Kszj004=
X-Received: by 2002:a1c:2485:: with SMTP id
 k127mr21271487wmk.138.1592917782656; 
 Tue, 23 Jun 2020 06:09:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr2lfEZMrKpghBUsZMxoAuiUEeun6vKBbv4vHzz6YzdIWLARx76XKq7+7dNj8zfHUd8/o0vA==
X-Received: by 2002:a1c:2485:: with SMTP id
 k127mr21271465wmk.138.1592917782440; 
 Tue, 23 Jun 2020 06:09:42 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 d28sm24360942wrc.50.2020.06.23.06.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 06:09:41 -0700 (PDT)
Date: Tue, 23 Jun 2020 09:09:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 0/8] tpm: Enable usage of TPM TIS with interrupts
Message-ID: <20200623090840-mutt-send-email-mst@kernel.org>
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, philmd@redhat.com, mkedzier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 10:22:57AM -0400, Stefan Berger wrote:
> This series of patches enables the usage of the TPM TIS with interrupts.
> We use the unused IRQ 13, which is the only one accepted by Windows.
> 
>     Stefan


ACPI parts:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

How do we want this merged? TPM tree or mine?

> v3->v4:
>  - Changed TPM_IRQ_DISABLED from -1 to ~0
> 
> v2->v3:
>  - Extended series to disable IRQ for TIS on sysbus
> 
> v1->v2:
>  - Added updated DSDT
> 
> Stefan Berger (8):
>   tpm_tis: Allow lowering of IRQ also when locality is not active
>   tpm: Extend TPMIfClass with get_irqnum() function
>   tests: Temporarily ignore DSDT table differences
>   tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS_IRQ
>   acpi: Enable TPM IRQ
>   tests: Add updated DSDT
>   tpm: Guard irq related ops in case interrupts are disabled
>   tpm: Disable interrupt support for TIS on sysbus
> 
>  hw/i386/acpi-build.c         |  11 +++++------
>  hw/tpm/tpm_tis_common.c      |  12 +++++++++---
>  hw/tpm/tpm_tis_isa.c         |  17 ++++++++++++++---
>  hw/tpm/tpm_tis_sysbus.c      |  12 +++++++++++-
>  include/hw/acpi/tpm.h        |   3 ++-
>  include/sysemu/tpm.h         |  12 ++++++++++++
>  tests/data/acpi/q35/DSDT.tis | Bin 8357 -> 8360 bytes
>  7 files changed, 53 insertions(+), 14 deletions(-)
> 
> -- 
> 2.24.1
> 
> 


