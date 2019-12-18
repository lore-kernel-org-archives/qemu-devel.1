Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81503C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CE42176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOBfVgWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CE42176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhtD-0000Am-7b
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhsM-0007y1-GI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhsL-00033W-6I
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:33:02 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhsK-00032q-V8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:33:01 -0500
Received: by mail-pj1-x1044.google.com with SMTP id n96so1534379pjc.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p4xZIPSEISN+K4dVk04GghIr7RQHoYZISOMSsq/1TH8=;
 b=jOBfVgWS4riJLcZ3BxUtj9JjmZ/L/uvDhlVVI8AYjBSwrWLjHmRvV6oEj2zrb22ond
 LzRL/U5k3sgWo5PTgM01uGXMToUfOdwlOl8w4mAQrI9IncSAoJBoyPGGKz98v7aF+NWK
 8775wT9mzWn4pI8OHK3Ipbixh1Jvqnx+CBY6iZ1xIcDBlAikIS4PWLZd5v52uonGnWM6
 OEUFex0/8XiUmVGecmdLWVQH2s3vuJ4kGxMIa5LJuvomC/x/NOEeKNwlOkR2uI41ACSr
 k+MCxDJom4+fB+EeuIQDHNhWNI6InvjtDinbiJnj+eC6z77N0TQy3RK5jCEwzGEMpaFT
 ++Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p4xZIPSEISN+K4dVk04GghIr7RQHoYZISOMSsq/1TH8=;
 b=gqLOcOjr+T1CzrQZqb68smgQrDr7W7tUrCcNEeAcBl7iQ7xbMYBe7AaItogLi7Mf9+
 LKkfpDkNNMXGSuRlfv5CUxTBDo22rmr4+xSuU5WMuYKhYIljhGbRNFjfbgcX6BLQDQqk
 sgcerHr6dR2J9YFeyEz6Qij2UUJhW7DUcLtXDdZlAj8I4Ebxgh99I3JGFcH1Xr9Kwl1h
 5X3WSZVU1rvDuQ5xMTI3EUbuQxtd3CD7svAw9+7ve8a/JFFJK6m+zkS5eQtMzeBRHNS5
 hYyLQsUWZSqJN1kI8Nfe4CcBciG9sRJQy3/HftmgCw/5XerQcBhjvG941Ok0onRwZm1/
 b+tg==
X-Gm-Message-State: APjAAAVRMr51COKTj40o+ukhypZm6gqP5mtLPnrPBcBYB5VaETphXFbt
 9+V2cGkhNtH5Xhud8M7iXB6jwvqtKHg=
X-Google-Smtp-Source: APXvYqyinlZ8zI54zXfY4kABCJ75CeoVqYYuIXJM4HAJpWx1SqF50uYDYDXk8YfXERjJURlzlh0PSQ==
X-Received: by 2002:a17:90a:1b45:: with SMTP id
 q63mr5823123pjq.118.1576708379708; 
 Wed, 18 Dec 2019 14:32:59 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id r1sm4392660pgp.15.2019.12.18.14.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 14:32:59 -0800 (PST)
Subject: Re: [PATCH 0/7] configure: Improve PIE and other linkage
To: Fangrui Song <i@maskray.me>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218072854.3j3sld6dsikgqjtx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96a57644-de4c-71e1-1674-d28e943d8aa6@linaro.org>
Date: Wed, 18 Dec 2019 12:32:56 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218072854.3j3sld6dsikgqjtx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: philmd@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 9:28 PM, Fangrui Song wrote:
> How will this patch set affect statically linked user mode binaries?
> (qemu-user-static packages on Debian, CentOS, ...)

The statically linked user mode binaries will still build, and should still be
able to run any guest binary that could be run before.

If the distribution is new enough to support -static-pie, then that will be
automatically used.

r~

