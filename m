Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B1C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A77122249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZMDusn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A77122249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAuv-00069d-91
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVAsn-0004Jz-Ou; Wed, 21 Oct 2020 05:58:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVAsm-0006r9-2z; Wed, 21 Oct 2020 05:58:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so1281949wma.4;
 Wed, 21 Oct 2020 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r0W7TX9da4J1KcC7f7dtLX29GXsabYauBLM8DG8n5UA=;
 b=pZMDusn9Ccbw0Fg7BlnbPzjKvQypvqREMEBArvrNw7GesUmHL5v8WSzNcPOZmOTZee
 vkIH06KWlTwTJItS6UYALSXNAnBdJ4V+bawpdZn3CVIRAzo1GkoYQ8UbAnKT49pu+UQh
 yuX15fBXdvdnBk9iNU4clSUJY1eAUQhQiwhBoH1ihq5r+aKudZAI+aUoBBEuKBjTtvFg
 5/JJqi/A1DD+yUh5Mkor9SQ/2V0UqDejXSo05oWzbVD7B3rDXdRV3+CXEgtp6QXOcY1V
 a8xnwyIfT7IHZQLM/MWIYBf9Nbt2hj79VRgugmUrHUTodpVu2kXVU81H4ubktsQ9/ltI
 7OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r0W7TX9da4J1KcC7f7dtLX29GXsabYauBLM8DG8n5UA=;
 b=AnAZ5r11V8IwLaOTsGz3w+cKH2Azu69PWMKbqXzYFHRUO5/CGweJ/RELnv20+U0V7a
 B/wt53semjRbFYInMc5+jLjWDtPEK42wGMAa32ckgaipmncjWTQLBsbrFlJC3AgGVR1I
 P2qQMXLH/0lEvmVrN1C+gjyP3/JU5N1VJ8ISiZDJ/WflzGVvqytmft8m86LB7NXjlrtG
 a+/WWZdc9fccwZrxkzd+xjI7wzdBK//EJiB1yk9Cl/rS2tgEhDhOh87maI2XOZj4S/XC
 B1HuuMb/wJLYdO1CFiLes+DwPqFIBaMSgIrYiAylc4HFlQR4ACZlh5tSwd+ncmiYLgjD
 GqbA==
X-Gm-Message-State: AOAM530PtoFzGjy1D73rxS7A1OsIeUmnZFF0t7O+yqJjfnzmHMNSNjIG
 NNkM4LrG+TGDy1GKfx/8NwFPRdPJG4s=
X-Google-Smtp-Source: ABdhPJzpomrTffR8wyI9QHooJHsTO66Fl19tMWfc0p2Svq1uSjfzOZDGYp/GAPfYVq6CVAxY2G2DBw==
X-Received: by 2002:a1c:2dc4:: with SMTP id t187mr2591230wmt.53.1603274287508; 
 Wed, 21 Oct 2020 02:58:07 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p9sm2474396wma.12.2020.10.21.02.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 02:58:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] hw/sd/sdcard: Do not attempt to erase out of range
 addresses
To: Alexander Bulekov <alxndr@bu.edu>
References: <20201015063824.212980-1-f4bug@amsat.org>
 <20201017183156.tdfjbqcm4bbrd7dw@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c838075-54e3-f0fa-8e22-03177c923d7a@amsat.org>
Date: Wed, 21 Oct 2020 11:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201017183156.tdfjbqcm4bbrd7dw@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 8:31 PM, Alexander Bulekov wrote:
> On 201015 0838, Philippe Mathieu-Daudé wrote:
>> Yet another bug in the sdcard model found by libfuzzer:
>> https://bugs.launchpad.net/bugs/1895310
>>
>> Since RFC: Settled migration issue
>>
>> Philippe Mathieu-Daudé (6):
>>    hw/sd/sdcard: Add trace event for ERASE command (CMD38)
>>    hw/sd/sdcard: Introduce the INVALID_ADDRESS definition
>>    hw/sd/sdcard: Do not use legal address '0' for INVALID_ADDRESS
>>    hw/sd/sdcard: Reset both start/end addresses on error
>>    hw/sd/sdcard: Do not attempt to erase out of range addresses
>>    hw/sd/sdcard: Assert if accessing an illegal group
>>
>>   hw/sd/sd.c         | 30 ++++++++++++++++++++++--------
>>   hw/sd/trace-events |  2 +-
>>   2 files changed, 23 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.26.2
>>
> 
> Hi Phil,
> For this series:
> Tested-by: Alexander Bulekov <alxndr@bu.edu>

Thanks!

Series applied to sd-next tree.

