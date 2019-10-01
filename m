Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA30C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DE820842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMQ8zBfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DE820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJcb-0002YQ-Gz
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFJbp-00023M-3F
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFJbn-0001Fo-EO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:58:36 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFJbm-0001DN-Se
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:58:35 -0400
Received: by mail-pf1-x442.google.com with SMTP id v4so8189336pff.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/JL+zK5aB05w59Mhh8gwF+qq5BJ2HD/AYUdSpTxnNjY=;
 b=UMQ8zBfPOToVJLve+NOXc1Wt34sVlASxStZZy4u9CInuLQgyEmTl6uw6cJ983b4ldS
 W5823qYifukAkdAIakS1JN1FJ7PY7bnU4Ao/W6YlQT15Zfl+I2gRDvncWpmNEEi6WlMX
 W/Ot9xDiKqXuP3U2sjuIYP0R36z7prnCHv3apNBBKowtjGeIsgnst3J6SOstJbWtICep
 r2FPaQB8EMFA14IZHfLq4XgjAlh/0vmYDpTArFwrMfhjc20POkcxp2XqW68IY26rpKdv
 1I8cAyuTyGAGzzi8EDWZkgtkRv/f5q+iQHk9AHSeL1JCnmvJmVbUlq3fRNZz2KORpZh+
 xZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/JL+zK5aB05w59Mhh8gwF+qq5BJ2HD/AYUdSpTxnNjY=;
 b=txlyAdw/br0XzXIRmGMEv6jgg+Kxi9JSt42ORsaBNySkZYa1NgwWv4Crtph9QYJ2DL
 xpup785HIoFdfRoSL83Y+EA5AnnjKFVVjUiY6Jltg0xMaMJUa3Rqj/ikXs3jtg3lIh0O
 MSS4vF3W5eCPGFLyNbsmqgvQ9CbhsB9GaNbi85nSvXYQn6IoCPmkGIOVG4GnRgC5IeFq
 QOoy28bdBzrjB5swe5pYyidHoYvy8228lwSxAGjqvxwBWMSDUDrpbsNOMa8N5KtI8uSW
 /dKKARmid6M6nM4myxMxdDT3CndBHaRtDwjLbO7ZdaNz3pnD41AfjTgqj5Nq95Ak22+w
 0B0Q==
X-Gm-Message-State: APjAAAXgLwJ3Rs7G+9OzXnmUBnLHHM9f1CsK+WaJGVVcBXmvR5rG/uIt
 WfSVYVp8cfuOG5T7Hwf4Bumsag==
X-Google-Smtp-Source: APXvYqxwTLXIJiVNlJJ0gRcdTUB4TEJllO1bxiVNvTHJHNgAE1c8059L3pZFPKheG9TTtedmQ+DnDQ==
X-Received: by 2002:aa7:9ab5:: with SMTP id x21mr27768245pfi.252.1569941913690; 
 Tue, 01 Oct 2019 07:58:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f62sm19014436pfg.74.2019.10.01.07.58.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 07:58:32 -0700 (PDT)
Subject: Re: [PATCH] user-exec: Do not filter the signal on si_code
To: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190930192931.20509-1-richard.henderson@linaro.org>
 <ec1ace6c-49db-e769-e43e-6b0e059d6705@linaro.org>
 <CAFEAcA9r+N5Q076kWYyu0a+_VvnzU0FRXZK7hZ4t52JO=a3qTA@mail.gmail.com>
 <7315e0ed-0d33-e998-1dc4-01664c300723@vivier.eu>
 <CAFEAcA9xT7rRCaP5hwvhzLH0GgMqp+Uk55vq=4TT7d-65Yogkg@mail.gmail.com>
 <ba9c069b-fb56-2438-07f9-bb0c5eb97058@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b2496351-b7ae-55e7-611c-4e7eda48c02b@linaro.org>
Date: Tue, 1 Oct 2019 07:58:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ba9c069b-fb56-2438-07f9-bb0c5eb97058@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 6:15 AM, Laurent Vivier wrote:
> Le 01/10/2019 à 13:46, Peter Maydell a écrit :
>> On Tue, 1 Oct 2019 at 12:19, Laurent Vivier <laurent@vivier.eu> wrote:
>>> Is it possible to update the farm to Centos 8?
>>>
>>> Or as the kernel involved is specifically for POWER9, is it possible to
>>> use only POWER8?
>>
>> My experience is that the gcc cfarm admins aren't in
>> principle against the idea of upgrading farm machines,
>> but in practice they tend to have a shortage of effort.
>> If there's a centos-7-kernel-update package that could
>> be installed without doing a full distro upgrade that
>> would probably be pretty easy to ask them to arrange.
> 
> It seems Centos provides a 4.18 kernel for POWER9 on Centos 7:
> 
> http://mirror.centos.org/altarch/7/os/power9/Packages/kernel-4.18.0-80.7.2.el7.ppc64le.rpm

Thanks guys.  I've sent a message to the admins asking for an update on gcc135.


r~

