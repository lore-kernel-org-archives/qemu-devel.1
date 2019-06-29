Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31B2C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5608208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5608208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhAzd-0008IT-TV
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 06:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50302)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhAyt-0007ig-BP
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhAys-0002tv-4M
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:53:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhAyr-0002tN-Tk
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:53:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so11256379wmj.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 03:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y2eFyUGsUnG9wD+p5kDA3/q0hP/U2/uv/CSwDmX5rBI=;
 b=mFVzGoELe+1ZM4UeYjWX1+grdSH40EvwCsIKlO+iKonvFSJW+/QsEtAL9NdauGALnO
 jFyILa+Y+GDi1ZwqCPMgKnqzop616BdygT3a1o8eifcyJ3gBlk5CmBW7iEBkF70nsYJN
 G9OIIwNFkzsguIZqpWOEyRTt8ZRoDQBd2SrpS/CavLsQFcYPmlWXh6f8OZ8RFEP0WLbj
 IJ4CTj8kL+bnS9MLG+2uuhvK7LmvDGB7Kd3FwD0HCRuT6NQcTH9kOZQrB8yeAsp2XnO3
 KkH6UDvAPbJIthn0giVEVoSAvgyLQWc/LWCT5WLDyZELwyjpJqzYhnS30+wfXIbZDtNd
 K13g==
X-Gm-Message-State: APjAAAXaOafOiPd8moyV9wjW7U5mWQWxsWo8LoffOkK+cppTeDZCxMLI
 dLpJ+NMp4OCfdPOStRPBzgwdAg==
X-Google-Smtp-Source: APXvYqxpbPOaPusFxmCqOutoB6bLyzKIcEHC8XXHrYcwc7faodtBt552VlgtuTrsS1F40Onj4CsoTw==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr10753070wmi.114.1561805596858; 
 Sat, 29 Jun 2019 03:53:16 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id w20sm9151562wra.96.2019.06.29.03.53.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 03:53:16 -0700 (PDT)
To: Marlies Ruck <marlies.ruck@gmail.com>, qemu-devel@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CALw29ZZZ08Lt13oZsbZCwV+uP0roLuT6t+8m16y+8YT-KH4t7A@mail.gmail.com>
 <CALw29ZbiqpGFOGHOP_7K2DvAfap_xE+PWAfXvvr35eK7aKn-dA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e3282346-166b-ef37-b874-2c2625cf31c1@redhat.com>
Date: Sat, 29 Jun 2019 12:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALw29ZbiqpGFOGHOP_7K2DvAfap_xE+PWAfXvvr35eK7aKn-dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marlies,

On 6/29/19 1:26 AM, Marlies Ruck wrote:
> Hi,
> 
> I just wanted to follow up since I sent this patch a week ago to make sure
> it was a received.  An ack would be appreciated.

You did not Cc'ed the maintainer, so he likely missed it.
See:
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer

$ ./scripts/get_maintainer.pl -f linux-user/signal.c
Riku Voipio <riku.voipio@iki.fi> (maintainer:Linux user)
Laurent Vivier <laurent@vivier.eu> (reviewer:Linux user)

BTW you should also look at the next paragraph in this wiki page:
https://wiki.qemu.org/Contribute/SubmitAPatch#Do_not_send_as_an_attachment

Since you credit Peter Maydell, it would be kind to Cc him too.

I Cc'ed Riku/Laurent/Peter for you now.

Regards,

Phil.

> On Fri, Jun 21, 2019 at 3:58 PM Marlies Ruck <marlies.ruck@gmail.com> wrote:
> 
>> Hi,
>>
>> Attached is a patch to let guest programs use SIGRTMIN + 1 by swapping
>> with SIGRTMAX - 1. Since QEMU links against glibc, it reserves the signal
>> for itself and returns EINVAL (as noted in the commit message). This means
>> various applications that use SIGRTMIN + 1 cannot run on QEMU, including
>> G-WAN web server and Open TFTP.
>>
>> Thanks,
>> Marli
>>

