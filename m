Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA669C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9597D20771
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUzMsWSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9597D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1eU-00011S-Tf
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv1dq-0000Gv-3H; Mon, 13 Jul 2020 12:49:22 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv1do-0006U2-DU; Mon, 13 Jul 2020 12:49:21 -0400
Received: by mail-ej1-x643.google.com with SMTP id rk21so18001057ejb.2;
 Mon, 13 Jul 2020 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EySsZI4/pTRSMdnVwthHs4fTAmdWn4xeZCN1brctPzY=;
 b=eUzMsWSBj6/SoYhJ41PfNAueXK34HQ1V0F+Dvg4jqUlxTPIHdc/Z5gNUGbp6k/Ozmm
 Ow66eW2lx9hHI405d6WcDrHn/1uQwBJHMfAHjco7+6QkwRc+pewY0GhK72+NJNeQdIvz
 H3JW93LAWLOWf0kpk395wuRuSWOlB2X8yBXEDOVAxc7blf6pTqwdZUzkAfrjp/W4/3mS
 komBQHA3aaotlZ8DkMvhbdsLXcVTwra+EQSy/So6fv/il+Af+D+vBKye/lCZQ3rWT2bX
 76amWKCqJSC2gnccbKLMJjx/ToBlp1ZE2XTS2KMPe52LQlpCUtg/mLx9+/T3wigvoEsc
 vX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EySsZI4/pTRSMdnVwthHs4fTAmdWn4xeZCN1brctPzY=;
 b=LBJispuzoCcZ4AREvWBdlglLFhH/hPNMHo9yr4dB9TxoE7eVymnexWGa9yEzC8Tqum
 yTdtDTfgeLN0JO5CM47mKf4KvHh0aNnv7of7ku5wkKw/PDVlzps5MVI1m32wmWMXcXK9
 drTSGUZMVkaJc24Mo8R+n2NJRfqpQtUGOA6T4PYgMQE3ggi/7wqU4X9Dmi9PeVKkBSIw
 6QvfcbGyi3VwUZap+QmxAZ4eNqQe7R/WPrOV4nsg75RbvzBlncxqIIXQiL326qF2s202
 gpvrDvlnJj3WSfQ9b99WbfOoz3K/a8NXUf28o1OakleG6j0NBvLse9xtXBSWier8SfO2
 W5ng==
X-Gm-Message-State: AOAM533WVL967+gTec+brQTepAE4LapSj/gtmvXQ6AMfLOveex0eTGUN
 VtaPdEgOmz+Qv69Lk6vNP18K+hqDiMo=
X-Google-Smtp-Source: ABdhPJyTQxHuyzmpEe5qh3a5gf6fzw2K8loa58sTltx6b49uQFdjYXgT41cDVTzwaw6jTv9PyGCz9g==
X-Received: by 2002:a17:906:40d6:: with SMTP id
 a22mr613384ejk.133.1594658958353; 
 Mon, 13 Jul 2020 09:49:18 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id bs18sm11986304edb.38.2020.07.13.09.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 09:49:17 -0700 (PDT)
Subject: Re: [PATCH v3 03/11] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-4-philmd@redhat.com>
 <CAFEAcA-6Vv5Q31Z0bsXPpWanEj8Z0gBeZFWTCrQF3W8RuaQiMQ@mail.gmail.com>
 <3e682d7b-8d6a-999e-e426-ffcdd0fc323e@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c3603d0-8343-dde5-ea56-7a6420d07ad6@amsat.org>
Date: Mon, 13 Jul 2020 18:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3e682d7b-8d6a-999e-e426-ffcdd0fc323e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Prasad J Pandit <pjp@fedoraproject.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 6:36 PM, Philippe Mathieu-Daudé wrote:
> On 6/15/20 4:06 PM, Peter Maydell wrote:
>> On Fri, 5 Jun 2020 at 11:25, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
>>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>
>>> Only move the state machine to ReceivingData if there is no
>>> pending error.  This avoids later OOB access while processing
>>> commands queued.
>>>
>>>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>>>
>>>   4.3.3 Data Read
>>>
>>>   Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>>   occurred and no data transfer is performed.
>>>
>>>   4.3.4 Data Write
>>>
>>>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>>   occurred and no data transfer is performed.
>>
>> It's not clear from the spec that this should also
>> apply to WP_VIOLATION errors. The text about WP_VIOLATION
>> suggests that it is handled by aborting the data transfer
>> (ie set the error bit, stay in receive-data state, wait for
>> a stop command, but ignore all further data transfer),
>> which is I think distinct from "rejecting" the command.
>>
>> If that theory is right then moving the check for the
>> ADDRESS_ERROR in this patch is correct but the WP_VIOLATION
>> tests should stay as they are, I think.
> 
> I found the correct behavior in table '4.10.1 Card Status':
> 
> * OUT_OF_RANGE
>   ============
>   Type: E R X
> 
>   The command's argument was out of the allowed range for this card.
> 
> * ADDRESS_ERROR
>   =============
>   Type: E R X
> 
>   A misaligned address which did not match the block length was
>   used in the command.
> 
> * WP_VIOLATION
>   ============
>   Type: E R X
> 
>   Set when the host attempts to write to a protected block or to
>   the temporary or permanent write protected card.
> 
> With 'Type':
> 
> - E: Error bit.
> - R: Detected and set for the actual command response.
> - X: Detected and set during command execution. The host can get
>      the status by issuing a command with R1 response.
> 
> Block Read
> ==========
> [...]
> When the last block of user area is read using CMD18, the host should
> ignore OUT_OF_RANGE error that may occur even the sequence is correct.
> If the host uses partial blocks whose accumulated length is not block
> aligned and block misalignment is not allowed, the card shall detect
> a block misalignment at the beginning of the first misaligned block,
> set the ADDRESS_ERROR error bit in the status register, abort
> transmission and wait in the Data State for a stop command.
> 
> 
> So I understand we want OUT_OF_RANGE (returned via R1).

We always returned ADDRESS_ERROR and guests never complained, so I don't
plan to modify this bit for 5.1. What matters is "command is rejected
if error occurred and no data transfer is performed".

