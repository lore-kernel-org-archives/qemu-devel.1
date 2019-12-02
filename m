Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA83C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05CF20717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLrfKxMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05CF20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqK8-0008VP-2W
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqIy-0007rs-Ob
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqIx-0005OF-Jl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:20:16 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibqIx-0005Nt-80
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:20:15 -0500
Received: by mail-pf1-x442.google.com with SMTP id q8so49776pfh.7
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XiEkiwc2tuADIEHquCMRyxeTb3JCAhb47wvL9K3SyTE=;
 b=GLrfKxMoeTdIZ03m/XIqfzfv9JXdTfsbdGEL74EqcG2NuWHrOgLcMv1hJyjZrllckZ
 QhofGrDKamgQHokuEfiGwmCBUbUiN46ju+MiAsP5LCpfYuhDuduGAI7DeHKHQ5W3fpDA
 NTIiLSPYUqVGs3qT8BD37JakhF+cdlOGRO8tOW3WKlBUk/xzYgMIx/dBvRiq0wMJB6Qj
 Rnm5wTw0e3lJAvr27S7Q/WJk0W74cS/nu8g9Tx7ETGqjn9lE37yTSP2Af0BucvOM13bA
 6Pp5PjTNfzyExwecfBOLu+VmsYoAlAZZ0fSo9e1TIXmUxrPf33wyDNqJVDKoO9l0h3IQ
 rwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XiEkiwc2tuADIEHquCMRyxeTb3JCAhb47wvL9K3SyTE=;
 b=Ody3YVuvcJF1Ze228XSLNMcu7dlR1EJmB2eSbwvdgcT27rl8+rJPaX1dgFd9u2L4j/
 IcQ8gtdfELfFP9ROgwZcXc2AetTMS17hdkUnHVl5mvhOd9hWZ7LMCgS36XtmKbdVygpu
 VkmSnHfFoSINtqdzKp2lkk3rZntp4cHv6rRqqP+qAxmRw4LPXsu6sid1HVxmrSL6hJxY
 BcJqynmTgy89e0brqt+F0F+yJTo0bK6NE4IoQ2F+CW88UsFCsvXuwpkCEVHZUdNP32V2
 JwHuRdbrCpcbqhm9jGhw/S5BSSO3lMb0RSURLQe1/SdlN64KrGgcWuov8mcKHlxEdzbv
 4VWA==
X-Gm-Message-State: APjAAAW0Iovu9PbmBAIYJGdYwoII2GtdZueVOQxhNYp+V0PBIqyLKHvC
 CHjrKX20QgJnLiPlrFQ3lFMpZw==
X-Google-Smtp-Source: APXvYqwjOrTbh7HE/MCCt5Up/eV20HFXGwEAZ4OmGZGEv4RpdVihhUGSee5fcsHXFK3VzxrKT6slkQ==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr351694pgh.383.1575310813596; 
 Mon, 02 Dec 2019 10:20:13 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v26sm153972pfm.126.2019.12.02.10.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 10:20:12 -0800 (PST)
Subject: Re: [PATCH v1 4/5] linux-user: log page table changes under -d page
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191128194603.24818-1-alex.bennee@linaro.org>
 <20191128194603.24818-5-alex.bennee@linaro.org>
 <55396b80-3bdb-c15b-e1be-0a4b8222ac82@linaro.org>
Message-ID: <582f8169-d8a3-2e34-a7f6-7f6e99f9e18e@linaro.org>
Date: Mon, 2 Dec 2019 10:20:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <55396b80-3bdb-c15b-e1be-0a4b8222ac82@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 1:26 AM, Richard Henderson wrote:
> On 11/28/19 7:46 PM, Alex Bennée wrote:
>> +    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
>> +        qemu_log_lock();
>> +        qemu_log("new page @ 0x"TARGET_ABI_FMT_lx" updates page map:\n", start);
>> +        log_page_dump();
>> +        qemu_log_unlock();
>> +    }
> 
> Hmm.  The language used here asserts a change, when we don't actually know that
> for a fact.  It *probably* adds a new page, but it could be overwriting an old
> page.  Can you find a better wording here?

Also, if you're going to do this, you might as well instrument munmap and
mremap as well.  Otherwise we're missing transitions.


r~

