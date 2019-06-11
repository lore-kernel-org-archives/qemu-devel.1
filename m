Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B4C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20462054F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tqj4ZA9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20462054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hai4B-0005DS-66
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hahwI-00080X-Fd
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hahwH-0001mN-3l
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:39:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:37898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hahwG-0001lL-RV
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:39:53 -0400
Received: by mail-pg1-x529.google.com with SMTP id v11so7087159pgl.5
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6+NSggAW1jVndYD5uuYezxOAeEX1TiyYYrXZXZBN1Q4=;
 b=Tqj4ZA9ZyRsYcne91rdsX86iN2/PUxXYVYKf3Hl1LaKsNMpOAX/OsoJbfHqNZr9uZy
 VP8gPqf90ZnogAuc36gsKTbMKBMzW97G+TqBnFyns8Gqv5U87OPHrMNHkTlqOg7JQYZZ
 XJlF+D2CkD8/fRq2wfw/LCUiDd9TQajX8AUpLcFqbB7UUfaeU00Vuhxo3087jlhGUY7A
 fhtp/bpS1HmoUTQb1wAWrvEUfUAR0c6zAdSqBlTsE8mvr8dMMkCv9XHwzEtIOo3KmbJa
 zdciHWpYCPrQeTQQamZ3EuMoDwPCV8G1Z6mqIteuV9KibLroQmxupJiLxyfBS/DB1+zS
 Xmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6+NSggAW1jVndYD5uuYezxOAeEX1TiyYYrXZXZBN1Q4=;
 b=blIUN007jtMJ38WKCPg37EZRF9BzTUug02eIA0Vj+6hVtldmH2Utig112TXDmneBfU
 oVP79NW1t3oRJddkWMyq5U/yrnoD2rj1qizgJW6hJG4PcFtd87Ejydmp4m2c+/Six8vJ
 JzuMYkdtj/KevckPHJIAuO1hfgMQ7ffc1F/zzX2K8tEbHpEiRlcaIfAOqbh7ST+uq431
 caUFgDf7cUZ8OomnAxki37+Lo3CqVPiag3tb9LSrAYPEPhDn9QnYUSAX9U/5XrfMBPlL
 hgO2vXHKewRMxODzPMRW/b7ccEo+q6j3JnRc3PpAJDfzqYmt0qEBcP6ipnBKgcgULSjU
 pfrA==
X-Gm-Message-State: APjAAAVT79I2Mw12srJnv9qKqm25DgAZBeYER5UPVSU1B7nvFT6wb7lb
 hpZw7Zt9GzMl9tmdwNh3Sf5MZA==
X-Google-Smtp-Source: APXvYqyf6M+b0vPY1ybMbVSYDvojTBZWbpFRZGvINLzw0IUk6RccQXDWY+D+trKxiQEomrDJhHC+6w==
X-Received: by 2002:a63:b547:: with SMTP id u7mr21118180pgo.322.1560263991153; 
 Tue, 11 Jun 2019 07:39:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 16sm13910243pfo.65.2019.06.11.07.39.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 07:39:50 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190610014249.7346-1-richard.henderson@linaro.org>
 <dc37189b-d810-25c3-b19a-486f1a3d5abd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3a74f1fc-4912-3507-b68a-ee6e782bf4a9@linaro.org>
Date: Tue, 11 Jun 2019 07:39:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <dc37189b-d810-25c3-b19a-486f1a3d5abd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/s390x: Fix alignment of csst
 parameter list
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
Cc: cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/19 6:06 AM, David Hildenbrand wrote:
> Queuing it to
> 
> https://github.com/davidhildenbrand/qemu.git s390-tcg-next
> 
> for now. Let me know if you want to send this via a different PULL
> request yourself.

No, that's perfect, thanks.


r~

