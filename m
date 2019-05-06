Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB08C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3D7205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3D7205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgIL-0007qo-Cs
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:16:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hNgHK-0007Tn-L3
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hNgHJ-0000P9-Q0
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:15:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hNgHJ-0000LA-JK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:15:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so18040101wrb.9
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 09:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=N0CyUy7ODHwAERocxoaffLXV0NVD9ZL0xvjK69XlTSw=;
	b=gHjbySvCqgOXlysfEtF8oF9tOeQoP3prEH18Q+3Uqj6T1enmzuQT0RTjD0caexNlo0
	spzZTOcZUpD4RhmWoeh6bYx9E8aYa6f3lftBAZeiyuIM+WBY+TdfWIhEzJ6X+s8NwmO5
	W9RMt+yMJejf1BDillIsWk54Gl51TnkbKRNZYEDL8OFdd2QwbiJrvU1wWCkbFgyk28fK
	IvY9mwA2mjCyvxsYP/5UsYLKvCCnTLvoGPVEIGpS1+hkEoQk/yuWhcfy7FG46mVdj+zm
	BbIYq5cpkTO19vptDPmzkhKmGJCebbN7rjlmEECoGfxTZlh8jT+TZ5acY6zwb7DqogVq
	k63A==
X-Gm-Message-State: APjAAAVqVJEXJQgd9qSTWcHA/lJk25WqcOHHeYadUWGYa0dXM4NZTUvV
	cCbQn5R6jjCp7qB7Ry2WBAtd1toP6wYRMw==
X-Google-Smtp-Source: APXvYqwM4e80bTZ9r6BoXtY4LTcOPqVcedSpQHESgR6/hBZGEDy2dXa9r+1x09fR53PD18mAy10rEA==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr2263708wrr.304.1557159342634; 
	Mon, 06 May 2019 09:15:42 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id
	x17sm9732300wru.27.2019.05.06.09.15.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 09:15:38 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home> <20190429145556.GA28722@habkost.net>
	<20190429092212.3b03e4bb@x1.home> <20190503184206.GU28722@habkost.net>
	<20190505090643.GK29750@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0898c1e5-8174-8863-d754-bfd19cbaedfa@redhat.com>
Date: Mon, 6 May 2019 11:13:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505090643.GK29750@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Igor Mammedov <imammedo@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/19 04:06, Peter Xu wrote:
>> I wonder if it's possible to untangle this and make the irqchip
>> option stop affecting guest ABI on 4.1+ machine-types?  This way
>> QEMU could choose smarter defaults in the future without the
>> compatibility code hassle.
> Hi, Eduardo,
> 
> Do you mean to enable IOMMU IR for kernel-irqchip=on?  If so, I would
> say it's not trivial...  The major issue is that we probably need to
> explicitly kick QEMU for every kernel IOAPIC setups since QEMU is the
> only one who knows everything about interrupt remapping, while KVM
> don't even have such a mechanism so far.

Right, it's not easy and it would be anyway possible only on kernels.
There would have to be a mechanism to setup IOAPIC->MSI routes, similar
to irqchip=split, and as Peter mentions an MMIO exit on writes to the
routing table.

Paolo

