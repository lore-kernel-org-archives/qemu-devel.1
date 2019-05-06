Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1EC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC56205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC56205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgLx-00013V-CA
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:20:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hNgL9-0000l3-71
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hNgL8-0002CQ-6U
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:19:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hNgL8-0002CC-0I
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:19:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so18057868wrb.9
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EBvocokZDN2KYzv2lmTpYLIva1RA/sSv206hlAQxdcI=;
	b=oMg/McDM1pbjE0ePllRelHkL/sv0gDaBH/3Z3si75c0t7PcA0Fni70egmSlgPd5Nrj
	9esgkIbxXeFhPYTVSAXgz8RsilBT+8BXT1+Vp0qHkR+Wh2PUWOqtQNYy4XkAnBorW/bg
	6x3JHV2vB9ll6BfFyCACs9oOoqaMgA5W5phk+c8OIwGVk7mNZSuoGJ0X+txyx2fykKu6
	s+DR8OD85L7NTfwXEzeWQUEHCpzfdS7kSsKIReK8/yuNTOKWjVMhXJ12IAbWHs40mGx/
	5qPa5lDjGdxPZgmUBJeYo6af++7ZS1IETuUGVf+CbvRP34uA2ouY7jNczVxr0k0UcFHV
	JbFQ==
X-Gm-Message-State: APjAAAUPa1LOMzAFbptMxj3Tel85ARWB9gXQvPUXRzD3xdymsngAy31A
	K7/+0smPtBPzmd6f9KjjelGzCA==
X-Google-Smtp-Source: APXvYqyaNfCPu+amzmrnUEekrfY4aeJlHDm4BgsUmuRTFUbQ3aem7Tb4j77wcbn4bPu9bb8xc1xzqw==
X-Received: by 2002:adf:fe49:: with SMTP id m9mr812568wrs.73.1557159580847;
	Mon, 06 May 2019 09:19:40 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id
	j3sm10236600wrg.72.2019.05.06.09.19.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 09:19:40 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home> <20190429145556.GA28722@habkost.net>
	<20190503155951-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c77ae8f9-d8bd-da45-e2ab-10754c037713@redhat.com>
Date: Mon, 6 May 2019 11:17:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503155951-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
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
	qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/05/19 15:00, Michael S. Tsirkin wrote:
> On Mon, Apr 29, 2019 at 11:55:56AM -0300, Eduardo Habkost wrote:
>> irqchip=split and irqchip=kernel aren't guest ABI compatible, are
>> they?
> 
> Can you remind me why they aren't?

They are compatible if the userspace IOAPIC is configured with "-global
ioapic.version=0x11".  The userspace IOAPIC in addition supports version
0x20, which adds the EOI register (a requirement for interrupt remapping
but not necessary outside that case), and makes it the default.

Paolo

