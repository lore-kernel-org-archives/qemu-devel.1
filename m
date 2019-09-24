Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C0C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E0520872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E0520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCndq-00062V-6J
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iCmuZ-0008L5-LB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iCmuV-0006KB-LI
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iCmuU-0006Gh-7U
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:27 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5110F5945E
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:39:25 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id o133so2426435qke.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PTQQeXWO5vPTU6tigUaFPHUuGjp5uZ3Hgvq/mbe0/q8=;
 b=IlTvClD5F10+Us7f509Of0kbcdkGyJDl+okeP07lb5ohID6/Q6YMsToJDB3h+ucegs
 RUBdXZOjffSymk0DclpvsMiL5fsXWg3nQsT6xd+zfL1sTreJiuesl5CJZCS12EBrRRuL
 7jviCnH4OG/uZX7r72Z6aGyrwasDCf43j7RFpQpHQWStOOKySBnzjF+5K1GBy8pNrn4U
 FimoF8EpRYp5K8ipD2G+m50XvtSpx38lk/1EqSAj1Ya4tVC8q33ae+iCo5cs8MKWpTMR
 EhQSyu+DiZbzHpq2W8Q1girQHaImhAhtu/Msjo2SIFtKxJyuS66fh3h2cyimFZCNR+KF
 K7Zw==
X-Gm-Message-State: APjAAAX0WDFYYnZPwGUfUbWBCEB785ckpdbyMZ1IXHTadZM+rQ5vTOJ1
 BaikgyuklCopBpG9E6GUyp/+jz0LdJYepJQg/Cq63rWEitQSZSDHxV5l9vhMYQOV+BFdAT9Earx
 7ensc/vcW6jneik8=
X-Received: by 2002:ac8:342a:: with SMTP id u39mr3465207qtb.7.1569339564619;
 Tue, 24 Sep 2019 08:39:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqznlDhsLQpyIFK6nRFjbhudaZrRRV3OOlTnkVZlvYzC4PZu5ddm6L574qRzPyehnZUU6ffx+Q==
X-Received: by 2002:ac8:342a:: with SMTP id u39mr3465181qtb.7.1569339564339;
 Tue, 24 Sep 2019 08:39:24 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id v5sm1448122qtk.66.2019.09.24.08.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:39:23 -0700 (PDT)
Date: Tue, 24 Sep 2019 11:39:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [RFC PATCH 01/12] linux-headers: import arm_sdei.h
Message-ID: <20190924113640-mutt-send-email-mst@kernel.org>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-2-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569338511-3572-2-git-send-email-guoheyi@huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, qemu-arm@nongnu.org,
 James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 11:21:40PM +0800, Heyi Guo wrote:
> Import Linux header file include/uapi/linux/arm_sdei.h from kernel
> v5.3 release.
> 
> This is to prepare for qemu SDEI emulation.
> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Some issues with this.  First linux-headers is for linux as a host.
This is for linux as a guest, so belongs in include/standard-headers.

Second, please add to scripts/update-linux-headers.sh in a 1st patch,
then add the file in the second patch.



> ---
>  linux-headers/linux/arm_sdei.h | 73 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 linux-headers/linux/arm_sdei.h
> 
> diff --git a/linux-headers/linux/arm_sdei.h b/linux-headers/linux/arm_sdei.h
> new file mode 100644
> index 0000000..af0630b
> --- /dev/null
> +++ b/linux-headers/linux/arm_sdei.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (C) 2017 Arm Ltd. */
> +#ifndef _UAPI_LINUX_ARM_SDEI_H
> +#define _UAPI_LINUX_ARM_SDEI_H
> +
> +#define SDEI_1_0_FN_BASE			0xC4000020
> +#define SDEI_1_0_MASK				0xFFFFFFE0
> +#define SDEI_1_0_FN(n)				(SDEI_1_0_FN_BASE + (n))
> +
> +#define SDEI_1_0_FN_SDEI_VERSION			SDEI_1_0_FN(0x00)
> +#define SDEI_1_0_FN_SDEI_EVENT_REGISTER			SDEI_1_0_FN(0x01)
> +#define SDEI_1_0_FN_SDEI_EVENT_ENABLE			SDEI_1_0_FN(0x02)
> +#define SDEI_1_0_FN_SDEI_EVENT_DISABLE			SDEI_1_0_FN(0x03)
> +#define SDEI_1_0_FN_SDEI_EVENT_CONTEXT			SDEI_1_0_FN(0x04)
> +#define SDEI_1_0_FN_SDEI_EVENT_COMPLETE			SDEI_1_0_FN(0x05)
> +#define SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME	SDEI_1_0_FN(0x06)
> +#define SDEI_1_0_FN_SDEI_EVENT_UNREGISTER		SDEI_1_0_FN(0x07)
> +#define SDEI_1_0_FN_SDEI_EVENT_STATUS			SDEI_1_0_FN(0x08)
> +#define SDEI_1_0_FN_SDEI_EVENT_GET_INFO			SDEI_1_0_FN(0x09)
> +#define SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET		SDEI_1_0_FN(0x0A)
> +#define SDEI_1_0_FN_SDEI_PE_MASK			SDEI_1_0_FN(0x0B)
> +#define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
> +#define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
> +#define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
> +#define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
> +#define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
> +
> +#define SDEI_VERSION_MAJOR_SHIFT			48
> +#define SDEI_VERSION_MAJOR_MASK				0x7fff
> +#define SDEI_VERSION_MINOR_SHIFT			32
> +#define SDEI_VERSION_MINOR_MASK				0xffff
> +#define SDEI_VERSION_VENDOR_SHIFT			0
> +#define SDEI_VERSION_VENDOR_MASK			0xffffffff
> +
> +#define SDEI_VERSION_MAJOR(x)	(x>>SDEI_VERSION_MAJOR_SHIFT & SDEI_VERSION_MAJOR_MASK)
> +#define SDEI_VERSION_MINOR(x)	(x>>SDEI_VERSION_MINOR_SHIFT & SDEI_VERSION_MINOR_MASK)
> +#define SDEI_VERSION_VENDOR(x)	(x>>SDEI_VERSION_VENDOR_SHIFT & SDEI_VERSION_VENDOR_MASK)
> +
> +/* SDEI return values */
> +#define SDEI_SUCCESS		0
> +#define SDEI_NOT_SUPPORTED	-1
> +#define SDEI_INVALID_PARAMETERS	-2
> +#define SDEI_DENIED		-3
> +#define SDEI_PENDING		-5
> +#define SDEI_OUT_OF_RESOURCE	-10
> +
> +/* EVENT_REGISTER flags */
> +#define SDEI_EVENT_REGISTER_RM_ANY	0
> +#define SDEI_EVENT_REGISTER_RM_PE	1
> +
> +/* EVENT_STATUS return value bits */
> +#define SDEI_EVENT_STATUS_RUNNING	2
> +#define SDEI_EVENT_STATUS_ENABLED	1
> +#define SDEI_EVENT_STATUS_REGISTERED	0
> +
> +/* EVENT_COMPLETE status values */
> +#define SDEI_EV_HANDLED	0
> +#define SDEI_EV_FAILED	1
> +
> +/* GET_INFO values */
> +#define SDEI_EVENT_INFO_EV_TYPE			0
> +#define SDEI_EVENT_INFO_EV_SIGNALED		1
> +#define SDEI_EVENT_INFO_EV_PRIORITY		2
> +#define SDEI_EVENT_INFO_EV_ROUTING_MODE		3
> +#define SDEI_EVENT_INFO_EV_ROUTING_AFF		4
> +
> +/* and their results */
> +#define SDEI_EVENT_TYPE_PRIVATE			0
> +#define SDEI_EVENT_TYPE_SHARED			1
> +#define SDEI_EVENT_PRIORITY_NORMAL		0
> +#define SDEI_EVENT_PRIORITY_CRITICAL		1
> +
> +#endif /* _UAPI_LINUX_ARM_SDEI_H */
> -- 
> 1.8.3.1

