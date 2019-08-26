Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5D9C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 01:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A380320815
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 01:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7P8XFwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A380320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i23YE-00026Q-Iv
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 21:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i23XB-0001Zc-IM
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 21:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i23XA-00051a-LT
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 21:11:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i23XA-000514-Gg
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 21:11:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id y9so10260604pfl.4
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 18:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YlVxrPSpJtVUI0ukGunV7p/yIvUAp7XhFNmZCnoyr9U=;
 b=d7P8XFwTZVLINw8ol36XPgsceTQ9fmVIqDVXAd/mwGQAfRvEOB/QtvmWV2YxOwVr9x
 tIp5dcJkxhhmWThL4DiB5vzYaQhvMBxp3WzmIU5FmxbiVYzCmzn4uCwptyP1Rd4nlju5
 UzgJYBO9DZN90dZ2DVmWGL3OlrL5H5gcSv06vBi8TTYcyzuJ11nBkQl22hiruOksFSer
 GXnzG5InmUU6n6tUDuIJO6zt4iaVp4R2xLN3778b5qt5dk/FddLYN4pGFnk2iJISL/Sh
 ZGpmezOcL772WFU9TBGJpgWLSODFO9PXTf64tRV+L0ZhEFOKqguzzXr2Npke9yq7+sBl
 SdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YlVxrPSpJtVUI0ukGunV7p/yIvUAp7XhFNmZCnoyr9U=;
 b=SMyP2DavA0js7tLeOHZm8l0RoHyto21JrqeupMhctgHjLtsI+H5EiPlhPT9nIoC8d3
 jv7BkQm+tZM3q7BIbrE+Y0WhvzAe5Ii4L14PL9n6FcYJJOk7LfooWrV/O1xgfU8QVg6D
 QENSR+9jIZYFUAYeLjhXX9g4VcCwiNN7AEkl2aGzmZ+XFC9FtxVNw5WlT+3HPvvM+4Al
 4QrnQbyKrNHKURkZo9zNsL2nbSsSX9IWLOuO2rV0Y1BtIv28scQ5whEZtqKsFjx79fkj
 Vwg8nticRmPOBrv4DaHCiZMcBkLHCFQvp58DEadRzITai4ljw0Eo8C+voAhvL/jTMgaw
 1t/g==
X-Gm-Message-State: APjAAAXpZLhiHXV6qaNtTmp1TYmHisLKsit8nLLxaGgiE5r0T5YVqH8j
 VEiOsQvGYIIdVyhz9quw7MnDm8Mz1wA=
X-Google-Smtp-Source: APXvYqwaC+lo5LzBGU1/z1VeLh9/LmW989OrDbT9eTPQjgkhR7X9ftqor3fGjMZPijWMWU4Ai2H90w==
X-Received: by 2002:a65:6713:: with SMTP id u19mr13211669pgf.403.1566781858576; 
 Sun, 25 Aug 2019 18:10:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v189sm10115477pfv.176.2019.08.25.18.10.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 18:10:57 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-36-richard.henderson@linaro.org>
 <CAFEAcA8JGUdM5v0MCb98Jw+iJNC+ZMD5SDrPVR0dHGgtMOdk6A@mail.gmail.com>
 <162644ea-ae46-576f-7dea-6696db364c68@linaro.org>
 <CAFEAcA-m76JW2=t8uX6nC8E54TMKLe4nbCGvd8bOKx+wSYRtGg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <516fa14a-2e6c-9496-9318-920ccd164b6a@linaro.org>
Date: Sun, 25 Aug 2019 18:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-m76JW2=t8uX6nC8E54TMKLe4nbCGvd8bOKx+wSYRtGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 35/68] target/arm: Convert CPS
 (privileged)
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

On 8/25/19 1:43 PM, Peter Maydell wrote:
> I'm still confused, I think. The hint space is
> +  NOP            1111 0011 1010 1111 1000 0000 ---- ----
> (plus the more specific hint insns before that pattern with
> fixed values in the [7:0] bits).
> CPS falls into that space; but you've placed it with
> SMC and HVC which don't fall into the hint space, because
> they have 0111 in bits [27:24], not 0011.

Oops.  I see what you mean.


r~

