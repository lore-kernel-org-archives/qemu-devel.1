Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76443C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D7820757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+H/fDMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU80a-0002Ki-Fa
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU7sZ-0004yN-3L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU7rz-0007T6-Ig
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:01:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jU7rz-0007Pg-2f
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588248044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rmi4mrxC2kjMximJG37kVyYsvSASF6Fbw0o5LGCNJAw=;
 b=H+H/fDMF6FHTZvFkZCw8FIhj7Hn1X941Q2msQn1sNlauNkn/oMy+lw6wfuBpZsXRwqqe9q
 3CbTO3lbnf5ksZdN3zGAWnjqB9/Gh5Vmfh3wX41q+g7+dBJqtWXxRQmq4Z3WBZDQ8vKouw
 pm1TL//mEHhVmvVK6vEOK7xAOnXPC7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-OxUvUlMMOUKVMeXULKMzAA-1; Thu, 30 Apr 2020 08:00:35 -0400
X-MC-Unique: OxUvUlMMOUKVMeXULKMzAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FCAAEC1A3;
 Thu, 30 Apr 2020 12:00:33 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EDE5610AF;
 Thu, 30 Apr 2020 12:00:17 +0000 (UTC)
Date: Thu, 30 Apr 2020 14:00:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 00/10] Add ARMv8 RAS virtualization support in QEMU
Message-ID: <20200430140016.0799afd7@redhat.com>
In-Reply-To: <9906359a-cc13-fd7f-1cd3-c80c0ee90d09@huawei.com>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <CAFEAcA9oNuDf=bdSSE8mZWrB23+FegD5NeSAmu8dGWhB=adBQg@mail.gmail.com>
 <9906359a-cc13-fd7f-1cd3-c80c0ee90d09@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 11:56:24 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> On 2020/4/17 21:32, Peter Maydell wrote:
> > On Fri, 10 Apr 2020 at 12:46, Dongjiu Geng <gengdongjiu@huawei.com> wrote:  
> >>
> >> In the ARMv8 platform, the CPU error types includes synchronous external abort(SEA)
> >> and SError Interrupt (SEI). If exception happens in guest, host does not know the detailed
> >> information of guest, so it is expected that guest can do the recovery. For example, if an
> >> exception happens in a guest user-space application, host does not know which application
> >> encounters errors, only guest knows it.
> >>
> >> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
> >> After user space gets the notification, it will record the CPER into guest GHES
> >> buffer and inject an exception or IRQ to guest.
> >>
> >> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
> >> treat it as a synchronous exception, and notify guest with ARMv8 SEA
> >> notification type after recording CPER into guest.  
> > 
> > Hi. I left a comment on patch 1. The other 3 patches unreviewed
> > are 5, 6 and 8, which are all ACPI core code, so that's for
> > MST, Igor or Shannon to review.  
> 
> Ping MST, Igor and Shannon, sorry for the noise.

I put it on my review queue 

> 
> > 
> > Once those have been reviewed, please ping me if you want this
> > to go via target-arm.next.
> > 
> > thanks
> > -- PMM
> > 
> > .
> >   
> 


