Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4BFC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B436E2081C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B436E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2iS-0007by-Qw
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:13:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT2ZD-00005M-2h
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT2ZB-0005in-4a
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:04:22 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hT2Z9-0005gU-2M
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:04:20 -0400
Received: by mail-wr1-f42.google.com with SMTP id f10so2680087wre.7
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 04:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9cO28ZY3heOpoI/aQ0aboxDuda1nejILeJijZOwKMng=;
	b=LNiIMNCChoHqw7tAvw+n6LXFlbvUdghxFkwloEIe4HQE3P8c9CprJK78C2PUcQBMlB
	BZ0bLjJEaLULkdZQ04LZ5nVy26yisCx8ls+J9Bex2P37ly7Z5uJzSwo8j6V5brT29YdC
	qsbkqvxnCrWvjA9a39bPKhQHQnbdaJ6cZ2GAwYzvGg8qjsKDUv4xcCOgE9tEOeKJlGA+
	vhykI9dcYOG9nmptScU1Qt7duFnGsPwIEO3IHmMVwvHladAwQWMQim8+UreSilOGPEpl
	3UuDO56imSq2eM1EvGHWYr9ML8trd+5r0eiMJGtXKD0y1lYa7C3GySgAdtsFEypJ9A/9
	Ridg==
X-Gm-Message-State: APjAAAWG2DsKlAsuGMwJIysngGbJ5nwlxAoP5Wr+dKmQddFKPXb1v/ne
	YllvrtMK2sbNp/149mzrS4qmPA==
X-Google-Smtp-Source: APXvYqwOeefPGdlZL5BJQl0fAz0dSqwlZbbnxye5BPAh/wwjNZR3pSvYCu1se1SxXmuaXNbWg8vRag==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr17629669wrn.235.1558436657919;
	Tue, 21 May 2019 04:04:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	h11sm26701026wrr.44.2019.05.21.04.04.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 04:04:17 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190521103650.18479-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0630a607-9216-6b75-54fa-0a1308f2eff0@redhat.com>
Date: Tue, 21 May 2019 13:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521103650.18479-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.42
Subject: Re: [Qemu-devel] [RFC] scsi: restart dma after vm change state
 handlers
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/19 12:36, Stefan Hajnoczi wrote:
> This is RFC because I am waiting for a test result on the system where
> the bug was originally discovered.  I'm also open to nicer solutions!

I don't think it's too ugly; IDE is also using a bottom half for this.

Paolo

