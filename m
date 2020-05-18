Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBC1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2046E207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMeoOSF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2046E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaivD-0003f6-Aw
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaiuH-0002Nk-3D
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:46:25 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:39561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaiuG-0008FC-0B
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:46:24 -0400
Received: by mail-pg1-x52a.google.com with SMTP id u35so5088368pgk.6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W1gVnHhKErLz5E7eZ+YiA/fgbauyC9Hl3zRIXfD3Xxs=;
 b=hMeoOSF5I7mY7fDETPUZO18NNOkj7K9b01h3KvSlinBxjatklqa4Wni2UY6yZ1+B6l
 eYLgcMNQeeqo/om2NEvS2ghgaPfMXi9L4np29/BpXH6X4tVHOGSVCOrW0MyDrAxH1GDP
 4n21LRulva4G2lIpJhyrydAZY4bRTS1UaOC8noE4BuY8mgrC4gIy01bJf38gdID+/GOz
 GjInY86Ucnv96QYfPand2hb3rPXw0WkrjXpbHmF6E5gQ+6K0900HMGG+9W7W2VSkt/5D
 pevBwM4nUdhZODYw7lL02a/nbSbWPxZG7dexyOnsqhiFU5rU+/guE53pwAqzPca9oI7H
 ltRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W1gVnHhKErLz5E7eZ+YiA/fgbauyC9Hl3zRIXfD3Xxs=;
 b=APdohhZBhBbUP9LevAZ7yWRhkfks4o2+EanfqV4FUfE6N/yvRluR1yUOwCLjcs4yIE
 m4z4KQNwZqBkLVkuTB1mcDIBOLuL/jXwTqxFJN8ak1YnBeYJVbHjLei9CNQs8LRCHEmA
 v6Y2qQI/vNoL5fJy6WsBUrqi305aXZcLh+exlK6p0xOGpI0YDLRont7LLCn7fjQxHZjx
 oVoJJUEgVjJPZzzqQ5cydtIFLKs5j83/PDnDCSM/ySfTsVhMZ3yyRau9Ret2LgeenwRV
 XrQ5dL4flUSVzCE8669Ua5iMgYw2Qv1IeXvfYkJ4/BnxrsEETeJ3JVOrV9BKSwWIEdlc
 qsXg==
X-Gm-Message-State: AOAM532Jxq8O20SFzw8UylEdWrPtFuuhO+4n5UqYMHQDpQ6KxKspHjrn
 pg2HNtZj9QDSC0vTyeXkjno98Q==
X-Google-Smtp-Source: ABdhPJxtpSx1XTUQuKLKejU+5ELLSec9/d/4lnKOlgv4aNKu5QaT2vyWT4+to/Ck6yhF2ujbtDwtJQ==
X-Received: by 2002:aa7:85da:: with SMTP id z26mr17068464pfn.25.1589820382606; 
 Mon, 18 May 2020 09:46:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gv4sm86430pjb.6.2020.05.18.09.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:46:21 -0700 (PDT)
Subject: Re: [RISU 5/9] Use EXIT_FAILURE, EXIT_SUCCESS
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <20200513180953.20376-6-richard.henderson@linaro.org>
 <CAFEAcA-pKnqGywy4UACdA0eJfNqiWOahka3C1hwP2JmndJrOfw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0757b371-a064-964c-961f-3839fcdd10e3@linaro.org>
Date: Mon, 18 May 2020 09:46:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pKnqGywy4UACdA0eJfNqiWOahka3C1hwP2JmndJrOfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 8:54 AM, Peter Maydell wrote:
> On Wed, 13 May 2020 at 19:10, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Some of the time we exit via the return value from main.
>> This can make it easier to tell what it is we're returning.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I don't really see the benefit personally, but

It wasn't so much for the direct calls of exit, but when we return an "int"
that gets passed to exit later.


r~

