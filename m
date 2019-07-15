Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C87EC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 18:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3394220665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 18:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3394220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn5hL-0006lq-7z
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 14:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hn5hB-0006NS-I9
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 14:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hn5hA-0008Gt-3R
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 14:27:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hn5h9-0008Fu-T7
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 14:27:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so12068529wme.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 11:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7FMuusPeHRXJZnEs+lkTRiMO9e9+O9n+2y+Pgw1czR4=;
 b=pw+c6JDrJX6KdOZUQGxgHAVOI7SAAIaaeD3ZspyquPrC73s/kDg2vvdnyfIH4OyB+f
 k1zuKng85ffXqJjvU7ma1FKThNjRba2Rs0SfpSZwv5SFa1/zv2jTO1tT/ABZOpxf0NEI
 A9X2Gm6rF7FAVGxLQcs2oB2um+KpDDcFr5+2c+wIziywlCgMxzfv9OUayIDN10yB2YmU
 kAjfQP9LTRp/MgBv0B3sRRKnhwQxHZ78MC922VMpih6n47E0guvWU8u94rdfe15JLunR
 75vpnk3NaqZzw25yoz4nmnJF4Ui6jrHxozgAbeIdnBmtpVdC3TE5Y0rhiQMrAsXj8qOO
 OfUw==
X-Gm-Message-State: APjAAAUu0qPbh5iml68mO+DY8YtoviY6FYkVSZhg88XR8/wZDu3WoBEU
 oPbf3AmlzRwjP6+CsQEU28bhBQ==
X-Google-Smtp-Source: APXvYqw3Bb+/aNlb82gprRXYtjE5Mv2LgQUIgAVfJsCVFiydNznTQbCYex/R167dqga8U373wpds4A==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr23956921wmk.136.1563215246320; 
 Mon, 15 Jul 2019 11:27:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b159:8d52:3041:ae0d?
 ([2001:b07:6468:f312:b159:8d52:3041:ae0d])
 by smtp.gmail.com with ESMTPSA id h133sm18341738wme.28.2019.07.15.11.27.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 11:27:25 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
Date: Mon, 15 Jul 2019 20:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
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
Cc: marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, rkagan@virtuozzo.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 19:23, Max Reitz wrote:
> On 12.07.19 21:17, Andrey Shinkevich wrote:
>> When tcp_chr_disconnect() is called, other thread may be still writing
>> to the channel. This patch protects only read operations that initiate
>> the disconnection.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
> 
> Have you looked at
> https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg06174.html
> already?  From a glance, it looks like that series supersedes this one.
> 
> (No, I don’t know why the other series is delayed.

Because it broke some testcases in tests/vhost-user-test.  They are
disabled by default, because AFAIR they broke on some CI environment,
but they are supposed to work.

Paolo

> I keep reminding
> Paolo of it.)
> 
> Max
> 


