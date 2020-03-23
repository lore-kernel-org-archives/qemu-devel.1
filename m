Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB753C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C099A2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KthxldHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C099A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRRP-0006TC-U4
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRPv-00051U-CG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRPu-0000D5-6I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:03:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGRPt-0000C4-L8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:03:14 -0400
Received: by mail-pl1-x641.google.com with SMTP id g2so6239678plo.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qQCLNRCFeGSf3VUKwI3r3S5D4RJy/WPE0gr9VJXDOYo=;
 b=KthxldHoHVi9LX4R5J6kFOkeMVZdpy15t5HCDlKoNJboQWHsbGh0qkJAfW/JRdgWGk
 L9CgF0qyzDR/vNXjgiHB/E+9iaBYADpEVH967dtUunni1DfZpIbceHVMTaset9fZKykj
 jiQXP+ZZ9vHsYlDR/4JfidaS7Wxj/ENRJT2cg4z2MntzAytx6YpqkThM1739eXYEI8wW
 Mj6oTV2DJuky63wScNrTe/2A9VJDco3nrZT6g2Md+Xodc666dXEMwmxY9i5sWij9ksgo
 JAlXtlwHbNBodPmKgr8SDjjCggYCBh2sIxtl6rGaGPzTFTsvfvAvm7QLGMdeAm3dzSWU
 Pafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qQCLNRCFeGSf3VUKwI3r3S5D4RJy/WPE0gr9VJXDOYo=;
 b=IUNkNLoqkk2lh27G08oGPyg8rJ3e56Y4LU0im8V8WkLzvDw1xHcMR2a00hg54m+7cr
 IwGRqI/KbdzrYfHwK3FMFf/HmP+rgM1zOEAceXImSkyoR+QYS+WschOWcpTZ0J6jEK2S
 qeW776XddNeQOduiq75omIcrDGRIHixyWHtPF8SOh9J9QYuzS9zs4R2eLY9EFmRvleiZ
 Ql0pkMKSI3gZKa77c8Xa9fCch/GNNMvNLoQXUpX6nb3hAbwwZUUqEKQmu9FSUgwPRvIz
 9hQ3/3tt5IrxR4XgzRsZjtx45Nze4LoLG2625EBhhOo+Rc9K/CsgoKOgwvNf8ywDt9Dd
 K9SQ==
X-Gm-Message-State: ANhLgQ2yHd0zjjo1wZp9AsJ/qKIAeBllDg3kA4xBlGSFG8rPotY5jbrT
 NGuK6iWz3bWHM49EExjRjFL7TA==
X-Google-Smtp-Source: ADFU+vsq5UpWTjGI8bB5UqTuYWcSW6Nkf1RMv8PMwdJv9r6H04a/uvSYwh+V0uPhp1HmHjo894SKiw==
X-Received: by 2002:a17:90a:7f01:: with SMTP id k1mr616317pjl.9.1584986591938; 
 Mon, 23 Mar 2020 11:03:11 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f127sm13638231pfa.112.2020.03.23.11.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 11:03:10 -0700 (PDT)
Subject: Re: [PATCH v41 01/21] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
 <20200118191416.19934-2-mrolnik@gmail.com>
 <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
 <CAK4993ie33Awp=sqUOcubqCLFqTd5mTPAkWQfhh3zvorMwnSig@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8ac9a03a-a02f-1b48-c75d-77e4b8aea9ef@linaro.org>
Date: Mon, 23 Mar 2020 11:03:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK4993ie33Awp=sqUOcubqCLFqTd5mTPAkWQfhh3zvorMwnSig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 10:03 AM, Michael Rolnik wrote:
> Hi Philippe.
> 
> It's been a while. let me think about it and get back to you. what is your
> concern ? 

It shouldn't be there.  See commit 1f5c00cfdb81.

>     > +    memset(env->r, 0, sizeof(env->r));
>     > +
>     > +    tlb_flush(cs);
> 
>     Why are you calling tlb_flush() here?


r~

