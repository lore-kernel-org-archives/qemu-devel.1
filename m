Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E8C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 10:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0CC20771
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 10:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grSourta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0CC20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js1XH-00007J-Na
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 06:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js1Wb-0007qJ-J6
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 06:05:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js1Wa-0005Ua-4z
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 06:05:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id z13so37623857wrw.5
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sOiudD6UnkfYQ00aHXb4AplIZ1c3HvlkDvFtFJnR8oU=;
 b=grSourtatMVtm9YcV69XJvKUe3foimVrp82j6BETFpw2uaYMiHajLt7jDUJtQFpFxd
 J6RPD0oIHWQDzlSpjtZJrHr92oQ7f/T9kajKrEcmh8L8oLmPadhnYl7qd8OSgoHDOV/5
 dVaWQpQNQV47ouB9a/ty43UfgGoiAorZbpZyN6GQUrE/G5S1gW58B4Qc19l121Ez0jAY
 YrRV0lyaSGiu3MN4i7jAAM6otIOIq+ZLcR8PtYgrJgWzLwpuRL0wyfXhesEzyKR00Jss
 3rU9EMQJQLt8HIdmEcfoqJXx4KZPCa9MZZznc/YaPpxHzPoR3n+VsJ6GXjYj/DPj2zWR
 pW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sOiudD6UnkfYQ00aHXb4AplIZ1c3HvlkDvFtFJnR8oU=;
 b=ZNkV2Ovjyw1OZYzIG+Oqt+3vkCkQTaTon6kf6nRPrfRBNnP2Nn4tEuGyJGAta1cJyO
 NTgncS+c3Hp8M4woY/aahdL0PQeMVgNvOxb16nto/LIR4iYxDvREnSEhEVbiq/fGJu6m
 ABelJDz7ByQcOXi5O3bJfjnk56oYcW5tZvI+fd4D//8fOna2fYyHWWeN41G2+nO6zYU6
 QWOOYy8m2YSVTGfpJWBDbX2XYGWcCre9lRP+3P6y0N63KFUXUdxapXS9deZc63duNmqh
 lTw1lCZqxQwVjWeiDvuDYeReHTo1T1sJmt6UlYiURZSWTJSU6j5gdZ+XT9tLKiEZFy6I
 B7yQ==
X-Gm-Message-State: AOAM53272l8WT6vqgd5UXw6BPoMyq9Ik3tVo7ZvWUu35vwT5j0EtYOYF
 qESABjUKUyunJTvZQ1gae6w=
X-Google-Smtp-Source: ABdhPJyIJfwNQE90PrJJWZ6AFU355vBJX+2ien78sVs2GeUF2dKKHanlvL4Y0FUFFdatAvKOLc+S9w==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr16328722wrq.1.1593943525661; 
 Sun, 05 Jul 2020 03:05:25 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v24sm22864525wrd.92.2020.07.05.03.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2020 03:05:24 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev: Increase qdev_realize() kindness
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200620153837.14222-1-f4bug@amsat.org>
 <c0366cb5-fcb0-ff62-8ab5-92722a47d4e7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65937a53-5430-e5df-a5f0-de93dad315f2@amsat.org>
Date: Sun, 5 Jul 2020 12:05:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c0366cb5-fcb0-ff62-8ab5-92722a47d4e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 7:46 AM, Paolo Bonzini wrote:
> On 20/06/20 17:38, Philippe Mathieu-Daudé wrote:
>> -    } else {
>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>> +        error_report("%s: Unexpected bus '%s' for device '%s'",
>> +                     __func__, DEVICE_GET_CLASS(dev)->bus_type,
>> +                     object_get_typename(OBJECT(dev)));
>> +        abort();
>>      }
>>  
> 
> Since there is an errp, should we use it and be even kinder?

This is a programming error, not an user triggerable condition,
so I'm not sure. IOW this must not happen, but if it does, then
the error message helps the developer to notice the problem without
having to use gdb.

