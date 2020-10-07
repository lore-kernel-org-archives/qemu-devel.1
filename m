Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44736C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0F3206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQCOjbi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0F3206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ2xW-0005Yc-C7
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 02:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kQ2wD-0004fd-Oy; Wed, 07 Oct 2020 02:28:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kQ2wB-0003mW-SN; Wed, 07 Oct 2020 02:28:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so778247wrn.0;
 Tue, 06 Oct 2020 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=j1izx32osDo1A3hTn0MvPqt5JizCW12iU+JC9aFRxEo=;
 b=qQCOjbi35oNPM/TSYE0afuxj0+DYKIw0L09v54x+xlHPi6vaOgnhFZfs2VFZkH62wX
 hAvmXD7yK8d4UOnNJCFolP8Qx8/BxHugEw9eZ/RdKD2eUwGpMRonsaRFYB5jA71rJIyV
 xkA1fyR5M9NDm8aWemLPAKjxZCA9e36F8pBqWnHWisNIUXNHfQb8tuCVlFVQ1eLpWExv
 TZLQiedNXns7mk0KvQ4qiszbsrH2dzBWrEceR41PWSb2v8JfLGpmJHziUOxWN+GmbJAm
 9Ux0tT+ooxOaRBneZINjJa4t65Jle/PRMozXQICZ5yeVJl1ZhaRfGYyb7MK3wde7CR0a
 dWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=j1izx32osDo1A3hTn0MvPqt5JizCW12iU+JC9aFRxEo=;
 b=IN33XgNqwU2GwVx5lShix1MsFPGUiys/S1zZllSJjcSgwCQpp9RSDVD97/+VJ1qM43
 +Oasn6N4MVWZksRx2WA8Hsdye4zs9/ffdeyYqt/qC3R4Cuv1uMQ1nHOCq3Kn9EKj3B6R
 GK0TEo7wx4UBxxmfZqV6GsnCACN7MIxBavhJnlj7DRM5GVId82v8jxuyQ12/J7LcdoRg
 LRVoVYXFbhQbNKwJiKzRcQ5vWQ+IaJJBXpylCH8H3ueS4i/U+HG4YhhbRZHtXXBFvI1t
 dq/8Ec41OcIpg46vCzuu9T3pahqt6qqmdqwqEJcmt7umBRguXHKY1fDoYhY/8fSrjZut
 6QmQ==
X-Gm-Message-State: AOAM533wrqlY10L197dW3IDl+GlqQTs88W8yNMpS4hBkmSr0DJJ8oUVk
 PLyW+iaZ/i1vAhHZ8Y0QOCI=
X-Google-Smtp-Source: ABdhPJwTbEBxpzlLEMs3TUcgVgpv88+1sS8+oKoE5ovblK3tXY5Ff3DTTwA46WZhSzX7h8Fv+CTHgw==
X-Received: by 2002:adf:edd2:: with SMTP id v18mr1636762wro.242.1602052109534; 
 Tue, 06 Oct 2020 23:28:29 -0700 (PDT)
Received: from [192.168.1.11] (b2b-94-79-184-225.unitymedia.biz.
 [94.79.184.225])
 by smtp.gmail.com with ESMTPSA id b200sm1265196wme.44.2020.10.06.23.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 23:28:28 -0700 (PDT)
Subject: Re: Emulate Rpi with QEMU fails
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org> <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com> <87362r3cbt.fsf@linaro.org>
From: Thomas <74cmonty@gmail.com>
Autocrypt: addr=74cmonty@gmail.com; keydata=
 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
Message-ID: <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
Date: Wed, 7 Oct 2020 08:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87362r3cbt.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=74cmonty@gmail.com; helo=mail-wr1-x441.google.com
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello!

Many thanks for your support.

I managed to get emulated RPi starting.

However there's one question I want to ask:
How can I accelerate the startup sequence?
I mean booting the emulated RPi takes more than 3 minutes.

Regards
Thomas

Am 06.10.20 um 11:58 schrieb Alex Bennée:
> Thomas Schneider <74cmonty@gmail.com> writes:
>
>> Hello Paul,
>>
>> many thanks for sharing this info.
>>
>> Can you confirm that the emulated RPi with your command will use 
>> "internal QEMU" network, means the client cannot be accessed from any 
>> other device in LAN?
> The support for user-mode and TAP networking is orthogonal to the
> emulated device. However if you only want a few ports it's quite easy to
> use port forwarding, e.g:
>
>   -netdev user,id=unet,hostfwd=tcp::2222-:22
>
> which forwards 2222 to port 22 on the device. I have an alias in
> .ssh/config for accessing my QEMU devices.
>
>> If yes, what is required to setup a TAP connected to host's network
>> bridge?
> I'll defer to others for this but generally when I want proper bridged
> networking for a VM I use virt-manager/libvirt to configure it because
> it can be quite fiddly to do by hand.
>


