Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB9C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6178521852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6178521852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj1Vv-0005Y6-LJ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hj1Ub-0003vs-MI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hj1Ua-000874-Dt
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:09:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hj1UY-00084x-4j
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:09:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so5702746wmj.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 06:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b132ckLAFzTygZc6K/YJHNlB74aRxhffSzRchlj64Jw=;
 b=NzQNTdccu+CXH5BpPxJecm5+WLvqSWZZkMo+/CBoSz4qnvcPwhouNr0aHdAxFApYJJ
 W3HlQ9elENyTBtSH+Veb00RyHmXvbzwiaS6xmvfwRWQ4Ecg2CXImwELpmsW2AnPqY8tG
 ZbO5XANdyVlxLJZ6AscEr3y9uySzNCwKgNyHqeCW6d2bJ55c26jDLjzJLHiceKUs2h01
 gGs7cmmovdfoDABPgdFzy9aD76BS0wDO2ered1cKNE9PnMXjjP7Htz7y1sH4LDDsrNJh
 KGBI43wbK/1hsM61qr+Fm/hgU2CljSxz96ppcoXYjq04m76c8hW9e9I3wvhDcOJbPaYC
 0vyw==
X-Gm-Message-State: APjAAAUjR2J6/PVlTnMU98DRcqxKoWK1aI5tmKTcOn6gaWk2ig/6d1hg
 vYHTrBaq2H5MXrkjLZx3PEgP0aDP/w4=
X-Google-Smtp-Source: APXvYqxVHeN1MYzJEKpnVY61NyQeZopdQSnBPMC7eS5TLb0bTyQRh2GQ/eK9c/Dqo9CPJzJanzhYxQ==
X-Received: by 2002:a1c:ca14:: with SMTP id a20mr12148147wmg.71.1562245773989; 
 Thu, 04 Jul 2019 06:09:33 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id v204sm6890353wma.20.2019.07.04.06.09.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 06:09:33 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
 <1557953433-19663-19-git-send-email-pbonzini@redhat.com>
 <20190521115259.GK25835@redhat.com>
 <f0d7e267-5f21-927a-ee38-2330fde5a419@redhat.com>
 <20190521125408.GL25835@redhat.com>
 <9d0def85-3e5c-71ca-0e25-e07fbc7d90c2@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <856e6edf-2b2e-9ab9-c422-519d16bc64f0@redhat.com>
Date: Thu, 4 Jul 2019 15:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9d0def85-3e5c-71ca-0e25-e07fbc7d90c2@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL 18/21] build: don't build hardware objects
 with linux-user
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 10:16 PM, Laurent Vivier wrote:
> On 21/05/2019 14:54, Daniel P. Berrangé wrote:
>> On Tue, May 21, 2019 at 02:52:42PM +0200, Laurent Vivier wrote:
>>> On 21/05/2019 13:52, Daniel P. Berrangé wrote:
>>>> On Wed, May 15, 2019 at 10:50:30PM +0200, Paolo Bonzini wrote:
>>>>> From: Laurent Vivier <lvivier@redhat.com>
>>>>>
>>>>> Some objects are only needed for system emulation and tools.
>>>>> We can ignore them for the user mode case
>>>>>
>>>>> Update tests to run accordingly: conditionally build some tests
>>>>> on CONFIG_BLOCK.
>>>>>
>>>>> Some tests use components that are only built when softmmu or
>>>>> block tools are enabled, not for linux-user. So, if these components
>>>>> are not available, disable the tests.
>>>>>
>>>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>>>> Message-Id: <20190401141222.30034-6-lvivier@redhat.com>
>>>>> ---
>>>>>    Makefile               |  4 +++
>>>>>    Makefile.objs          | 14 +++++---
>>>>>    tests/Makefile.include | 90
>>>>> +++++++++++++++++++++++++-------------------------
>>>>>    3 files changed, 58 insertions(+), 50 deletions(-)
>>>>>
>>>>> diff --git a/Makefile b/Makefile
>>>>> index 1851f8c..155f066 100644
>>>>> --- a/Makefile
>>>>> +++ b/Makefile
>>>>> @@ -87,6 +87,10 @@ endif
>>>>>    include $(SRC_PATH)/rules.mak
>>>>> +# notempy and lor are defined in rules.mak
>>>>> +CONFIG_TOOLS := $(call notempty,$(TOOLS))
>>>>> +CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
>>>>
>>>> IMHO calling this CONFIG_BLOCK is a really poor choice, as
>>>> the decision is completely unrelated to block modules. It
>>>> made really confused when trying to understand why all the
>>>> crypto or auth code had been made conditional on the block
>>>> drivers.  The block code is just one part of QEMU that
>>>> is used in tools & softmmu.
>>>>
>>>> It would be better as CONFIG_SOFTMMU_TOOLS, or
>>>> CONFIG_NOT_USER, or something else.
>>>
>>> Do you think it's worth a patch to change the name?
>>
>> Personally I'd like to see a patch to give it a better name.
> 
> I'm wondering which name to use.
> 
> CONFIG_NOT_USER is not correct because the flag can be 'y' with
> CONFIG_USER_ONLY set.
> CONFIG_SOFTMMU_TOOLS is too fuzzy.
> 
> CONFIG_HW ?
> CONFIG_IO ?
> CONFIG_DEVICE ?

CONFIG_MACHINE_HW?
CONFIG_MACHINE_IO_HELPERS?
CONFIG_AIO?

BTW looking at util/Makefile.objs there is various think you can skip
for linux-user IMO.

Regards,

Phil.

