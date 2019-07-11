Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52734C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2974B21537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2974B21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaWX-0007LD-6o
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlaVg-0006Fa-F5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlaVf-0003mD-IR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:57:24 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlaVf-0003kl-Bx
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:57:23 -0400
Received: by mail-wm1-f49.google.com with SMTP id l2so6021877wmg.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 07:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gBzFXMgegUrsAfRlHD4O9gEuq3Q0SglD0zqttMeYuLg=;
 b=HVuTFtMwv9ZGxeH6qPVfshoL85GXiVGRapU2xyZWOiFmSeEDELdTXEov0N+F6EKNGG
 v8j5rz2zRQGp2cXUxVdMe+5v6lnDsOegv8ZjV1rECud1d6QnMZ95mjaxlhpOEP7EYg+k
 3hbpYfu6mVWxh7cuSOFAvwYdQk/tJQVtnSbQErjpqS2Z9UjEwTmJfcwdIYR/mDiVeJFI
 ssUsoi/CfrhO1S7BNlHtDFS0rFRGb0jpULiM3grCvaWuGab9RHN+TghO0GHgDIPalIZs
 BHRu6fUkhdE5gCYv9igJnE0wgoT+ElYg14byv9BspBGOB5IZBno1XlWeG8C9ANYdmpM8
 dTQA==
X-Gm-Message-State: APjAAAU96iTsC/O/rGIz1thQEmO6+bS8SXLb2cESVsYv3kYNb4c3yASC
 27B1PqTrGsoopZFJo7/T425Fzw==
X-Google-Smtp-Source: APXvYqytjZrQ76RTCV4LXwDHNc5fZ9eA5vpMfPxhkq3HYf0WGx5ntjQHVio80BLBtxbEBPx9kX5dEg==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr4618304wmh.70.1562857041890; 
 Thu, 11 Jul 2019 07:57:21 -0700 (PDT)
Received: from [192.168.1.103] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id t63sm4754458wmt.6.2019.07.11.07.57.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 07:57:21 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190709113715.7761-1-philmd@redhat.com>
 <CAFEAcA9adoeYeJCnrRU=i=WiYzAuJh2vQupYgL_KRAoomvU4Wg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e4fc24ff-43db-e11e-8068-aba98929e8aa@redhat.com>
Date: Thu, 11 Jul 2019 16:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9adoeYeJCnrRU=i=WiYzAuJh2vQupYgL_KRAoomvU4Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] [PATCH-for-4.1 0/3] hw: Avoid crash when reading
 empty RX FIFO
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 4:51 PM, Peter Maydell wrote:
> On Tue, 9 Jul 2019 at 12:37, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Fix a pair of crashes, one is an audit of first one.
>>
>> Philippe Mathieu-Daudé (3):
>>   hw/ssi/mss-spi: Convert debug printf()s to trace events
>>   hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO
>>   hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO
>>
> 
> Applied patches 2 and 3 to target-arm.next, thanks.
> For future series, could you avoid including both
> for-4.1 and not-for-4.1 patches in the same series, please?
> It's a bit of a pain to have to separate them out again,
> and there's always the risk that I don't notice.

Sure, duly noted.

> (You'll probably want to hold onto patch 1 and send it
> out again after we reopen for 4.2, or I'll forget about its
> existence :-))

No problem!

Regards,

Phil.

