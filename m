Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A0FC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C411218DA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C411218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbPD-0006ZS-Tr
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqbP4-00065P-4p
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqbP3-0004Dh-6n
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:55:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqbP3-0004DR-0G
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:55:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so47047357wrm.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UZ4g6h7Z9RVChee0ixyXvCgsbP0PHPKZGoPz3VZ3egE=;
 b=fYKJ2cLgIChofd7v/eQcXgDr20fgc2AAMyThB1S05rZlgc/ElYjTxSbz8DsSW/V4gG
 v0d40wJYOLTTqiB8lC+YA7UGVg2zF3SqJzM3snPWL7GOzlm5D9z3/gWg5QbG+jIbKa87
 X/iAIm6CzVZx+AlG74imkjIQV/fA7b+YCJSF+5LVDGaVk8bZC79N8JS2Iu9o1R4R/4Xe
 HEvm0Wvva69FDAu8vhmA6IfEJCG7qoJcQq8o7A05Oqm2yI513xCcGCfmX0dVHtPQtS8t
 MV7hYR2lVb2Q0vmELiNhqUmKEvKbDy+f9XYxREwJIEkwSX8FD5GAokhFGhwP9Vr3WYbP
 j/rQ==
X-Gm-Message-State: APjAAAXlQI9fbeZpQkHLBnWxRbhzluVNYo1ONZsAFr9191kiFBOTFG2y
 63XUNAHTB5T3OW5NavH46c1BAw==
X-Google-Smtp-Source: APXvYqy23ynXUCRbXM3tlDie8GAZPbOnf8D1Go/E3L8qs+Mv3nCZblb4RtNqjKcGBsRfH4wX9I06Gg==
X-Received: by 2002:adf:f186:: with SMTP id h6mr80636837wro.274.1564052115437; 
 Thu, 25 Jul 2019 03:55:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id g17sm36211599wrm.7.2019.07.25.03.55.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 03:55:14 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190703095825.GE11844@stefanha-x1.localdomain>
 <87d0i7tlkl.fsf@redhat.com> <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
 <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
 <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
 <20190725060105-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <390698b1-03a2-2488-bd55-e3a90c8d0638@redhat.com>
Date: Thu, 25 Jul 2019 12:55:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725060105-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>, "Montes,
 Julio" <julio.montes@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 12:03, Michael S. Tsirkin wrote:
>> +#ifdef CONFIG_PCI
>> +	x86_platform.pci_scan_bus = kvm_pci_scan_bus;
>> +#endif
>> +
>>  	if (!kvm_para_available())
>>  		return;
>>  
> Shouldn't this happen after kvm_para_available?

Actually kvm_para_available() is not needed anymore, since this only
runs after kvm_detect() has returned true.

> In fact, let's add a CPU ID flag for this, so it's
> easy to tell guest whether to scan extra buses.
> What do you say?

I think it would make it much harder to deploy this, since it relies on
having new userspace and new machine types.  This patch is basically a
reflection of the status quo, which is that there are generally no
"hidden" buses on commonly-used KVM userspaces, and even in the weird
configurations that have them there is always something at devfn=0.

(On real hardware, the only such hidden bus is e.g. 0x7f/0xff, which
have a bunch of QPI and MCH-related devices.  This is not something
you'd have in a virtual machine).

Paolo

