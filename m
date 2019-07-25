Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBEAC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDD522BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDD522BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeUr-0000tl-Cr
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqeUg-0000Tt-AL
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqeUf-0007rN-Go
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:13:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqeUf-0007qv-AK
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:13:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so50934969wru.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1t5HOLAi/5NmpXWksQpkXrrKRh3w3T2Rq+3d2BAT+UA=;
 b=kNa5/E3J2DMCwcR3bpTuCagrBiJIB26Jpr1aGQmgl7PRxkkMcHLvzk2iVGIBQlyxL7
 1aGhB7ytIwbvXGDYyq/OM/yt4qdkgF0UFWTaxUceeQrIxtFP534GNLR6y89Jycp1FlI0
 79LuGVVDea/lxNSqBhX+zV8VRdsw/7lRl1UAfZc8JPsIP+t+JrZcwky4XfYxOkg+1smo
 jlJxY98viaz62DdUggEdvLYnEVLGtJ5a/I2YW0uAuHLDuZCAsL2YeDF0HJLQGqmoXw+q
 yV89IjtB3jBX7C5XUCAQ+EuYhl0zSyDwqiTKLq5oRfyTgSUjoPkdhPSog7SopBCG4FnS
 St2A==
X-Gm-Message-State: APjAAAWppESdqLmSRydCV85Cq3f5UNvRgxwqeCDE64Rj1eIVBuosb8Rx
 /YWYpFvrFXWFe9Yu3CI50TNB4g==
X-Google-Smtp-Source: APXvYqxTBRgRuB46z7+e7oc953H87WYMNDlryAsj4EtcdhhbWqpz2fj9h/0oqnN9jEPO8vc1hbjd9g==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr23062276wrk.229.1564063995889; 
 Thu, 25 Jul 2019 07:13:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id s15sm29941454wrw.21.2019.07.25.07.13.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 07:13:15 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
 <20190725094837-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dd20e05b-b8f0-c9dd-fdfe-3a3804b90d95@redhat.com>
Date: Thu, 25 Jul 2019 16:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725094837-mutt-send-email-mst@kernel.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 15:54, Michael S. Tsirkin wrote:
>> FWIW the "PCI tax" seems to be ~10 ms in QEMU, ~10 ms in the firmware(*)
>> and ~25 ms in the kernel.
> How did you measure the qemu time btw?
> 

It's QEMU startup, but not QEMU altogether.  For example the time spent
in memory.c when a BAR is programmed is not part of those 10 ms.

So I just computed q35 qemu startup - microvm qemu startup, it's 65 vs
65 ms.

Paolo

