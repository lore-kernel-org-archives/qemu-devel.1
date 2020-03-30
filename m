Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A24C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AFE2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9mSIZPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AFE2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4E4-0000h0-S0
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 19:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ4DL-0000Fa-Ku
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ4DK-0002gR-EK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:53:07 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:39903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ4DK-0002Z9-7z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:53:06 -0400
Received: by mail-pj1-x102b.google.com with SMTP id z3so300349pjr.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 16:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Rof29j0W7L5k6ApfHM9/QQwHRYygQeX/2q0/CcvN//c=;
 b=F9mSIZPZ6FdqM4OS/GTUo1TtbSDL7GzFpcx7CWnn4WXXJlHTRkdDbnNHsyzzHrX5bZ
 4tab1bE7xKy19P2NnNtZHEaN08ZVw40vCSAX5U2w9gnZLj9P5q09roGJ50gPbckVsdnz
 aHeRiQv4j6sfOTxcJSbUirgVzBNkbSH/e19KiUjeU7na8VrVzeFg2giAM/HHJ3j2sK8P
 G0oZALZgoSSl59EYk1/g7XWlNSbgKwtjgOuK59K4epLB11BTmGQjF0kyMcVXyL1bfT49
 MmlTf3AxM5tLwz1WBk0p8RRrfDAhAscLt/iW1PD2amX15L7Xt9lM1eTm0XZR0Aoaohh4
 ULpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rof29j0W7L5k6ApfHM9/QQwHRYygQeX/2q0/CcvN//c=;
 b=LWt609f2Rqv/pkWRpAm88Cr4cYSfNyL8dLtcFytmOW7nbpyTULtLSMQjguCDZdiXHA
 k1LlHXaqh6eUlWFbN6MvGFGSJsPCGIc8oLtSevcTq7KGoZ9TjAIXuYm7upon9zEniMnp
 em9YCAmoTkBe5vGR0XwlLlJCCEJ8cPmZD3gzmbTUZO0mPGo4B8YRsdZ6LFiXRCmsNt6+
 1IgpWSYnQbSChlV/aRnrD9D2f04egp+zOXZZsZbOkLdkxoxmytct8GUbDtn6DND4j8p9
 kF1owZTXPlV2Kog1TNP9m6onY92Co66QH50NKxk4ZR2a6G0WtcYgOo31aHnlxll3F1na
 s2qw==
X-Gm-Message-State: AGi0PubGHTz+roHUmLSmqwS0TdtlbetaK4W8JEF3iAH4e5q8RMvsqhJ6
 gV2v1IR8Y5/iIoWiYuIReWn4gQ==
X-Google-Smtp-Source: APiQypIVbSfH0mIn2L0+d0w+Hiu0UK3Nkv7i3CYCaI9StHcK9aA/W/SewBWXt50tMrzxpa7x9k6GjA==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr714293pje.28.1585612383829; 
 Mon, 30 Mar 2020 16:53:03 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y29sm10307077pge.22.2020.03.30.16.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 16:53:03 -0700 (PDT)
Subject: Re: [PATCH-for-5.0?] decodetree: Use Python3 floor division operator
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>
References: <20200330121345.14665-1-f4bug@amsat.org>
 <ed9ac5c8-0654-3c74-3e35-5d7b02a548b6@twiddle.net>
 <18ac6d57-049e-4b45-0c9e-27190d832b50@twiddle.net>
 <CAHiYmc5xTGEw6b0gVXmbHhNO_WH30hK8+mAErmL0S6rB9Oa=Jg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e8c757f-3d1e-4e97-755f-14fef618417d@linaro.org>
Date: Mon, 30 Mar 2020 16:53:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5xTGEw6b0gVXmbHhNO_WH30hK8+mAErmL0S6rB9Oa=Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102b
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 4:28 PM, Aleksandar Markovic wrote:
> Richard, great, could you please pick up the LMI patch from the other day
> together with this patch in your tcg-5.0 queue?

Yes, I've got it.

r~

