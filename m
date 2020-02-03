Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6846FC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C1820661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8ltmJRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C1820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWaV-0006IW-Bu
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 02:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyWZe-0005lZ-46
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyWZd-0007L1-2J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:55:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyWZc-0007K1-UE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580716512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dboh0QVxXtI2PvjSsCAnC9KkJagQEfb/i+ydQ8g4GXY=;
 b=B8ltmJRvDaVsPbXZNXDfYs5feptBzq3hUKqkz4ycPnrZlUBGR399YQemGQ0VkeWhISgjsb
 qAuwYYrr6uEwP72iX0p+UQMvhnXkYZ4WjT//NuXQatTzFvMxJumSWUvJmV00jV/VfuRPAO
 0U0DvAdpJosR0MQq0Gemg2J/aNGIpUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-ziPYIh3SP6WXYH8YYFr7Yg-1; Mon, 03 Feb 2020 02:55:10 -0500
X-MC-Unique: ziPYIh3SP6WXYH8YYFr7Yg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DBB4107ACCD;
 Mon,  3 Feb 2020 07:55:08 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C280171D6;
 Mon,  3 Feb 2020 07:55:02 +0000 (UTC)
Date: Mon, 3 Feb 2020 08:55:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v22 7/9] ACPI: Record Generic Error Status Block(GESB)
 table
Message-ID: <20200203085501.499e3a83@redhat.com>
In-Reply-To: <a9f46632-0766-7e82-7dc4-752d00b4a0a1@huawei.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-8-git-send-email-gengdongjiu@huawei.com>
 <20200128162938.18bd0e95@redhat.com>
 <a9f46632-0766-7e82-7dc4-752d00b4a0a1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2 Feb 2020 21:42:23 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> On 2020/1/28 23:29, Igor Mammedov wrote:
> > On Wed, 8 Jan 2020 19:32:21 +0800
> > Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> >   
> >> kvm_arch_on_sigbus_vcpu() error injection uses source_id as
> >> index in etc/hardware_errors to find out Error Status Data
> >> Block entry corresponding to error source. So supported source_id
> >> values should be assigned here and not be changed afterwards to
> >> make sure that guest will write error into expected Error Status
> >> Data Block even if guest was migrated to a newer QEMU.
> >>
> >> Before QEMU writes a new error to ACPI table, it will check whether
> >> previous error has been acknowledged. Otherwise it will ignore the new
> >> error. For the errors section type, QEMU simulate it to memory section
> >> error.
> >>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

btw:
when you are changing patch and it's not a trivial change,
you are supposed to drop Reviewed-by/Acked-by tags.

[...]
> >> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> >> index 129c45f..b35e294 100644
> >> --- a/include/qemu/uuid.h
> >> +++ b/include/qemu/uuid.h
> >> @@ -34,6 +34,11 @@ typedef struct {
> >>      };
> >>  } QemuUUID;
> >>  
> >> +#define UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
> >> +  {{{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> >> +     (b) & 0xff, ((b) >> 8) & 0xff, (c) & 0xff, ((c) >> 8) & 0xff,          \
> >> +     (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) } } }  
> > 
> > since you are adding generalizing macro, take of NVDIMM_UUID_LE which served as model  
> 
> do you mean use this generalizing macro to replace NVDIMM_UUID_LE, right?

yes, and preferably do that in a separate patch

> 
> > 
> >   
> >>  #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
> >>                   "%02hhx%02hhx-%02hhx%02hhx-" \
> >>                   "%02hhx%02hhx-" \  
> > 
> > .
> >   
> 


