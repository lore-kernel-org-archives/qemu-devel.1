Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E61C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2DD2190F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2DD2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaEo-0004Ee-5s
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqaEe-0003oy-Cb
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqaEd-0001E7-HG
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:40:28 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqaEd-0001CW-BI
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:40:27 -0400
Received: by mail-wm1-f45.google.com with SMTP id v15so44357882wml.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X1EbcAPI/7KRNDcjZ6QWNSHzh5Sd/3nq23pvWAJwe4I=;
 b=FKVffDVruvZmr5uIUBuru0gjsoaNUMn2mJPjZG+TZUSSIKsbzDXhjMcTI99H9FrM7M
 bn3OyuRN/tOjLr165oKOfEIqmnQa/UdHMK2S2nT16Z5gZYLwAw6AUM+uhuaWC4ofUk/d
 Uwbhx3VaL/HHW76+U3btzKpxSnf/IsemR3yOvbuUsBYAq8Gc4PsYbsTE1wVeUraQcVD2
 1ATdHEOghCFWa5uSYO8vH9vI6q4iwX0V52JqCEWnYQwXtbpgWB3BqKLHxqut5AYSqq64
 BZpXfZsRmzqg7vjJodaw9a6s/XRJEG3K3cvyGqD2ZntTca2blk8AS3wMNrN0lMrfuANw
 W45g==
X-Gm-Message-State: APjAAAW786OmqOxhvYjk0gl+Nwc74xVMcBv5WmcYLYqe0dF9Nut3iPDo
 SiZn0IW4XxBJrvEoKwmOeTno1IxQBNs=
X-Google-Smtp-Source: APXvYqzIiIkhCaoCoumrqv6dog0CD6oyXQncQpmSnsgBsl8CD/yIv9S/R/QcRNo6s9yPycPqE/I/Yw==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr73433212wmc.110.1564047626265; 
 Thu, 25 Jul 2019 02:40:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id c30sm86865984wrb.15.2019.07.25.02.40.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 02:40:25 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-15-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f8a13a57-4a90-9a6f-7009-149cf4abdab7@redhat.com>
Date: Thu, 25 Jul 2019 11:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-15-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.45
Subject: Re: [Qemu-devel] [RFC 14/19] fuzz: hard-code a main-loop timeout
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 05:23, Oleinik, Alexander wrote:
>      timeout_ns = qemu_soonest_timeout(timeout_ns,
>                                        timerlistgroup_deadline_ns(
>                                            &main_loop_tlg));
> +#ifdef CONFIG_FUZZ
> +    timeout_ns = 50000;
> +#endif
>  

What is the purpose of this, and should it be instead a MIN(50000,
timeout_ns)?

Paolo

