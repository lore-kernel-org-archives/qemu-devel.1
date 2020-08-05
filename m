Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5CFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D4921744
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf1T2c13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D4921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3F5z-0000Uz-DH
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3F58-00086U-Kg
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:47:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3F57-000062-2y
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596617248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPzHiRCQIBm6m1SbM6dI20X9cTUcQeydWc0V/h3Ar8c=;
 b=Uf1T2c13vYrG819TVjPrjhm2Wds/14h+xX1UnlrsV13R8Qm2s/w3oenJ6HXa3pg0HEAmN7
 k5xViEcs/+SLEq8ArTApcgp2mbnhnKPY4HJY/NvaGvLK1PASnWPxg1XzYvDAn2wVvk72V9
 3xRQ9V0cR3lerX6uAw8ZZUD9a2q2/c8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-PWZzpe7PMGi6DPFKJw4FVw-1; Wed, 05 Aug 2020 04:47:26 -0400
X-MC-Unique: PWZzpe7PMGi6DPFKJw4FVw-1
Received: by mail-wm1-f72.google.com with SMTP id s4so2193407wmh.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 01:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qPzHiRCQIBm6m1SbM6dI20X9cTUcQeydWc0V/h3Ar8c=;
 b=WPxKlkVapiI2uM2aKO+Wu5AstmsCCk78s9kOUQBErJdrRbqFZQ+Lqe/nX9HmbkdhfP
 58lfLt3GYpno4nuIb9bMC1m/JpkmpkFNvqu3y2mOvatdq/SZ3PA4kZLlC+QyhkjEMGfg
 VjjIt1B8PQfeDptpxlsjPNTFamM34VyjHAbQpSuQFFpirlgEeUxZq9QabpomFD1WXe8Y
 j1dVlGq0ookrHcASLPe/6vT7/e5Kj9afD1nN42+IHjKQ4nK01q8napEgd3vsPFRF/ma/
 DP0dZmMRyBxb7vJg2w+BhpdM96kM6CMboqt+rosCAUgnq8fibXJoU9bWDWi1fBvHi3Bn
 HPmQ==
X-Gm-Message-State: AOAM533c1XzCh2Z7MFI0HLHf2qrtjOByQjoijJEWoh4NBG/J1lAWdCRq
 iwSwW3SpiuNpeIZxF9xYyBmUIJuziYjt5nVj0H1fMr2mmswF16ApW0qu/KFYMwjuI084z9hpeW0
 rHQStEPZmR8eTMBg=
X-Received: by 2002:adf:f5d0:: with SMTP id k16mr1784280wrp.78.1596617245793; 
 Wed, 05 Aug 2020 01:47:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYLaKwpMo2BxNbja9T1zt6WNUgJXkX992vsyBlE1OTyUVOkdSqxGxefLpPlpeCRsItKuQusA==
X-Received: by 2002:adf:f5d0:: with SMTP id k16mr1784254wrp.78.1596617245593; 
 Wed, 05 Aug 2020 01:47:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id y145sm1898551wmd.48.2020.08.05.01.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 01:47:24 -0700 (PDT)
Subject: Re: [RFC v3 2/8] cpus: prepare new CpusAccel cpu accelerator interface
To: Claudio Fontana <cfontana@suse.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-3-cfontana@suse.de>
 <cf676419-09e6-4c36-c511-031edddf8cba@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5594481c-e887-e48e-630b-c9ebbe542212@redhat.com>
Date: Wed, 5 Aug 2020 10:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cf676419-09e6-4c36-c511-031edddf8cba@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/20 10:40, Claudio Fontana wrote:
>>  #ifdef _WIN32
>> -    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
>> +    /* Eat dummy APC queued by qemu_cpu_kick_thread. */
>> +    /* NB!!! Should not this be if (hax_enabled)? Is this wrong for whpx? */
>>      if (!tcg_enabled()) {
>>          SleepEx(0, TRUE);
>>      }
> 
> Looking at the history here, I think this should be if (hax_enabled());
> this check was added at a time when whpx did not exist, so I _think_ there might have been an assumption here
> that !tcg_enabled() on windows means actually hax_enabled() for eating this dummy APC.

Yes, that matches the condition under which QueueUserAPC is called in
qemu_cpu_kick_thread.

Paolo

> Probably it does not cause problems, because whpx does not end up calling qemu_wait_io_event,
> instead it calls qemu_wait_io_event_common. But it would be more expressive to use if (hax_enabled()) I think.


