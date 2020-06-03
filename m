Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A951C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B542068D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5KZcZvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B542068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgMev-00067h-Gq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgMeJ-0005b0-Go; Wed, 03 Jun 2020 02:13:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgMeI-0002te-Pd; Wed, 03 Jun 2020 02:13:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so647915wmh.2;
 Tue, 02 Jun 2020 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MX+8H/lluCf639Oc6/vTVy6tEF3XaGR/X6VtuCSiAvM=;
 b=D5KZcZvZkSPq2LDu0GSYEtNWSvKSDP4UiR/6XjwNaR0bXWPquMzEln1aYLApSLW0UA
 C8nki9fjuAJTV0Mw8dk3tLNV9eKte3xgPRVOVkVZy2ZZnghzo+tt7fbEbLdN7kpTxewb
 YcHTIEG1FXb8tP8SqoBcEnCo8F6DjxieeCkrRGgFv7JhKcjhWAzgtvmpK0sTWB9rziW0
 Kj4G6c02ZDsxBk1CJoK/7KcuMRO+/SqBmxE+DB5FXEPGrrOtoMq1WTTlpBHtpkEIZ8cG
 BtupNnpnBMovX1sB96rGJnZR6/g5b9T9aPB5VDvUulejwapPABqcRtb0COisoZAlIPPS
 QfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MX+8H/lluCf639Oc6/vTVy6tEF3XaGR/X6VtuCSiAvM=;
 b=sxKCgUgQ9IBWy3S678vRt58AwEQN5nIZ5s+o6ddcCwOiKuLbWBXElyTCW4p1Y3insx
 B4RxkY0mmUYv05XHVI4VEG0o4mNNsB1iP40F5f+ISM9jnsWmNFcGDha2NpYo7asL941i
 3i+rC+aoBOt3AysX+H2OmsZP0DVMkQ87r6VVRcGSFHXZlPZxENu8oiYM3NS0PDCLMOIr
 Upz57e4ZJLyh5dn255yvnWHLbxVZTgr843aQVjRBKTWRbEOGnptxSYw0mugfqe3FHMnz
 fx6GT4d45myoeqbomJDKoEgkfjHFpinMIyHjMucgMCqxxcf1XHvkrSxR1+9Qf+Hm0FgA
 C//g==
X-Gm-Message-State: AOAM533ngUIwcN7LXCo6LvK0sBJhPhdqQ/bfbcesXTqTVWe70p+14+Y3
 h1KtaX9rwNo5xMg2d+T5zxM=
X-Google-Smtp-Source: ABdhPJxX/fsMVTOqSOFRj0OZXDN4HcJDFAWGvQMGPkd2Z9wrX5yBQ6s1+NOt0vZASOj0Epgj8VpZ6w==
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr6746400wmb.97.1591164792625; 
 Tue, 02 Jun 2020 23:13:12 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a16sm1684282wrx.8.2020.06.02.23.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 23:13:11 -0700 (PDT)
Subject: Re: [PATCH] hw/display/cirrus_vga: Fix code mis-indentation
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200529165436.23573-1-f4bug@amsat.org>
 <17c858f1-dbd0-42b9-f2fa-22954133891a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2f04781e-d9c8-2a11-556d-bcf52e1c1471@amsat.org>
Date: Wed, 3 Jun 2020 08:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <17c858f1-dbd0-42b9-f2fa-22954133891a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/20 7:41 PM, Thomas Huth wrote:
> On 29/05/2020 18.54, Philippe Mathieu-Daudé wrote:
>> While replacing fprintf() by qemu_log_mask() in commit
>> 2b55f4d3504, we incorrectly used a 'tab = 4 spaces'
>> alignment, leading to misindented new code. Fix now.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/display/cirrus_vga.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
>> index 92c197cdde..212d6f5e61 100644
>> --- a/hw/display/cirrus_vga.c
>> +++ b/hw/display/cirrus_vga.c
>> @@ -1032,9 +1032,9 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
>>          } else {
>>  	    if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
>>  		if (s->cirrus_blt_pixelwidth > 2) {
>> -            qemu_log_mask(LOG_GUEST_ERROR,
>> -                          "cirrus: src transparent without colorexpand "
>> -                          "must be 8bpp or 16bpp\n");
>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>> +                                  "cirrus: src transparent without colorexpand "
>> +                                  "must be 8bpp or 16bpp\n");
>>  		    goto bitblt_ignore;
>>  		}
>>  		if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
>>
> 
> I think it would be better to fix the TABs in the whole surounding area,
> too. Or maybe even in the whole file. Otherwise this problem will happen
> soon again...

Well, this is a small step to unbreak alignment mistake from latest pull
request because my editor was using a 1tab=4spaces configuration, and
QEMU style expects 1tab=8spaces:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg707941.html

Fixing the whole area is a different task IMO :)

Can this go via qemu-trivial?

> 
>  Thomas
> 
> 

