Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B89C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D5C20665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6jwioyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUCw-0005n1-Ow
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPUAG-0002rI-9k; Mon, 05 Oct 2020 13:20:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPUAE-0005AS-Ps; Mon, 05 Oct 2020 13:20:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so4737641wrq.2;
 Mon, 05 Oct 2020 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ruggo/CE5ijMcgJS1YHH8RWi3Vp636OlrOUEQSiTVuE=;
 b=b6jwioyqnvkurUrM5W2v9i9ARpTbAfoqZVMksE/Q/UIS8KoWht4+v1yZs5ffa1Jofz
 oh7r8AkYOZ4xMeLAhV8yjwut9ELsJ0vmslGusftf117ojJuowNA/LOnxMpZ5pbBcWS2o
 moVKiDABcOdd0/3UdZqhA80h+ouxYUUnJ/3YxBGh8R2YzFT3D21sGfOPOZ2lpdlJAmG+
 ibg/hA732hwgzo8TiaQnSpXJPRq+MFRCdLZ82QVU4dAkJ+t3hNNfnQP2JBCO/nqPyqgg
 y4PIhTcdMOst5EQDLy564o92gILBnrpp4UORjKqusjFd98q/HTcmXMPYaedRqi7tnW4n
 Us3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ruggo/CE5ijMcgJS1YHH8RWi3Vp636OlrOUEQSiTVuE=;
 b=EUabAS8AMb4nCi3SCKooKmJnnbFHMEOR+YiOabe7U/yHjIn4YYdhTfSVmbQKkqksn4
 64rnybd7dP8gW2Z6nI6CZttZHXiqrs5uHw8gWKtoxghfWTvB+fwDk17dW06j9Dno4AUt
 3nltZxVx8abnsfE0E+N4UnPVV27C0gT4ootavwswZnqeEcjGgmVpJKHJk5D7VoLQ8mqs
 bYI05Ym61ASf10yJQd9UooRZIlTXuc38TSV9XDjZ8Y7VGikBE767MOoiU95+Wi3F5Xtx
 GdK2b8zbW3H0SqpIwI9u5d4JuyVU2LoCKkxcmUD5lkN8ueS99hZ9OoUauz0g0xD6exMu
 NTGw==
X-Gm-Message-State: AOAM532Exln4IXa+tnT1di/cESbzw3+RUXlRmdLG2l8I8fSYj5ntrOVr
 g916x7koWVjLHzWgIAW4pQoR7jlipq9uTw==
X-Google-Smtp-Source: ABdhPJw57og045KbmLseeYYNijfG5cCBvfXFJvx+lhlP8py0ETBhUSH/30drYTLCN9ErfpGSZg6OzA==
X-Received: by 2002:a05:6000:108a:: with SMTP id
 y10mr461764wrw.41.1601918440636; 
 Mon, 05 Oct 2020 10:20:40 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h4sm930749wrm.54.2020.10.05.10.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:20:39 -0700 (PDT)
Subject: Re: [PATCH] qom: Improve error message displayed with missing object
 properties
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200920155340.401482-1-f4bug@amsat.org>
 <0263e47d-549e-8acb-a6cb-93a7436f5f6d@redhat.com>
 <20201005164244.GK7303@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e21879c-1ee7-05aa-a0d9-ba1f8a90d677@amsat.org>
Date: Mon, 5 Oct 2020 19:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005164244.GK7303@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 6:42 PM, Eduardo Habkost wrote:
> On Mon, Oct 05, 2020 at 10:46:38AM +0200, Paolo Bonzini wrote:
>> On 20/09/20 17:53, Philippe Mathieu-Daudé wrote:
>>> Instead of only displaying the property missing, also display
>>> the object name. This help developer to quickly figure out the
>>> mistake without opening a debugger.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  qom/object.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qom/object.c b/qom/object.c
>>> index 387efb25ebe..257914b1fe3 100644
>>> --- a/qom/object.c
>>> +++ b/qom/object.c
>>> @@ -1259,7 +1259,8 @@ ObjectProperty *object_property_find(Object *obj, const char *name,
>>>          return prop;
>>>      }
>>>  
>>> -    error_setg(errp, "Property '.%s' not found", name);
>>> +    error_setg(errp, "Property '%s.%s' not found",
>>> +               object_get_typename(obj), name);
>>>      return NULL;
>>>  }
>>>  
>>>
>>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> I think it's okay for qemu-trivial.
> 
> It would be okay, but it doesn't apply on master anymore due to
> the object_propert_find_err() refactor.  I've fixed the conflicts
> and queued it on machine-next.

Oh sorry I didn't noticed, thanks for fixing/queuing!

Phil.

