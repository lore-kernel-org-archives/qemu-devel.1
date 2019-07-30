Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236B9C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA6D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA6D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsXiI-0007oq-6t
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsXhT-00072v-B5
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsXhS-0000lm-EV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:22:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsXhS-0000lC-8R
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:22:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so36283560wmj.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LoxzZqL4rhHsJTxBksx+F5wXjx24fSM9vNw+iyy4BQU=;
 b=dIf9gTvGwaWpEZFNuH1hcAxQ2Jy8oQblFr+hCHxHahKXO2z5IOPocOfWR9t4BvtZRp
 aRyjdgmsvG78H+EYTJVtCxxFfyhcJ5/QmVPGTpw/nrJFUU+V9m+bQYug8/Id3P9bbaye
 jMEogy9CYWx649SrhEmaD6WdN4MnG8wLGWeOyvQrxXHLJcFJgv+trb3VNvnKBDSL1f8k
 oL2+o/xoZ0l3S4BVVS7tsggjfbcF30EERBozeiGQ+b1CMmrdWYo39G1Ha8CPv6u2tBbv
 aTXCB945+Kf9ljEPAs0hrFj3At1uVSfGfyG6i5EaLFk5d8sIX6RZYzpfoGv3ja9CDHX1
 tjbA==
X-Gm-Message-State: APjAAAUPggTUSlq5tfCJ2Zk6yLJxvLBUmr3yw0qSFGv3fPYdVdzD9yPG
 pTZkspbQkNj+Bg0XOJ24y1qJIg==
X-Google-Smtp-Source: APXvYqyFy1aLUMyEsySGDUGajP8VOabfhm2ghFvA90w3+/SyneqYZnpsW4CjvlPmMn33cc5PtNCNRg==
X-Received: by 2002:a1c:6643:: with SMTP id
 a64mr109438149wmc.154.1564514537202; 
 Tue, 30 Jul 2019 12:22:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id 5sm53607581wmg.42.2019.07.30.12.22.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 12:22:16 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7a78ef04-4120-20d9-d5f4-6572c5676344@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b876f6e4-5469-ae03-2a8d-d433ec35d735@redhat.com>
Date: Tue, 30 Jul 2019 21:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7a78ef04-4120-20d9-d5f4-6572c5676344@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, ehabkost@redhat.com,
 kvm@vger.kernel.org, mtosatti@redhat.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com, den@openvz.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/19 18:44, Philippe Mathieu-Daudé wrote:
>> +++ b/target/i386/kvm.c
>> @@ -190,6 +190,7 @@ static int kvm_get_tsc(CPUState *cs)
>>          return 0;
>>      }
>>  
>> +    memset(&msr_data, 0, sizeof(msr_data));
> I wonder the overhead of this one...
> 

There is just one MSR in the struct so it is okay.

Paolo

