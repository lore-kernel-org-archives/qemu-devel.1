Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5883C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92D120867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMc2-0002lL-BA
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iGMDZ-0004nl-FC
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iGMDX-0006sI-Kq
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:57:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iGMDX-0006rW-ET
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:57:51 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41B20796ED
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 11:57:49 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id a189so1981726wma.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SOiPGYJGI/JNSb6E3x3vKGwWs1DLS5EVXD4POQk1UEE=;
 b=RfD6TSSwbb/ki6hUYdh9RuYI6BptfwlEbg17i0tthivmyeZTnw0ygQdWfMpSwVQsT2
 uinCUeLeD1jOb0CMy7cQamrKiKtRZOxdy8l1HIqSXap55BY9YL8dTf5/rFQ3eFdTCY6N
 WSx3gVNqkNo8gof/ESzBLoIREuwww89FsnZsal9HcsplXolXpBO6sHgDErCYbN9Snm+d
 ChHQP+mAEmgGQpITPqL9Kj3ilWtUqSBOk/wY4NDOHCDCPHok6H82A7TtToyTJddNqYzQ
 9FSZD+aMoGAkeMOAMSoE27fFpkEZG1FZgsnr7ZXlsP7oaFigO7FMxlph2lwnfkTy15Fa
 dq9A==
X-Gm-Message-State: APjAAAXcEhRs7A/Dba6DeqYCFI31NRVuNaUzhw3SqEPMxUkF3xCjJxNs
 t3YvvJLOAsL7rIKC+Y8uQQoAxh/coo+n7mpS2V2wHdpxw0U78b+9nSoHGQKXXjnPQ4/ladMGdkl
 CD1zdhFJ1ka6QeuU=
X-Received: by 2002:adf:9068:: with SMTP id h95mr10641432wrh.253.1570190267955; 
 Fri, 04 Oct 2019 04:57:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUjSLFQDMWNHkEk7CbokoZoqB4Gpn19p4jOVds7/Le5134malNSYjDhVJPZTloP8cf4OcUJw==
X-Received: by 2002:adf:9068:: with SMTP id h95mr10641418wrh.253.1570190267719; 
 Fri, 04 Oct 2019 04:57:47 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r18sm7032623wme.48.2019.10.04.04.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 04:57:47 -0700 (PDT)
Subject: Re: [RFC 0/4] transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191004114848.16831-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2edcfdab-0682-2728-2632-e4f5bb6cd7e2@redhat.com>
Date: Fri, 4 Oct 2019 13:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004114848.16831-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/10/19 13:48, Peter Maydell wrote:
> must be between matched calls to ptimer_transaction_begin() and
> ptimer_transaction_commit().  When ptimer_transaction_commit() is
> called it will evaluate the state of the timer after all the changes
> in the transaction, and call the callback if necessary.

Could ptimer_stop/ptimer_run act as the begin and commit functions?
That is, ptimer_set_* can be called only between ptimer_stop and ptimer_run?

Thanks,

Paolo

