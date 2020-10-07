Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9958BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07D5207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg9O7Afa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07D5207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3ss-0002F7-OQ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kQ3rE-00015T-N8; Wed, 07 Oct 2020 03:27:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kQ3rC-0001nN-Ng; Wed, 07 Oct 2020 03:27:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so904862wrp.10;
 Wed, 07 Oct 2020 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=bE1RgvN+vCiXUMiZyF71Xr2ku5CW0sV51rQc+GqF9Zo=;
 b=Mg9O7AfaRl3fWFWqqFbU/lH9jqnrjR8dDizwqJQgxS++XbYAWA9y8eG4M2PtescmAA
 /YHgXT5fKSR7x1V/+L/OukPCj8r78c5EZ8ffdxepgpOoA4MauEdzsXRmp7Fi7Qk0S0tq
 dodtnzv92l8ab+c00MIiHW53i+HP5y3YP9sPwKSYZ9WaaLgnfpPkkNImSU920g3eYxV+
 AHRZgQid8/V+dZZMfslWRLXgTuP3T5tiOhDd9KAH89QdgTXkcCz/RHsSFyPpcbUX4ymJ
 FsI1kvNZ80IN5P4TiOEdCSCjbFiirl88HOvBiJdHK2+ev5MYyWL8HLVNmi9FamsYIhnk
 PJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=bE1RgvN+vCiXUMiZyF71Xr2ku5CW0sV51rQc+GqF9Zo=;
 b=tEzF1pKK3hqehgiGI2C/l+J0r5iqjgPqOxZipR/pzlodgFdAH+D73ooDckoRiY7+6g
 OmEbDxZcJT/sdzusmoHcYN4z6xdVgf80AdHAheO9zEEzSZwSIMwSYOlMWQ4u7SSb1/NM
 2KqD7a+XuEo8nP7lvnSmMAKOmcoE5dwGIqPYed8lvjixi47kNfWTGEh7T2wTZiOagpb3
 F5Mq6iYeLQFm7gVwxErMWYGRrRb72Vb+2SJAtBbZd7la1WORvlFkqezi/W4bVw32KYCI
 kYnnGSCKkV08sI6lJo2KTKgOqaB005BCeT92c0L7KWL6mNJfavUzBlJ0fLCOoy3eKj3M
 9LDA==
X-Gm-Message-State: AOAM5312UGnszlCbPNR4MV19CigKtV9vW8moZimmz6z2G9llv96hf4Dc
 Jp4aZliMdwjDDLeEIoPr9Ko=
X-Google-Smtp-Source: ABdhPJxs8NEv/1vn/pHlGUR5ks2Hut8s/LF2DWILyAmf2ec8dGExHsVfRw7S4U+e3lTcEXYafRYWGw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr1813510wrv.369.1602055644820; 
 Wed, 07 Oct 2020 00:27:24 -0700 (PDT)
Received: from [192.168.1.71] (b2b-94-79-184-225.unitymedia.biz.
 [94.79.184.225])
 by smtp.gmail.com with ESMTPSA id q4sm1564351wru.65.2020.10.07.00.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 00:27:24 -0700 (PDT)
Subject: Re: Emulate Rpi with QEMU fails
To: Paul Zimmerman <pauldzim@gmail.com>
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org> <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com> <87362r3cbt.fsf@linaro.org>
 <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
 <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
From: Thomas Schneider <74cmonty@gmail.com>
Message-ID: <4da67d13-a774-f62e-ad89-de062cbe81da@gmail.com>
Date: Wed, 7 Oct 2020 09:27:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=74cmonty@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I already considered the host CPU power.
However I have this 
<https://ark.intel.com/content/www/us/en/ark/products/33924/intel-core-2-quad-processor-q9550-12m-cache-2-83-ghz-1333-mhz-fsb.html> 
CPU
Intel Core 2 Quad Q9550 2,83 GHz
and assumed this should be powerful enough for RPi emulation.

But maybe my assumption was too optimistic.


Am 07.10.2020 um 08:50 schrieb Paul Zimmerman:
> On Tue, Oct 6, 2020 at 11:28 PM Thomas <74cmonty@gmail.com> wrote:
>> Hello!
>>
>> Many thanks for your support.
>>
>> I managed to get emulated RPi starting.
>>
>> However there's one question I want to ask:
>> How can I accelerate the startup sequence?
>> I mean booting the emulated RPi takes more than 3 minutes.
>>
>> Regards
>> Thomas
> Get a faster computer? ;)
>
> On my Intel i7 desktop it takes about 40 seconds to boot to the login:
> prompt on the serial console, and about 1 min 8 seconds before the
> GUI is up. On my 5 year old laptop it's probably twice that. I don't know
> of any way to make it go faster.
>
> - Paul
>
>> Am 06.10.20 um 11:58 schrieb Alex Bennée:
>>> Thomas Schneider <74cmonty@gmail.com> writes:
>>>
>>>> Hello Paul,
>>>>
>>>> many thanks for sharing this info.
>>>>
>>>> Can you confirm that the emulated RPi with your command will use
>>>> "internal QEMU" network, means the client cannot be accessed from any
>>>> other device in LAN?
>>> The support for user-mode and TAP networking is orthogonal to the
>>> emulated device. However if you only want a few ports it's quite easy to
>>> use port forwarding, e.g:
>>>
>>>    -netdev user,id=unet,hostfwd=tcp::2222-:22
>>>
>>> which forwards 2222 to port 22 on the device. I have an alias in
>>> .ssh/config for accessing my QEMU devices.
>>>
>>>> If yes, what is required to setup a TAP connected to host's network
>>>> bridge?
>>> I'll defer to others for this but generally when I want proper bridged
>>> networking for a VM I use virt-manager/libvirt to configure it because
>>> it can be quite fiddly to do by hand.
>>>


