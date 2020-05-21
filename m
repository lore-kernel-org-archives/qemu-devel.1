Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA207C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A2D207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnQcGBRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A2D207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnJR-0001p2-NL
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbnIR-0000WF-Rs
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:39:47 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbnIQ-0000O4-7D
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:39:47 -0400
Received: by mail-pl1-x644.google.com with SMTP id q16so2983462plr.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CIa/ldRCSIu17qwKpnlSw1zjinXrFMV5J5NR4wmmfzA=;
 b=qnQcGBRO9lxPIG9VTtudL9bb9Gzh9LU2C7C8cLTeECMVrtJWg/Wr4tWjZvqrnnvQGc
 aRCSkrxYMqTBXL9ypqkmTLHETFf4NotJtp9iBLBjie2CIWIbNcJk+/0ffC0tkbbS0dw1
 0WfQJ0rWG0BK9748/h7i9jjyYfc6z+h/LGMng5M86Y4t2QyJVKq6xRo6R9lQWerG8O82
 D2SOsgdQducV9p5FPz+TyBPTsOP1735dkK2KtHwP2Yr7vgTci8KcVXz+LWQxc/lMZWaR
 F1z0E9V6MQv1LvAtg3MbJy3G+D8+dcuYkjbucF/I5I8g/NMdYmib0E8HU0yaRif4V1p9
 fJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CIa/ldRCSIu17qwKpnlSw1zjinXrFMV5J5NR4wmmfzA=;
 b=Nuets9PkGkY2y8Tbht1lpKhOLgGd+MjHZ0Mz4oW0G2iQRAWhIuGLy5+fYVICfZFBDg
 w8umwEwOEyzJPYyoGScit3vUriZb8jcWI+7NueOJqT6Ugn1HIlQ5ps1ACKvJo5qyrgNC
 Nq2FEN9j0wgZi4eHOqdYvSdxrAJuQL/+DNzSM8ax9j5ZboRgwz3O+YfB09yUHj0oS51d
 z4dY9XfGEPn80ClgxFjEm2ytAt6OAt3er8dy5njAK3/cLlUpAxOBBL5FEXBlNO/nJWRT
 Mg1AnBwWhxAd09VRyiVQVUM1P0m48bObH6zThrxJapGFdH8Va0Ru+LQtvoyraSmaAZnV
 okwQ==
X-Gm-Message-State: AOAM5329ZyFkw56Yt/BaV1CaTCUvdvGwxn1TiUrQLtF/iD44ymuvQsJL
 aO1jTx+ZFBjnedDy842AmET8eQ==
X-Google-Smtp-Source: ABdhPJxo0b/O4vbKnWKzZus3CSO2LQBqW/jpz6L9UikdugTk8DZ8+NZDqCXmgJgnf0XDN5Ad14Pjew==
X-Received: by 2002:a17:90b:882:: with SMTP id
 bj2mr11124244pjb.186.1590075584355; 
 Thu, 21 May 2020 08:39:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b29sm4970929pff.176.2020.05.21.08.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:39:43 -0700 (PDT)
Subject: Re: [PATCH v1 04/10] linux-user: completely re-write init_guest_space
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20200513175134.19619-1-alex.bennee@linaro.org>
 <20200513175134.19619-5-alex.bennee@linaro.org>
 <958a1d7e-305d-96f5-2e0c-f8a2dd53e1c0@redhat.com> <87eerdg0kx.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0fcdef39-2e6f-11db-121b-874805ff2518@linaro.org>
Date: Thu, 21 May 2020 08:39:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87eerdg0kx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 1:21 AM, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 13/05/2020 19.51, Alex Bennée wrote:
>>> First we ensure all guest space initialisation logic comes through
>>> probe_guest_base once we understand the nature of the binary we are
>>> loading. The convoluted init_guest_space routine is removed and
>>> replaced with a number of pgb_* helpers which are called depending on
>>> what requirements we have when loading the binary.
>>>
>>> We first try to do what is requested by the host. Failing that we try
>>> and satisfy the guest requested base address. If all those options
>>> fail we fall back to finding a space in the memory map using our
>>> recently written read_self_maps() helper.
>>>
>>> There are some additional complications we try and take into account
>>> when looking for holes in the address space. We try not to go directly
>>> after the system brk() space so there is space for a little growth. We
>>> also don't want to have to use negative offsets which would result in
>>> slightly less efficient code on x86 when it's unable to use the
>>> segment offset register.
>>>
>>> Less mind-binding gotos and hopefully clearer logic throughout.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Acked-by: Laurent Vivier <laurent@vivier.eu>
> <snip>
>>> +    } else {
>>> +        if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>> +            error_report("%s: requires more virtual address space "
>>> +                         "than the host can provide (0x%" PRIx64 ")",
>>> +                         image_name, (uint64_t)guest_hiaddr - guest_base);
>>> +            exit(EXIT_FAILURE);
>>>          }
>>
>>  Hi Alex,
>>
>> this causes an error with newer versions of Clang:
>>
>> linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>> long' > 18446744073709551615 is always false
>> [-Werror,-Wtautological-type-limit-compare]
>> 4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>> 4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>> 4687 1 error generated.
>>
>> Any ideas how to fix this?
> 
> I guess this check only makes sense when abi_ulong > uintptr_t or IOW 64
> bit guests running on 32 bit hosts. We could just wrap that check in:
> 
> #if HOST_LONG_BITS == 32
> 
> #endif

As I've suggested elsewhere, I think we should disable this warning on the
command-line.


r~


