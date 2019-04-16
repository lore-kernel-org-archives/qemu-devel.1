Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A336C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B68B222B2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B68B222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOVC-0005e9-H4
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:51:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTS-0004YJ-E3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTR-0003W0-HZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:10 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGOTR-0003U0-AW
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id h18so25577934wml.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=r1t+OT3mUM1BI+wUEUXMbsq+iTI2+j4lbilNdynnk7M=;
	b=h+EgOOjZHcVgVUwDxRXBYbYLg2qRBcdUwuDUmUWAcjZtFW3UJ/s3w1r9d2U1od6j70
	7RDgf9ViQ1iF/7oN6veEyMpGyQDEls417ryASoXDadXCE5NXCtQw3kBImwzcpP391Tsh
	g1Plu2rPTMrgA7D6tPspW48CsLZzYNgz7H4WjI5i8N/Mfu7DmbUTxuQtFS1kpTWpmwGY
	AEVIxkC4aHTa1Ebq9ZGGfmf9W6toPkEJu+lcTgCk8qRdxUQGAzYlbiuRCRKPgMFssjCl
	zAoKqtoRulTs7H8WYmpFKsUoO7jvYKCJ0b2KXGy7ZIOU/c+i2bmYJdfcJg5dTRbOdx1a
	7rUQ==
X-Gm-Message-State: APjAAAXZKUvn5ERmi292DU3btbzQOGjE2mH0nvoGz9mNJWgP9BGpde89
	5Wm1QjMsiaat2TDrzBgwYvfWm4fCJ+Y=
X-Google-Smtp-Source: APXvYqyGv4QUxszJddPzAksbxsmdSrDHai3ehsHtSKaENiGdqSarStZ68zmDcf7BkvlPNYzSzpOazg==
X-Received: by 2002:a1c:20c1:: with SMTP id
	g184mr27197812wmg.137.1555422608143; 
	Tue, 16 Apr 2019 06:50:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac27:aac4:c65c:6eb?
	([2001:b07:6468:f312:ac27:aac4:c65c:6eb])
	by smtp.gmail.com with ESMTPSA id
	l12sm59969555wrt.31.2019.04.16.06.50.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 06:50:07 -0700 (PDT)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190415135746.7571-1-mlevitsk@redhat.com>
	<20190415135746.7571-6-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5dcf9e5b-f715-142b-63f7-566facb12263@redhat.com>
Date: Tue, 16 Apr 2019 15:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415135746.7571-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.44
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/5] block/nvme: add support
 for discard
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416135006.9MFvW51-Wvxl--4Xtc5ghDCC-Q9tTC0UAf1XfR9lETY@z>

On 15/04/19 15:57, Maxim Levitsky wrote:
>      .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard         = nvme_co_pdiscard,
> +
>  
>      .bdrv_co_flush_to_disk    = nvme_co_flush,

Extra blank line.

Paolo

