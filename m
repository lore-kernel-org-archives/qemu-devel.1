Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC502082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuD/BKRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC502082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdHb-00026Z-CX
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihd2O-00021o-2O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihd2M-0006Qi-I7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:23:03 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihd2M-0006NJ-06
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:23:02 -0500
Received: by mail-pg1-x541.google.com with SMTP id b137so1616574pga.6
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 09:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FLjdwlWE86qvzQqaumsaYbMcoZhbBA7AuVdW1jQzzJ0=;
 b=BuD/BKRG/6RxcBxKt4weZqgH4kJt7w9VAQe/fO9S+d6Lv3HaZaP3FLA0fp6DmoxK/R
 zn8ckHUQr5tYU01EzjsmLPZV+kSzbsZ2Pki3M9kXQPZy8nTkoX89MjOIgffSXQ09C9JM
 Nzodls9v85BBt6IQJUj9mkWPSf3mKPqiEjQOjzRGNAxE/YxvT4VNiRG6h5IhdgULb6xL
 xO2ovi5fLdggk4XbtSs9H7gkH3d2DtFc6Y/SX4MUx7Ot21LFlkFICRqpMTcq5+6KBoDc
 jZ1zZcSvpIXw4nrYb5hOYl8/R1h+tFHG1fqgWiD6JQ0VSZLeidxHQSwn3P2EACwdN8tN
 SiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FLjdwlWE86qvzQqaumsaYbMcoZhbBA7AuVdW1jQzzJ0=;
 b=fCYJWcqF602E8wACaYSdaLIxgat5xMZekmSR2bY3vtKM3Bb7QrCZEbGHcJK3aAW5Ck
 HCa9W3+jJuh801ndlxgpf4lUtcSF65o/DODGJ0/3uzVEdCDkQ3nOAuzE2r8MWzf3l382
 h0OjQPUPAaBu1sfTT0TnvMtdvZ160oPn9JQiot/VVUwlzyzTw2uArT7F4Pc33xaz8RU+
 tRp8gg7qkmwQ/3W1tTQZay4pjEzQ1aKDF8f8zCspLa+xKemF0sc1dqPkLqiCvUY8+UhM
 F8UHizHedG+GAQrnu3GnO/dysUqMn06D3cH4cLP13c1A3b347thAPlLkkJcb1Ay2/nK2
 3JaA==
X-Gm-Message-State: APjAAAWNMI/G983Nlb9Ho5BMFFRNAIby81/MRHhTU0oLdsISxTcRYGAx
 LsGdZ5SET+H7wuU9Pe0ecEwkJw==
X-Google-Smtp-Source: APXvYqzTLUFEuIYqm5RS3zZEQWSdthIanP9wE0UraNldcMLxjf4+V8ZARyRF9JYzea47OWvKsU7U8w==
X-Received: by 2002:a62:6243:: with SMTP id w64mr4360915pfb.48.1576689778839; 
 Wed, 18 Dec 2019 09:22:58 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id i4sm4054188pgc.51.2019.12.18.09.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 09:22:58 -0800 (PST)
Subject: Re: [PATCH 1/7] configure: Drop adjustment of textseg
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-2-richard.henderson@linaro.org>
 <881947d1-a9bc-f027-bd53-3abeea59449d@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a973e93-9ae1-0b37-6b10-854794bcb4fe@linaro.org>
Date: Wed, 18 Dec 2019 07:22:55 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <881947d1-a9bc-f027-bd53-3abeea59449d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 8:59 PM, Thomas Huth wrote:
> config-host.ld is mentioned one more time in the main "Makefile" ... I
> think you could remove it from there now, too.

Done, thanks.


r~

