Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95486C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587382083B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjk/B7JI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587382083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKSPX-00012g-EI
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 15:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKSOV-0008Oz-QJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKSOU-0001qm-F9
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:22:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKSOU-0001qR-59
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:22:06 -0400
Received: by mail-pf1-x444.google.com with SMTP id h195so13094320pfe.5
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gS5DJOq4yokoePkYEH+TNptCCcMtGslOUl4OrY19GzE=;
 b=jjk/B7JI2lacPP56OmmhISHJyeKm6l7clzvrl52dqrhE+9QNL5jD7y/JULM45g0nAn
 xfJWBopM98j60NoDgWcMJd5aRZubyIh4Do4MQMRzr64rcwDQOb2U5XeQF5hHtJo42teM
 5bwOXo0zLNLDwFoejFMc+AXefMpexY2pPkY4uUYdrsMKfq265B1QnKPlJ4JtgDOA0YUA
 0Mb5ZMpPqLe2EuzYANgqAnI4M2F9ELeOUObfYv2VdzjotoGMrBy95+2cFmRDZk95jUgN
 wSqJIKldUdnOil1tboCBFiF+US+lgpCo9iaN+beNawc489AwgOI0/nUL28cMrKih0TiW
 hsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gS5DJOq4yokoePkYEH+TNptCCcMtGslOUl4OrY19GzE=;
 b=VY2s053LxVHY6xlqMejiDiWPRycaaRQ7/3STUx/K0tDyWus4MdSVeUaHRy1q61YZFE
 2xBPKF54pqvu95gdhhmoDbIL1v2YuZcCW3dJ0NlLFJe5YlnmtbEe8lWcfa3DIPBe4FWm
 l08tYql/0wKyuDOoKxFcOwsaxqL/ImktysaOXaRKAxPJQs4A/JCswXhnH0ypR1c/Al7Z
 A1PoTIHXk9ev07UriyKtv8zLIHt7HUhsJ+MsGWFdssYbfqWi19qQqD1r46ztLS22ucMq
 0MafzkGr/2Z2Cxqz8Tf7Wn0ar/u333G4NnwukFug0GrYKy/5pKQHI2aepMwgeHN5bmqe
 VUYQ==
X-Gm-Message-State: APjAAAUOffn+/+gSfEYEdBkKWd72IRrm3xvjn24zbwyTqhRICOtZQeu+
 z/dgRHpVQuenSSlZcCHqADkFrHR1e3k=
X-Google-Smtp-Source: APXvYqzZ0gk5sAlJ7wyiVx55t8lpGzAaq2JLPVAd3BtI86039ViU0+6q7ZazHeSbTWgtMEV2YgjjHw==
X-Received: by 2002:a63:d25:: with SMTP id c37mr40618972pgl.154.1571167324160; 
 Tue, 15 Oct 2019 12:22:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t68sm20993964pgt.61.2019.10.15.12.22.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Oct 2019 12:22:03 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] capstone: Add s390x skipdata callback
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191015175133.16598-1-richard.henderson@linaro.org>
 <20191015175133.16598-4-richard.henderson@linaro.org>
 <b53900f9-4402-69bb-f6d6-56d6806cb335@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <deffe5c3-449a-32db-b2fa-804e8d74ebf3@linaro.org>
Date: Tue, 15 Oct 2019 12:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b53900f9-4402-69bb-f6d6-56d6806cb335@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 11:46 AM, Thomas Huth wrote:
>> +cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
>> +                      size_t offset, void *user_data)
>> +{
>> +    size_t ilen;
>> +
>> +    /* See get_ilen() in target/s390x/internal.h.  */
>> +    switch (code[offset] >> 6) {
>> +    case 0:
>> +        ilen = 2;
>> +        break;
>> +    case 1:
>> +    case 2:
>> +        ilen = 4;
>> +        break;
>> +    default:
>> +        ilen = 6;
>> +        break;
>> +    }
>> +
>> +    return ilen;
>> +}
> 
> The kernel has also a nice function to calculate this:
> 
> static inline int insn_length(unsigned char code)
> {
>         return ((((int) code + 64) >> 7) + 1) << 1;
> }
> 
> ... but the switch-case is likely easier to read, so anyway:

Clever.

I don't mind swapping to the kernel version, so long as we convert the
target/s390x/internal.h function as well.


r~

