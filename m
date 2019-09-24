Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3399C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C19214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C19214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmQX-00032h-Lq
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCkxq-0004ii-FS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCkxp-0004nv-4x
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCkxo-0004ng-Ut
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:34:45 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C69208E582
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:34:43 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id v18so572807wro.16
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x8E8jJI8ppVYKUnDaKsY7fIXB00wM8h99RHCrtkZMJY=;
 b=T9fAwF5S8Xt3tOtgj4WLQ6mIUWDqwONXJeHfk0Xw+IV2tuWm/omZ5Q7SD0zVfFd0Bb
 3tQmc0EuEhp8pnGpqoyfK793OM9dsv14V6u0b/I+RVtpZ8wePC4rAvCVgzvbqsfGkfiR
 M98BA1Z292K4dvqg6HPAPQS1v0lYRCF2wUhuamrtchSlRmN9JHxOx113Wh+DZIwnoMM5
 2TPOp+FOxnEZQU5yXSUg2HOjyzK/WIIMEn9HpkLQ/ugZDGCbSjChJLN0o4GNsZVicj5V
 ag+E6qIK0uQlnLlYseE3Sgj9nU62afv+9N2pTltkaXglGNKmwLV4NGFuOnVsgTnwWyqO
 tCXw==
X-Gm-Message-State: APjAAAVSmEUfqXBZZD1WS8S7/VBQ9w5VTOBLJh5GewslUnKLs3/Grm+B
 41RHegvTHrwx16ZkkSC6xZ0a02jEHIaC9kZi8UIKVnUcxkuo5eld4t1f8nOZbOLj6anFiIY0Asd
 b9//UK3L7Vw8h+bU=
X-Received: by 2002:a05:6000:162e:: with SMTP id
 v14mr2417623wrb.112.1569332082363; 
 Tue, 24 Sep 2019 06:34:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDHK+EXK5B0OIXOAT49NMwdLfyjrS5AP66vchxyMwjBlNGDUVHtaDt/ilNGZexHYZQsn3H2A==
X-Received: by 2002:a05:6000:162e:: with SMTP id
 v14mr2417594wrb.112.1569332082028; 
 Tue, 24 Sep 2019 06:34:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id t13sm5090317wra.70.2019.09.24.06.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 06:34:41 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
 <2cbd2570-d158-c9ce-2a38-08c28cd291ea@redhat.com>
 <20190924092222-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ee2e7983-7d80-a518-efd5-b52f8640bf90@redhat.com>
Date: Tue, 24 Sep 2019 15:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924092222-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 kvm@vger.kernel.org, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/19 15:24, Michael S. Tsirkin wrote:
> On Tue, Sep 24, 2019 at 03:12:15PM +0200, Paolo Bonzini wrote:
>> On 24/09/19 14:44, Sergio Lopez wrote:
>>> microvm.option-roms=bool (Set off to disable loading option ROMs)
>>
>> Please make this x-option-roms
> 
> Why? We don't plan to support this going forward?

The option is only useful for SeaBIOS.  Since it doesn't have any effect
for the default firmware, I think it's fair to consider it experimental.

Paolo

>>> microvm.isa-serial=bool (Set off to disable the instantiation an ISA serial port)
>>> microvm.rtc=bool (Set off to disable the instantiation of an MC146818 RTC)
>>> microvm.kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)
>>
>> Perhaps auto-kernel-cmdline?
>>
>> Paolo


