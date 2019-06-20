Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430DEC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154E02083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154E02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzEk-0005HY-B1
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hdypc-0005mr-Rc
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hdyhG-0001zh-NB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hdyhF-0001tR-5h; Thu, 20 Jun 2019 11:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44F243082140;
 Thu, 20 Jun 2019 15:09:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3279419C5B;
 Thu, 20 Jun 2019 15:09:39 +0000 (UTC)
Date: Thu, 20 Jun 2019 17:09:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <20190620170934.39eae310@redhat.com>
In-Reply-To: <f4f94ecb-200c-3e18-1a09-5fb6bc761834@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-3-git-send-email-gengdongjiu@huawei.com>
 <20190620141052.370788fb@redhat.com>
 <f4f94ecb-200c-3e18-1a09-5fb6bc761834@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 20 Jun 2019 15:09:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 02/10] ACPI: add some GHES structures
 and macros definition
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
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Jun 2019 22:04:01 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> Hi Igor,
>    Thanks for your review.
> 
> On 2019/6/20 20:10, Igor Mammedov wrote:
> >> + */
> >> +struct AcpiGenericErrorStatus {
> >> +    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
> >> +    uint32_t block_status;
> >> +    uint32_t raw_data_offset;
> >> +    uint32_t raw_data_length;
> >> +    uint32_t data_length;
> >> +    uint32_t error_severity;
> >> +} QEMU_PACKED;
> >> +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;  
> > there shouldn't be packed structures,
> > is it a leftover from previous version?  
> 
> I remember some people suggest to add QEMU_PACKED before, anyway I will remove it in my next version patch.

Question is why it's  there and where it is used?

BTW:
series doesn't apply to master anymore.
Do you have a repo somewhere available for testing?

> 
> >   
> >> +
> >> +/*
> >> + * Masks for block_status flags above
> >> + */
> >> +#define ACPI_GEBS_UNCORRECTABLE         1
> >> +
> >> +/*  
> 


