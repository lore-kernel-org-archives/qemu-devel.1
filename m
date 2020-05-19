Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5D9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E8B20709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwOq4gfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E8B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1Hx-0007KJ-7Q
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jb1HP-0006ut-NF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:23:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jb1HO-0002hj-Uj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:23:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so15710181wrt.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cmomrfrMuz30m9mL0Mm0PbDiJG4YVUioSObXfgfGDa0=;
 b=hwOq4gfNIBFWuruSuBcaOjRoPR+eirMpekJ6vnFPpXjC1hYkm7L6o2ws1phXiq009K
 fK6BCyAkAP8sH3qGWemPq5MkyFGg9/omIBQsFHXniT5aRqK/iB7+bz/EVxxdjEq1aL18
 HKL1t+k/X4TQvycvW4BYaB31yoFqGAaeg1Ln2iY9x0jpDVhtT2EWfwhiUQnAWefMOq+2
 DVz/wo4M72KGJc6+SoD7zvkDP/AU7oLAYUf4RPLYc7dNKX+B6WhIY8B8HRaFkiISijBJ
 I7EeKAuTCG7VVsI8H2D9Uf4Hw4B/tJl8iZir5iS1YTIHqtJAPwpmZ2eOWNpRNsHD+YJo
 qSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cmomrfrMuz30m9mL0Mm0PbDiJG4YVUioSObXfgfGDa0=;
 b=tUg9VGB2ybrWhJV+ATeQV2hbGPuPk7nEobNJlSSk9xduz947kJVlJ9wO5WY4iy0LbX
 axNGpsUNjm/6Yd1Sy0jxjxbYyw4z+qxSeJCvmyPxug5kC7Qkc3QWYGsbrt+iyd+iCflW
 B44wDUk12ZF/OIE4HJB1Tg86CFxY7b48QW1Kp5HPQ/ezwLqKPeWouAGRL8yeY54p+dEZ
 nL64xKzHjSPwtBPk9YEbNITXxLVIulJ0k6hR0Zc5oXZlKrNwY1ydkI1hTUZg7T7CofsS
 nOgYLIC7KaZJQ9ZPtF9CAYgIpiO6m6zsUoymQ55HF9bl8iY84WvwHfv6SMv8r3fswnDf
 sZ5w==
X-Gm-Message-State: AOAM531uU0N7wSFfW3w0BDCuoZOk8eUy1I0xu2xRjf7fMb6ZyE0rxYkR
 vyaJ+uwLnDQq9pWsr4bPJBE=
X-Google-Smtp-Source: ABdhPJzULbnOdxyUxTAzMoWLtZUEI0lcFnWaMuMSaw4bLC+GmeX6sb6PoYLb9Ug0nakalu2JslIjAg==
X-Received: by 2002:a05:6000:1104:: with SMTP id
 z4mr27493484wrw.57.1589891009239; 
 Tue, 19 May 2020 05:23:29 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f128sm4152802wme.1.2020.05.19.05.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 05:23:28 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Fix OUTL debug output
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200517110147.26026-1-f4bug@amsat.org>
 <234cbf5d-aed7-7b6c-e43d-ae47f8251916@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d4f069cd-6357-480a-3732-71e97d0e9aea@amsat.org>
Date: Tue, 19 May 2020 14:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <234cbf5d-aed7-7b6c-e43d-ae47f8251916@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 5:39 AM, Richard Henderson wrote:
> On 5/17/20 4:01 AM, Philippe Mathieu-Daudé wrote:
>> Fix OUTL instructions incorrectly displayed as OUTW.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   target/i386/misc_helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> as far as it goes.  We should of course never be printing to stderr, but
> logging or tracing.

Yes, this is what the cpu_io() functions do in ioport.c, but they use 
MEMTXATTRS_UNSPECIFIED.

If we could replace one with another, I'm not sure which one is the 
correct one.

Maybe keep cpu_io() from ioport.c but add a MemTxAttrs argument?

Regards,

Phil.

