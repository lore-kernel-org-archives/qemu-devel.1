Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B326C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 21:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F70206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 21:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUVBZdsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F70206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYG7G-0005k7-1Y
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 17:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYG6D-00056S-6B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 17:36:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYG6C-0003Mz-Ei
 for qemu-devel@nongnu.org; Mon, 11 May 2020 17:36:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id m12so14692824wmc.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OUeK/4XW2K31fbpxhDrRO5QxaZUZTQWNrTzYWfq3gqY=;
 b=fUVBZdsGrewYZjuUZlPwcY2kqDcTZKQ072H9xduZufO/3tIOU03E0zQy9lGCTQxf+N
 mBS19kcPh2+Jn6fh7D/TNWenGtGpp9Tpf1X1mtof6AOv4SwVrpYKpeQdudpv83bggLRG
 4fIK+EgpqcPlc40VjzQM/0OLiIg+59Fyt+qxdWWq2O1rYysg0sdqP9rydJdqWjDWe/sW
 eehtPoxwZFamCYG+r9wFXGtrvVsnmZ7wnid6LEjeaQtijhbhpkMx/1Xk7WsNUum1j8h8
 urpa6yD2NPIoftFxgvMFPlvth+RzOsAvqiTOT/MPMEhMzpKX812i/ITZ+ovuBpBLFywo
 WuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OUeK/4XW2K31fbpxhDrRO5QxaZUZTQWNrTzYWfq3gqY=;
 b=oGVCrhM0zhTJhJFvymZ1WJSNl8yFBWxLWDHJiAc5Pf6cclfmWQpEzNTWVG6jaZknXS
 uOP+8a3Um4G7uwpQ8j735W+Ax9/npiQA0rqtkXZzP+V+xIkRzQUWYmomAyqSXuE4iH5b
 vlkCIeT09NQs7tl2u3a6Bsg3MzCM/fb4v2VoftIvdHqqfqVwhFUw/mZ+7x5+qF6NaLR3
 5eLhRk5Vw9mcQjhHOto+ncGZ4GdFv/SPtYSDTO7+Fnc1GLmKmzRu9nauDw5mYk8I1grD
 R1tmrD0uq+Hgvk57WyGa1UnG1oTWC7y45Oy7A1mXRol9P06w2zq49Eq2pK9AEMLE8CeN
 y+0g==
X-Gm-Message-State: AGi0PuY0QuqSQcgEOlI1kAre4ZzIbpcFH7hI4VlfhgaQQ7cXAvltMDkZ
 skOzNN4CCwQW/v8wyyxJD/o=
X-Google-Smtp-Source: APiQypKf/QlhupYku3QoOzpZnYeNetLk5Xg0rfJJTA8Aw0SnbkFinLpCuWVnH0tn7GNcop+zlZc3dw==
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr35464766wmg.40.1589232986925; 
 Mon, 11 May 2020 14:36:26 -0700 (PDT)
Received: from [192.168.1.37] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h137sm37082678wme.0.2020.05.11.14.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 14:36:26 -0700 (PDT)
Subject: Re: [PATCH 5/7] audio: Let HWVoice write() handlers take a const
 buffer
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 qemu-devel@nongnu.org
References: <20200505132603.8575-1-f4bug@amsat.org>
 <20200505132603.8575-6-f4bug@amsat.org>
 <a52cb124-ff0a-c529-038e-6559c5e59e1a@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8de3167e-7e1d-9916-4051-9ace75e15852@amsat.org>
Date: Mon, 11 May 2020 23:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a52cb124-ff0a-c529-038e-6559c5e59e1a@t-online.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 8:22 AM, Volker Rümelin wrote:
> 
>> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
>> index 4cdf19ab67..bba6bafda4 100644
>> --- a/audio/dsoundaudio.c
>> +++ b/audio/dsoundaudio.c
>> @@ -454,7 +454,7 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
>>       return ret;
>>   }
>>   
>> -static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
>> +static size_t dsound_put_buffer_out(HWVoiceOut *hw, const void *buf, size_t len)
>>   {
>>       DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>>       LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
> 
> You forgot to make the buffer const in dsound_put_buffer_in().
> 
> I had to cast buf to LPVOID in dsound_get_buffer_in() and dsound_put_buffer_in() because otherwise I see:
> 
> C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c: In function 'dsound_put_buffer_out':
> C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:466:38: error: passing argument 2 of 'dsound_unlock_out' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>    466 |     int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
>        |                                      ^~~
> In file included from C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:266:
> C:/usr/msys64/home/ruemelin/git/qemu/audio/dsound_template.h:48:12: note: expected 'LPVOID' {aka 'void *'} but argument is of type 'const void *'
>     48 |     LPVOID p1,
>        |     ~~~~~~~^~
> C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c: In function 'dsound_put_buffer_in':
> C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:571:38: error: passing argument 2 of 'dsound_unlock_in' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>    571 |     int err = dsound_unlock_in(dscb, buf, NULL, len, 0);
>        |                                      ^~~
> In file included from C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:268:
> C:/usr/msys64/home/ruemelin/git/qemu/audio/dsound_template.h:48:12: note: expected 'LPVOID' {aka 'void *'} but argument is of type 'const void *'
>     48 |     LPVOID p1,
>        |     ~~~~~~~^~

OK thanks for testing. This is unfortunate, because a single backend 
invalidates the whole series.
I don't understand why the DirectSound API requires a writable buffer 
for locking.

> 
> With best regards,
> Volker
> 

