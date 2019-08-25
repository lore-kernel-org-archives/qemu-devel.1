Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B46C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3E7206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMFPxPCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3E7206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1wVo-0005Z3-Nw
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 13:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1wV6-0004yA-W7
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1wV5-00041A-TQ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:40:24 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1wV5-00040p-M1
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:40:23 -0400
Received: by mail-pl1-x644.google.com with SMTP id h3so8669957pls.7
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sAmuH0M5oHYHZHUYrS2Chduuiio5yOTZOGpIGOAhDtw=;
 b=tMFPxPCVq00sKYoVY30VHzUl3V6w2YXcvcPvYzN7b8YC6wMBCLijpJJPTgwYNeuI6b
 C1AzHjYEVeadaY3QtWKwdsBS4I7qPZEPam8QAHBcAsAmWLEGhV9go6NDRBSs5znApPka
 RqLFoHHQlI6OdR53iL2ucjYE3JbRnlbsdXlzPo1oi9o18VtHnyyc1aHQ2s43/AlGldWn
 ZcWiM68wvgR9t/2vvhoFM0Q2WPd7IGQXkvMNtUyYtwCzeQiLUHIClbIREI+Jin0dju6F
 GiAMHLuKy8NMfsgzKkOI3v/5hJlaJRnnzTE4cvAMsHcfLMX1Mstvz13Mqy3NsBHd/3zS
 ixTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sAmuH0M5oHYHZHUYrS2Chduuiio5yOTZOGpIGOAhDtw=;
 b=fMVEjaPD7M4LgMGWX241ywI9EYTTi9GPLABpIHdnkwGnSQZHjyjJoKbg1Jw9bdRnAE
 JZ9AwlGU79S2HpYMXLZ0kh3tnY93UGOW30WJwfo+Lv8nhuiKIHPGgzV6gxlDyRsC2UZ0
 W76q8hiVybxMzQlXP5pWBYtKnyJhuzaGxvuKhJ8Axt49G6WK3GeldLYLdU/nTudJSEho
 3dzMPNuriswsOimx8ze9LwJbfBwAjvuCyoUUzzcUCtmucwbGa6b+Givi756FnJ26dm2/
 fy9NDnaz/TNpUawI9wunFZeLnToZWoNMaIi8i+ZmUAjoYJFMLmXgCQIR1JAhnc2tezdE
 IpvA==
X-Gm-Message-State: APjAAAWz6S7TS0WAynqUUXDXnQjfQLQmSW3OjLYqTgWJYbau9dwJlXEr
 iyhu4bQ+dqK1rz56rp80nuUDaq9YEaY=
X-Google-Smtp-Source: APXvYqyF53q6usO+m8ILgoXuDC4esKLV99hfAVFSjkOXoRbmxVHTOxOE1VProEWfFU7oX7mNWSV2ZQ==
X-Received: by 2002:a17:902:650d:: with SMTP id
 b13mr14877928plk.90.1566754822279; 
 Sun, 25 Aug 2019 10:40:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r23sm10222491pfg.10.2019.08.25.10.40.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 10:40:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-36-richard.henderson@linaro.org>
 <CAFEAcA8JGUdM5v0MCb98Jw+iJNC+ZMD5SDrPVR0dHGgtMOdk6A@mail.gmail.com>
 <162644ea-ae46-576f-7dea-6696db364c68@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <136ef143-bc7e-815e-c3bb-ade24eab7d13@linaro.org>
Date: Sun, 25 Aug 2019 10:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <162644ea-ae46-576f-7dea-6696db364c68@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 8/25/19 10:28 AM, Richard Henderson wrote:
>> CPS shouldn't exist at all for M-profile, but the legacy decoder
>> got this wrong too, so we should put that on the todo list for
>> fixing later (along, maybe, with UNDEFing on some of the
>> unpredictable combinations of M/imod/etc for A profile?).
> Fixing m-profile is just as easy as as commenting.
> I'll leave a TODO for the unpredictable combinations.

There's also a missing check for ARMv6 here.

That got added later, with the T16 decode.  I have just added the
following to the T16 commit message:

    target/arm: Convert T16, Change processor state

    Add a check for ARMv6 in trans_CPS.  We had this correct in
    the T16 path, but had previously forgotten the check on the
    A32 and T32 paths.


r~

