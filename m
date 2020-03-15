Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3262C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E50A2051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7p11nb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E50A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDbuM-0001dn-AX
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbpK-0007jH-7T
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbpI-0006YI-W6
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:33:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDbpI-0006Q4-6z
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:33:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id b1so8557450pgm.8
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C8xrtjZPdhkGh9RyuMEXja32sZxVcrJKH8SOoPBFV+I=;
 b=S7p11nb7RkRO3B2CKas/xZBbykefVMuGQavF9k2EpUSryb4hk0D7aR0ykRSR/ya3Vc
 g3Jkp0sQuy3AlvNbiZ4DkN7PWuuQBoQAjKFHxJ9yEwzGUKqy2wLs/UPcoguqYEbHOUaD
 +YIYh00mfewuYg5l+YaNFqbisx9f4IXkLx52Yarnoiy9wLpnCpXyEHXuIc+winQlkk3g
 WcVXW6hSSm2XswORQWkwFn/5o7DvNSmncCExThyvk0iJo8q90FABr2I4K6oL2Rrl1PGk
 7e+B57NEQLXRmvq0O8ifOWBaXPmvVJctdB8Q5nv3S2XdrmRiMUjOipbwzfLC0HgM7lSE
 uGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C8xrtjZPdhkGh9RyuMEXja32sZxVcrJKH8SOoPBFV+I=;
 b=hdVik7lSApBUgw3NCd0IQOH88AowmeLDV0QFilTQlacEltvYmm/dpXVcl5ssx2wcEn
 q6byeJaQjSwcNrW2EGU5W/7vShStSeIP4uJNmVXURUy6e6ZdXyW0U/dB9dFCLz/CMrgT
 Xwybu9pQhW/BHMucQiPZGi5sGQPUAt5w8sH0v2EhPTl/PE2+0unq4R7bbF8K1nzcUQSW
 Ye42wu1yV9Xk3zhvJP073J43tT/JV679mLj/Sx7C7MbWuNwZrZ/dXf0zRSb77C0HXSVL
 eEj2xSvyS+I3rvfqL9nM/7gzurwFW0kSqwnW+/E89GGdK7/3qkX47z+rpm5ho/Aqj4Wb
 yrZQ==
X-Gm-Message-State: ANhLgQ2K1+CKcDp7alC5WSaQl9Y/SgPngKtDHEqiw4YZ//tfewf+yZAI
 t4IAcQsYthq6Jp3N5+XeStfIfA==
X-Google-Smtp-Source: ADFU+vv4ID1TV72I/f91ubBzIpArlK8S71wQ1JT6Z3mqMXjq0lOpmdWDq1J+3g+wmfbKprdmTM4tqQ==
X-Received: by 2002:a62:e20a:: with SMTP id a10mr23092322pfi.270.1584311623231; 
 Sun, 15 Mar 2020 15:33:43 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 11sm13757742pfv.43.2020.03.15.15.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:33:42 -0700 (PDT)
Subject: Re: [PATCH 01/14] Makefile: Only build virtiofsd if system-mode is
 enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-2-philmd@redhat.com>
 <8f73d608-d28e-b896-b1f0-f95d599502f0@vivier.eu>
 <d9b29b2b-58ff-512c-c426-0ffe7bcad295@linaro.org>
 <29d183c5-6dc5-39a0-e8be-fa2e7f37d331@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9c4a379-4710-b2c4-54ae-e33b02de5c64@linaro.org>
Date: Sun, 15 Mar 2020 15:33:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <29d183c5-6dc5-39a0-e8be-fa2e7f37d331@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 3:16 PM, Philippe Mathieu-Daudé wrote:
> On 3/15/20 8:40 PM, Richard Henderson wrote:
>> On 3/13/20 3:28 PM, Laurent Vivier wrote:
>>>>   ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
>>>> -HELPERS-y += virtiofsd$(EXESUF)
>>>> -vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
>>>> +HELPERS-$(CONFIG_SOFTMMU) += virtiofsd$(EXESUF)
>>>> +vhost-user-json-$(CONFIG_SOFTMMU) += tools/virtiofsd/50-qemu-virtiofsd.json
>> ...
>>>
>>> Why don't you do that instead?
>>>
>>>    ifeq
>>> ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)$(CONFIG_SOFTMMU),yyyy)
> 
> This was my first option but checkpatch complained because it is 80 chars long...
> 
> I also tried:
> 
> ifeq \
> ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)$(CONFIG_SOFTMMU),yyyy)
> 
> which is uglier and still too long.
> 
> Following qemu-bridge-helper syntax I also tried:
> 
> ifeq ($(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yy)
> HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) += virtiofsd$(EXESUF)
> 
> which is also too long ¯\_(ツ)_/¯
> 
> If you accept checkpatch complain I can use the form you prefer :)

Hmph.  Of the choices, I prefer the 80+ char line.


r~

