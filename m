Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06930C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D352820880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D352820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hni1E-00059T-3y
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 07:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42808)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hni13-0004hH-HV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hni12-0001U6-LL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:22:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hni12-0001Sm-Ea
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:22:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so21772435wmj.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 04:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DMs8a+Ov8xt1XecjqA7QY+1V27R72i9q9zzUfqK9mAs=;
 b=Vvhp7+9VEuyd0/mV00m+WoGFax8km6SWFwvO4urjBfhU/Ag07bVVDRNGYw3pyaOGx0
 wlpa+xxAEPXi5uPfpWqiKPfVqxJTl+IutexalUNy4iSraQx/Lr2Rtz2SlRPM2+Vhmcid
 wizW0u/fdl0qRG54hnHcP5KiOgI6PjRXbwC1pt0uSJ5NqB59PULKEcBf+GamD00cRZC9
 bdGs2TpqETX5Hhm327IiqTsNpTEITkRCr4+U8H0ltBYcMdHlsQl1+SQK/hGG7Vky4QNL
 0v/Rjffw62oW2E0nAGJmjEVGJXNm+KqI40q42BG8pk00B0IUCYlAuF//IjPQ8yO2qqUU
 ZrBw==
X-Gm-Message-State: APjAAAWaeIJXLeBI9GwW2ZK0itPgkwrImRWI5FmqMAMwxVlOJuWeJcKj
 yDt3+dZsPnCIky4emae9VSl7cw==
X-Google-Smtp-Source: APXvYqyRlT6shvGGuaBGa6wDZVua2ycX2F2DzkcvOqz65vwfbi/oGoqVL4gYpCVVlenkRqf02lyTRA==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr37360097wmg.63.1563362549333; 
 Wed, 17 Jul 2019 04:22:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id 32sm18450201wrh.76.2019.07.17.04.22.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 04:22:28 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20190624090200.5383-1-imammedo@redhat.com>
 <20190717063733-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e9f59e59-e436-ee83-a04a-9408494fb4e3@redhat.com>
Date: Wed, 17 Jul 2019 13:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717063733-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2] pc: fix possible NULL pointer
 dereference in pc_machine_get_device_memory_region_size()
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
Cc: armbru@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/19 12:37, Michael S. Tsirkin wrote:
> On Mon, Jun 24, 2019 at 05:02:00AM -0400, Igor Mammedov wrote:
>> QEMU will crash when device-memory-region-size property is read if ms->device_memory
>> wasn't initialized yet.
>>
>> Crash can be reproduced with:
>>  $QEMU -preconfig -qmp unix:qmp_socket,server,nowait &
>>  ./scripts/qmp/qom-get -s qmp_socket /machine.device-memory-region-size
>>
>> Instead of crashing return 0 if ms->device_memory hasn't been initialized.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> 
> queued, thanks!

This is already commit 58164eaff530a1e804f5710936dd37518ab5a90e.

Paolo

