Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD21C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE9F20693
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZ8q9B0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE9F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43883 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXEW-0001Zl-Fc
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:49:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYX3G-0000Jp-75
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYX3B-0005io-8u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:38:04 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYX3A-0005IE-4D
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:38:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id r21so915911otq.6
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3xdpGgZCJmSQTGkNGdWANnF9HghU7JJeKQII55IzPS4=;
	b=TZ8q9B0w3EO5EnRaDT8SFEMNQjVIzxGcrGpWx8xlw7M+WK5JvsUBrd/qvLKjbBe7p7
	Gcl5pnyetoAL9tzwT9QnJSru1OjhH7KgwBKpI5BXZWzyHmWyUoaralowAy0z+ohVNBAo
	OMUymlNgcvLplxEpokKs5IAw1wFlwyUf2wa3V2x4jwu3tmxHjTb6jF7Qsmim4UAb+vKq
	+UdSBhkpsULt7pB8nfv+9dFNw5JG1brAT6nuBfRQpHZyuDYo2crTwDacGQnMGvaZRML7
	fYNl6BT3JQJK/hoEGuBtV7vAhLmDac01XXmAXxzUXYk3GXQQIIV0skE3ck4HpP3bF0EZ
	ibDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3xdpGgZCJmSQTGkNGdWANnF9HghU7JJeKQII55IzPS4=;
	b=JjrEz2ZvxHZ+X0IkOziRTf29kGBMF+Twnbr4xgrxj+XnSseDIAqCZLEbX9qZRKBrGi
	kVQWmshYhGluipFjTy2pL7soDPa/0oLubYLN6WqwGK3yFf1eFimI816kbSlGHoON+EUv
	y48N8Oy0oPIc/Z0uXC+zTrG1PuHlJ0KJ6LhtXPcMLz9+Afi05pGIN1CcViUKrUZLy/Lm
	eBTxcYNBHoJ875GqQrmOQ7CDTK4LUnSc9tfbE7howxembDygSvqWwQ6XU5wC3PEc/TYW
	SagYKzv6gOYf///146Pn8Sh2hAY+44jBEpKOvy/FBFrxqdr9o5s4+lrETtx3bE/Yd+2o
	Jb9g==
X-Gm-Message-State: APjAAAWhQFqpxsZZjYpyJjCY6UDyeLXwNlgJx9EF3Z5LH1+9LBiWzFku
	mnCnyf9eijM6x0bBwaxBWgTX2A==
X-Google-Smtp-Source: APXvYqzaOfPe1SDPpFh0denFTjEkWiA9ZZfWCZ1HKV5kpK13Nhj4koYQr9KURYUzfXIZSYNs/CVzhA==
X-Received: by 2002:a9d:62d9:: with SMTP id z25mr7629455otk.268.1559745473213; 
	Wed, 05 Jun 2019 07:37:53 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	e184sm7981375oia.28.2019.06.05.07.37.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 07:37:52 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
	<9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
	<CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
	<3bc0d426-bd59-055d-a010-b136cba555bf@linaro.org>
	<CAK4993j5JXgV9CYDckt99kwgQaG6w-GN-Tka7r2nahoh33rheQ@mail.gmail.com>
	<CAK4993jWViasj8PKUCHcbMh-9SPJmELqua9eSbFvwL7gpm2e5A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7b0c5e07-5b99-3344-7f80-847880f85b5b@linaro.org>
Date: Wed, 5 Jun 2019 09:36:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993jWViasj8PKUCHcbMh-9SPJmELqua9eSbFvwL7gpm2e5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/19 2:20 AM, Michael Rolnik wrote:
> Hi Richard.
> 
> I am still struggling with this one.
> 
> The spec says.
> The BREAK instruction is used by the On-chip Debug system, and is normally not
> used in the application software. 
> When the BREAK instruction is executed, the AVR CPU is set in the Stopped Mode. 
> This gives the On-chip Debugger access to internal resources. 
> If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are unprogrammed,
> the CPU will treat the BREAK instruction as a NOP and will not enter the
> Stopped mode.

Yep.

> I read is as follows
> - If user has an intention of using debugger, BREAK should be translated to
> QEMU debug breakpoint
> - If user has no intention of using debugger, BREAK should be translated into NOP.

I do not read it that way.  The spec is talking about a specific implementation
of debugging -- fuses, jtag and all.  We do not need to implement breakpoints
using any of those mechanisms, because we can insert breakpoints via
on-the-side data structures and re-translation.


r~

