Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D22CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582B820873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582B820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6T5-0006D6-Ev
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 10:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iP6Rx-00054h-Fw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iP6Rw-0002xX-3w
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iP6Rv-0002x9-S8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:56:52 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A581E36961
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 14:56:50 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id 18so3809918qka.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QtNd0UMqofsV+XZWmGpconlIFxP5DQnlNLXPHI1qYVA=;
 b=FCPxIngkNFsowL0SgPTAuIH+6HJhn+l98jifsZT/M93ZJ3PeuAUY2ChXl35+PPTKBy
 0MMaM7qUZhR+rR+PtFvZOSh3z99tDsmlC/XnYygnhrKyJdYwMx3GFsQd1SESEJg/fAg+
 qBTCXvnYOTNi5Ekq4zVnL7Qgxie2zVbfr6Aeg4gp4umaLmgxCgUyaawvX069cWLhoVcK
 YWNCWOKbbDMBA3BQ85rqYGHovnYjxuWCAJ9PFAPj4iKXFKJcdYoD8L+GD1WfX/1NmVA6
 GY1vEQ3G7uxca+CZuYK/DOZl/Qv4LGOzFzihOYJeeQTn46yUXoNu47wo70w8wJZwwExr
 ZAdw==
X-Gm-Message-State: APjAAAVuvkczGi1C7hJcQ9xjT+7rsd9xQK8RKhsOuKPWsMsONZWKJ290
 1+jWuMn5CG483rgQy1Vi4rC7Zeu/3i2sG3NhwxVkP/OODXLzPYZbSCXZbX38JY1pEN0/3aPXMc0
 gzXkL12PumUVzjC4=
X-Received: by 2002:a37:610f:: with SMTP id v15mr15487588qkb.98.1572274609945; 
 Mon, 28 Oct 2019 07:56:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVqh1AavhfAL3N/XFU4xnwB0M3GWSLGvejcePz3nI6KDoPRMDZQjnEw5dr2p7IfEnb9i2/Zg==
X-Received: by 2002:a37:610f:: with SMTP id v15mr15487560qkb.98.1572274609617; 
 Mon, 28 Oct 2019 07:56:49 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 p17sm5696481qkm.135.2019.10.28.07.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:56:48 -0700 (PDT)
Date: Mon, 28 Oct 2019 10:56:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v20 0/5] Add ARMv8 RAS virtualization support in QEMU
Message-ID: <20191028104834-mutt-send-email-mst@kernel.org>
References: <20191026032447.20088-1-zhengxiang9@huawei.com>
 <20191027061450-mutt-send-email-mst@kernel.org>
 <6c44268a-2676-3fa1-226d-29877b21dbea@huawei.com>
 <20191028042645-mutt-send-email-mst@kernel.org>
 <1edda59a-8b3d-1eec-659a-05356d55ed22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edda59a-8b3d-1eec-659a-05356d55ed22@huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 imammedo@redhat.com, pbonzini@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, wanghaibin.wang@huawei.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 09:50:21PM +0800, gengdongjiu wrote:
> Hi Michael,
> 
> On 2019/10/28 16:28, Michael S. Tsirkin wrote:
> >>> gets some testing.  I'll leave this decision to the ARM maintainer.  For
> >>> ACPI parts:
> >>>
> >>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >> Got it, Thanks for the Reviewed-by from Michael.
> >>
> >> Hi Michael,
> >>   According to discussion with QEMU community, I finished and developed the whole ARM RAS virtualization solution, and introduce the ARM APEI table in the first time.
> >> For the newly created files, which are mainly about ARM APEI/GHES part,I would like to maintain them. If you agree it, whether I can add new maintainers[1]? thanks a lot.
> >>
> >>
> >> [1]:
> >> +ARM APEI Subsystem
> >> +M: Dongjiu Geng <gengdongjiu@huawei.com>
> >> +M: Xiang zheng <zhengxiang9@huawei.com>
> >> +L: qemu-arm@nongnu.org
> >> +S: Maintained
> >> +F: hw/acpi/acpi_ghes.c
> >> +F: include/hw/acpi/acpi_ghes.h
> >> +F: docs/specs/acpi_hest_ghes.rst
> >>
> > I think for now you want to be a designated reviewer.  So I'd use an R:
> > tag.
> 
>  Thanks for the reply.
>  I want to be a maintainer for my newly created files, so whether I can use M: tag. I would like to contribute some time to maintain that, thanks a lot.

This will fundamentally be up to Peter.

Reviewing patches is generally the best way to become a maintainer,
that's why I suggested the R: tag.


> > 
> >>>
> >>>> ---

