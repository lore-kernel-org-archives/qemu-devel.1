Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F5C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 23:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001C9206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 23:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhpapGS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001C9206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQglO-0003EA-Rg
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 19:23:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQgkc-0002vX-W8
	for qemu-devel@nongnu.org; Tue, 14 May 2019 19:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQgkc-0002tT-2S
	for qemu-devel@nongnu.org; Tue, 14 May 2019 19:22:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQgkb-0002qv-RR
	for qemu-devel@nongnu.org; Tue, 14 May 2019 19:22:26 -0400
Received: by mail-pg1-x542.google.com with SMTP id 145so315137pgg.9
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Bu3Hk4xevcTyi0NBZkMJiqlmmF015Z1J5yZLzY1PakI=;
	b=AhpapGS5ebI4gUMBBSz2NCS6ap5XmY4MMy+e7ITHHSv5e2FDn08sIpwkV+j/SMprCQ
	GvEvvimmT3nYO9yPKlfSYit0aPX7FU91u0AfA4dZbc5PE0upwFfA3twYlBPecb5hY+N2
	ibsRSMCS1V/ndjSUCa5cezvhTbai30oKp0J6UCRA/E5xDOiCxJsHeMnuGLD6ub0MN3gA
	L6NAWa464ZD6049w6ewlN6TL3GyiuYepvJigb3hYQdxQR3noSs13dZ6iortjrmE1MT4c
	ZMvuhWd1ZNiSokqKmqKGO8K48h1AO1pBXTpoEkgFK40c7lAyFo9UDJiYkmGJwXXCrjfX
	8X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Bu3Hk4xevcTyi0NBZkMJiqlmmF015Z1J5yZLzY1PakI=;
	b=QQWysZgVC3/55joGLu0J0fF+PQjIdz/zKwYREF2QulNNJeX3BtlKHwm0HVD4Ky38xY
	Apvqh+Rc3Ty9UUyGY0CXaq+FV/NP2jSKGlUj01gAqF6VNpD6ldoH40CaY5ybLNpsM2kR
	0/JHb4phJsh8R+a3sP2Z9EHvafFww4sqN4E0brZwBVGz6uRS849+MW1USvozy4yqOiHk
	f3CZqd2PYfMPmHZfvE1nKq6INTE4n9IfOiCY6NFxMqviSFPwG7XcGAPRGdtjz5pqpkFa
	vfLKGOBp4KjU/s0UBb5saoi84ZZ0K3PZe1fzB5DRTUWEQIqmFAlpY3W3de9QP/Hi/eqk
	S89g==
X-Gm-Message-State: APjAAAUI4wTxhnHp20EEqsN/mACLke86dH8sAtzNNb0tEuCG113MbPhW
	z5/Vjd8nLqyL5HyhjQexknzy/1tvmss=
X-Google-Smtp-Source: APXvYqyNlzXu84UUgpoGbKa5/4yaqthvWw4B1SEKIgnDnsSla3NzAuMg+xrCUs4GTGOURjEoOiivDA==
X-Received: by 2002:a63:e24c:: with SMTP id y12mr16844784pgj.276.1557876143857;
	Tue, 14 May 2019 16:22:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	w194sm179432pfd.56.2019.05.14.16.22.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 16:22:22 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
	<berrange@redhat.com>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
	<877eatdq3w.fsf@dusky.pond.sub.org> <20190514152331.GJ25916@redhat.com>
	<d050fa9d-8e4b-7b87-31e5-05a7fa78feb9@linaro.org>
	<20190514165036.GA7680@redhat.com>
	<f0da55b5-e14d-e718-0608-fa37d1cb6c2b@linaro.org>
	<dfed572d-6104-8ada-3bd8-1231dc6d6392@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <44e28b2a-1a9d-bfc5-9d06-5a7fdc079744@linaro.org>
Date: Tue, 14 May 2019 16:22:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dfed572d-6104-8ada-3bd8-1231dc6d6392@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Add qemu_getrandom and
 ARMv8.5-RNG etc
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 2:43 PM, Eric Blake wrote:
>> It didn't occur to me that there was nothing in the object files for the
>> reference.  I'll have to drop the crypto-obj-y patch and come up with a
>> different solution.
> 
> Isn't there a gcc annotation for marking a simple as mandatorily
> included during link?

No.

There's stuff you can mark a single function within an object file that you can
use to avoid the function being elided...

> __attribute__((externally_visible)) sounds promising (it nullifies the
> effects of -fwhole-program, so that a function remains visible even if
> the linker would have otherwise suppressed it)
> 
> __attribute__((used)) also sounds useful (the function must be emitted
> even if it does not appear to be referenced, which may be enough for the
> linker to infer that it is used)

... and you found those.  But those do not affect the linker's behaviour with
.a files at all.

You can force a symbol reference from the ld command-line: -u sym, which can
cause the .o containing sym to be included from the .a file.  But that doesn't
work if there's no global symbol in the .o to reference.

You can force all .o from a .a file to be included, with --whole-archive.  That
is useful when you're using .a files a shorthand for lots and lots of .o files.
 But in our case that would break the use of stubs.

Anyway, see v7 now.


r~

