Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845E5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5089224670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdtwLTO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5089224670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIfb-0005gV-Ne
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idHm5-0004o5-A8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idHm4-0003Vx-1G
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:52:17 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idHm3-0003Rn-Oz
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:52:15 -0500
Received: by mail-pf1-x442.google.com with SMTP id 2so3694958pfx.6
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jZqGBmvPDmURBUSBxW8KFM0RMQPRjK96Q/0sLdCKuNw=;
 b=cdtwLTO4PWD5Aho55YBdZ2hnmz3j0KLag4W7uhUQZliwIClFQH63hsdcqp1PGZBkR7
 CDnl/MZTVPSAnkE0IoYP+8G93HO9phXzXH8GL29frrbpdw4m/FJkhd7a94/zjMgB86Aw
 luEW3N5GigWhpq/NexujqSpmFNRwFQsipz+3iTxfQZWFmePZezXgXV3zPFptqFsI3xu9
 dkZR23VonXMur6INdrvDXtt+5T87/dEKGVpdM5jm0wbfey84ocpkMeUw0Dnvul8dwudA
 qCXazLQp32ohO2F7SxMXK8SHwsdWT8qsjFNru8D4UB44OXEmFDhFZBEsNmqrscYZlA8o
 hzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jZqGBmvPDmURBUSBxW8KFM0RMQPRjK96Q/0sLdCKuNw=;
 b=JkWgWumYLxJP8zQTwVWVraJ45FQ/YR/oN+16g5VWcL/02DXZanOs4OBRWpG3tNPynd
 HHbyVG/kc5iOtd6sXnHmRVRR27egowkEUJAnnxU1YF/WgObw/Imyg/itbeEnDIc4PAl3
 EORXX98sbVpzFl/n/rRiHkYw+RVzyAxihAS5lRb7ekO8KV+htoKmPvNBSvFEHfCaKjEN
 35FaqWIQ1QrFZZtVWiwsaWr2GhqlPamoPRvFuKIctXtZ07XIWRVB9q/n9v2ruzC579ta
 3npPE9dv+DfCULUmpqlkBLCZpGP7AIZvMlaEbhvq0OfjKoKrCGtHiAMVAarP7MrvoWtT
 3MGA==
X-Gm-Message-State: APjAAAWpN2QmexCPW8h4lFjXWsV/PyTG+FojPSb0zR1FYa+xE9Ucbd1+
 by21qOjPCAFT1ix9W5FhY6leXWUEDLo=
X-Google-Smtp-Source: APXvYqyNM6042g6nSWXJSt6Wo5TURv6Mw2RK59jqXCHRckZOTTnv4a0gq+mU/7PrpWhZ63mQQdAPnQ==
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr4724216pgv.55.1575654734273; 
 Fri, 06 Dec 2019 09:52:14 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w11sm15823707pgs.60.2019.12.06.09.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 09:52:13 -0800 (PST)
Subject: Re: [PATCH] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191206122247.7507-1-alex.bennee@linaro.org>
 <CAFEAcA9S51DWqysHbO42CjOhZBMA4qwN2zT+isOmWFtH5G8N3Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0bbc14b3-ad57-5580-8707-b6c614fbcdc2@linaro.org>
Date: Fri, 6 Dec 2019 09:52:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9S51DWqysHbO42CjOhZBMA4qwN2zT+isOmWFtH5G8N3Q@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 7:29 AM, Peter Maydell wrote:
> On Fri, 6 Dec 2019 at 12:22, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> For system emulation we need to check the state of the GIC before we
>> report the value. However this isn't relevant to exporting of the
>> value to linux-user and indeed breaks the exported value as set by
>> modify_arm_cp_regs.
>>
>> [AJB: the other option would be just to set reset value anyway and not
>> ifdef out the readfn as the register will become const anyway]
> 
> If you want it to be const it would be clearer to define it
> with ARM_CP_CONST... I'm not sure what an ARM_CP_NO_RAW without
> a readfn or a fieldoffset will do on reads.

Yep, and the accessfn should be ifdefed away as well.


r~

