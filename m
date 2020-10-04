Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD096C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 09:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272B42068E
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvDFrrhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272B42068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP070-0005lo-0j
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 05:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP06N-0005L1-81
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 05:14:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP06L-0000RQ-J8
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 05:14:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id l15so3914281wmh.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zHj2ur6d03K+vswNNbWPE9dJQ2M7t00coBW/GU/Q6Us=;
 b=lvDFrrhQqPCFCjcr1X5l2u906O41d6TXPjnwj1ACPCihdLNj3vc8sdxj0s+V4YH49k
 ay5g36E7qrfiAYwSgQsVLtCcMvOPtdr+Yy60e2g+J5ogF72cshfL76zEcTMophq58re7
 szt145INoulN1Ax3F0Lr2rJJIfS0vX/B8L9VOwI7CT2IxsxiPkhMCjWnqIl3UJDhIg0Q
 Fi1g55AeMFxiPLsi5jYhLgg1TdXc1xLN7w4aQFfNJtu31lm1RMVHOWMLIVRty1fiC10l
 W3ff4GHIVAqC22EZPiqcT/GNKwp9XhX3t+eoP63KE+ITbBgPpjLrrXlPCsBwPn63Zdan
 +HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zHj2ur6d03K+vswNNbWPE9dJQ2M7t00coBW/GU/Q6Us=;
 b=GzoYC/rrrpgLepCIT0eRCUWLMli0pHFus64Z2Gi+f1Fk1niW4ltCMd8S/LZg1M8hrn
 Hyk+C0I5vD5KkEvFagbJaaPmXVxBmxDYBLz6wNkO0oq6QyD9R4IIYvtWLiaZUwFd/knv
 Yt6HdALFMVuQaLLVEOP7yW4CvPG2YDPBuQ7CmLRqiaM32HPRPIbynC8rYTXvS4O1tEtQ
 EviXe79HloihOb3iG6pP7In5CRrxD7b1BHrBpwaJ5F+rC+oafcwMVpty66jwtfRWiA3s
 XLm1I73Hpxecx5p6rQL5iD/kPiGhYUXC3vW49LS8enqdljGwUbUCSEfoLS+Wh8qhcGut
 D0fg==
X-Gm-Message-State: AOAM530/AlUTp2yuBWrHpyusphDpmsXZj8QV3kGm97EN0HGHymDzyqvP
 mfEVg4gmhSEInjq8TzsDvGs=
X-Google-Smtp-Source: ABdhPJz6B7XdpvLujTntaruqon2r0CtSsRplQJg/sIr/WAst81pByqKeuNbH03O+f1HdB2M+kI5dhA==
X-Received: by 2002:a05:600c:2902:: with SMTP id
 i2mr11054048wmd.31.1601802879489; 
 Sun, 04 Oct 2020 02:14:39 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t6sm9093185wre.30.2020.10.04.02.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2020 02:14:38 -0700 (PDT)
Subject: Re: [PATCH] dockerfiles: add diffutils to Fedora
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201003085054.332992-2-pbonzini@redhat.com>
 <48dd90e6-c5fe-5749-ac0a-5128c0496ea9@amsat.org>
 <90b66907-2f5e-af8c-36ee-0d8dddbb5a8e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1a3220f-0b6d-788b-77a7-71b02a3e70b7@amsat.org>
Date: Sun, 4 Oct 2020 11:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <90b66907-2f5e-af8c-36ee-0d8dddbb5a8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/20 8:34 AM, Paolo Bonzini wrote:
> On 03/10/20 20:00, Philippe Mathieu-Daudé wrote:
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>>> index 71e4b56977..ec783418c8 100644
>>> --- a/tests/docker/dockerfiles/fedora.docker
>>> +++ b/tests/docker/dockerfiles/fedora.docker
>>> @@ -11,6 +11,7 @@ ENV PACKAGES \
>>>      cyrus-sasl-devel \
>>>      dbus-daemon \
>>>      device-mapper-multipath-devel \
>>> +    diffutils \
>>>      findutils \
>>>      gcc \
>>>      gcc-c++ \
>>>
>> What about tests/docker/dockerfiles/fedora-cris-cross.docker
>> and tests/docker/dockerfiles/fedora-i386-cross.docker?
>>
> 
> They're only used for gcc, not to build QEMU.

Ah OK.
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Paolo
> 
> 

