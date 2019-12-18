Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFF4C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE662176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A15XTM+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE662176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgF8-0005Fl-K8
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 15:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihgET-0004rD-Li
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihgES-0005yC-Aw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:47:45 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihgES-0005xi-49
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:47:44 -0500
Received: by mail-pf1-x441.google.com with SMTP id 195so1002873pfw.11
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i4aPcvt/DUFD1lLdm80hF2WY8bZ7IVoPYT7AlMw2cOE=;
 b=A15XTM+sxmgK5SWvlH1ZACzKXa5BMuKgzA/5NUJIQbr0F6aE3kmuShBm19j15Ek9lA
 Q9S/vRIksQA1C/BVWD8jD2H2Nl5AAcz8I96XXs6s/1wCAQLwhCjgtr5duGuplmRLjpXA
 Xakb1I1HKt29WhP1Bvm0SorRqtQMbXQgbeRzlQTaBDxx6HzAvhdGEoTfGR1o2SKhO9la
 fM8ZVq38lea35pC3mY6NaGZuozMaBzzUsb/4y1xUazzo6V/UfbZCnBulkrLGh/9Xy6al
 bqUu0DcXGHFp5aLTpCv+01yJkRizt8iO/zvKIRLcjewSmDeb1Wz2zFLUjhc+KlFUC8gi
 IT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i4aPcvt/DUFD1lLdm80hF2WY8bZ7IVoPYT7AlMw2cOE=;
 b=of+rW8Wu8nAvEfoZvTyVHyuZ/AQw7W+DIKaP2FpkWVsuHOy00Z3pldg3blChP29+Pw
 oPfbs7AUcwGnziNt+xC1hpQKTbPvBxJljEwh75kI8El0fscHJVCy0vRMiMN1KqMjwExR
 T5fnQHdjOCf4do3DiFHkbuwomcxRzKEMCFI3HfxFBkMfY/ulJ8VJUSaOZqch9iGOUanF
 l6HnkaezZNVLSGw/Sc5DN87klKUnHrPciUMYC0f+26GVMyJyDvkHJPHyVO1FtKay6pOA
 nXcTneV+ARLqC6U6ENJvqg4LF8wNsvOKwwV7dNRANvRy6mTn64QZx9WekJGQuQ9Rvyex
 eBog==
X-Gm-Message-State: APjAAAXZABZD74JxqQvGkG/JmwXZFE0i9WAbzhw+5aEyv9VDRhy9qS4b
 9qL5TDyAwK75ytQj4jzY5S5YGQ==
X-Google-Smtp-Source: APXvYqzC5D9ufEAB/R6+ClqYnUnTGb0Ua407OzxkC1PHwg/QyM1H6CATHCDNeVam5N7LKaXghwIpfA==
X-Received: by 2002:a63:5d4d:: with SMTP id o13mr5061766pgm.182.1576702062551; 
 Wed, 18 Dec 2019 12:47:42 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id l21sm3826170pjq.23.2019.12.18.12.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 12:47:41 -0800 (PST)
Subject: Re: [RFC PATCH v2 02/14] hw/ipmi: Explicit we ignore some
 QEMUChrEvent in IOEventHandler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2dbed9f-1e0b-9a21-202b-b1ad34069bd9@linaro.org>
Date: Wed, 18 Dec 2019 10:47:39 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218172009.8868-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 7:19 AM, Philippe Mathieu-Daudé wrote:
> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit all the events ignored by this frontend, to silent the
> following GCC warning:

In the title, s/Explicit we/Explicitly/.

Here in the body, "need to be explicit about all the events ignored", "to silence".

This same grammar cleanup applies to patches 2-13.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
for all of 2-13.


r~

