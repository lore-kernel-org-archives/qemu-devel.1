Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF9C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AC92133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0GZ0WbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AC92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKA58-0003oY-FG
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 19:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKA32-0002ak-No
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKA31-0003HK-KJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:46:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:38519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKA31-0003Fw-8q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:46:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id w8so8660439plq.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 16:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0ff5FmsR2u8LjxZ8nFEDoYAUd9BJ03hHHC/rQe7hLs8=;
 b=b0GZ0WbEaRHhJ0WknwmPOiyjtBuU3Tvma9p/gVYqWlYJuKndMZXT96YY/vFe2L4HSo
 F/uAGbKxjDetNjS3vSv8EOjiEKd+u5dZSuLYKFq2cMjI6uN+xBRmTQV5A/XfIfCzO7+H
 5Ocu9GdVrjVcI4BGXqtC0V9XdQ8iWiEUriy5ipY0QZdcmSixiUhKxbn1igpbaiduzDxM
 8IYpvcRquxRiDfzopf6K31uzNJKysn8APSYqBi+3+RPVV4qa3ZF9kfnm8GbK7V9I6/W+
 IAv0legOfZyRCd4CzETplzjl7CKqbfwMhWe0jdzKQhsIcX+vlSuVrTgd9Em9/Ajpi7yQ
 lECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0ff5FmsR2u8LjxZ8nFEDoYAUd9BJ03hHHC/rQe7hLs8=;
 b=h9GBbAZBeVBn2l5iJdP3PRfaXPak06l07OvhtfD9hpS7bQ1CPaYqd2K8Kstm9JrdG0
 CxryGJCikuw6H1YZ5opK8APmb95oAkoiGOiLbnRJp5+EIRT9+gJYBS6eyqh3IzQ61OcH
 1pgwIJlwBWruVgJYn2iu4EWZVUhAXO/42LiACDiX8Uky7f429coo5Cm9Ee2FBRCbSpEN
 ba422qQitNvibZSf1YwbIkGwOUIajsNbzHsCaN8ECTEBXqkvrhRQeZEKvAnfzW9XQToR
 M1LYnbLppvefEzWfagrq0YvcX3hrJpBgef9AVoGVxYyOmvPr7jKmnny0eycgOFq6udur
 EFmQ==
X-Gm-Message-State: APjAAAWm9msYzfIbNAIEH29UZxAEK4pMgTZxO7F/g6VxRDCs4aTDlgGX
 3f9M4mrtyTWfGIrwekwWTKBM6k7ttJE=
X-Google-Smtp-Source: APXvYqxsPiy5s+trWUWh5rV+HN3Rh3EKJPfGegzWZp1pFFoijqeeFa5jIRS8uJ3ots5fEI82jtDM3Q==
X-Received: by 2002:a17:902:54f:: with SMTP id
 73mr32058156plf.329.1571096801690; 
 Mon, 14 Oct 2019 16:46:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g9sm15732155pjl.20.2019.10.14.16.46.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 16:46:40 -0700 (PDT)
Subject: Re: RFC: Why dont we move to newer capstone?
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f243dfe0-f04f-1936-5ca0-a89aaf3b83db@linaro.org>
Date: Mon, 14 Oct 2019 16:46:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62b
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

On 10/5/19 3:11 AM, Lucien Murray-Pitts wrote:
> Hi folks,
> 
> Whilst working on a m68k patch I noticed that the capstone in use today (3.0)
> doesnt support the M68K and thus a hand turned disasm function is used.  
> 
> The newer capstone (5.0) appears to support a few more CPU, inc. m68k.

I don't see a capstone v5.  The latest I see is v4.1.

> Why we move to this newer capstone?

I had some patches for that floating about in May, but
it missed the merge window for qemu 4.1.

Thanks for reminding me about them.


r~

