Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1652DC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FC72080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FC72080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn0VH-0005sO-8C
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 08:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hn0V6-0005RZ-OK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hn0V5-0003qO-S5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:54:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hn0V5-0003q5-LZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:54:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so15105159wmj.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 05:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ukoAT6+gEKpMBwrhcoJ9BUgWWljRFqQvpVWh1j9reGA=;
 b=Ek42vXcMGN7y22lUEf23FkReDgrHHkgQI9FaeM3RxxvHqynRZL1XmXdBjS1I3tlVWF
 cqDvbXWHWw/uUzXNmhWPSVElVFV+C2KchQhSNZdIoTbgkn7mqj9QpWRn5pchtdpQ6xMU
 O/7On8cp7Po4bp8/uTB60s991rJZfYZE4B2kefK+7moE8pez68cBPdx0UDCqCF8kxMA0
 twP5MXrE+FPwDZwoPs3sZBaRH3qcgAUJvsNJ1C3RuYQgglqSqN7cdwt5swhQp0TKZR+3
 ULWWXgTdZ8RthcgLD3XCO/IpPFgdd1ZIBSjFbI1wrbOFx6zXB4fll0LnyuDQZhRVgq/v
 1X4Q==
X-Gm-Message-State: APjAAAWrp6gGchOQG4IiURFh77CvBs5yc0o4dnOg3p+ilzs50GucbtMP
 rw1Drf0vg816XGSofLScKVoCiA==
X-Google-Smtp-Source: APXvYqzt258txbv3xo4lvmO0n7sp/EXIZKfoMUAWLileo3VhVqgyMnAqFfzFbcyl2PK9N1AnzIsJUw==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr22286919wme.95.1563195278465; 
 Mon, 15 Jul 2019 05:54:38 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
 by smtp.gmail.com with ESMTPSA id t24sm16047573wmj.14.2019.07.15.05.54.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 05:54:37 -0700 (PDT)
To: Yury Kotov <yury-kotov@yandex-team.ru>, Richard Henderson <rth@twiddle.net>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
 <20190710092338.23559-3-yury-kotov@yandex-team.ru>
 <1262801563183599@vla1-1374b6242101.qloud-c.yandex.net>
 <50b64ede-13c1-6887-aaef-75ced63aaeda@redhat.com>
 <1198471563194184@iva8-147456c4bd40.qloud-c.yandex.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a0dc0747-27e9-6868-7fcb-6ebf9f797ecf@redhat.com>
Date: Mon, 15 Jul 2019 14:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1198471563194184@iva8-147456c4bd40.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] cpus: Fix throttling during vm_stop
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 14:36, Yury Kotov wrote:
> Sorry, perhaps I was not accurate enough.
> 
> To fix the bug I changed the logic of cpu_throttle_thread() function.
> Before this function called qemu_mutex_(un)lock_iothread which encapsulates
> work with qemu_global_mutex.
> 
> Now, this calls qemu_cond_timedwait(..., &qemu_global_mutex, ...) which also
> unlocks/locks qemu_global_mutex. But, in theory, behavior of
> qemu_mutex_(un)lock_iothread may differ from simple locking/unlocking of
> qemu_global_mutex.
> 
> So, I'm not sure is such change is ok or not.

Ah, I see.  No, it's okay.  The only difference is setting/clearing
iothread_locked which doesn't matter here.

Paolo

