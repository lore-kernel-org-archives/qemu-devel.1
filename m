Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC45BC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B1B21738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B1B21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbb0-0006HK-Sf
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpbap-0005oa-Fv
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpbao-0000fc-94
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:55:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpbao-0000f5-2x
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:55:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so40134389wrf.11
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 09:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i8+SG5BzgRYs0d8Oly9utjOnDocTeJIsTWPxBbwXnqA=;
 b=COpKzE9jLA9lQtvWEBp/+t57/8REG1YgPa6R7aiqGoUiubZvlPyUB8BDZ+OskP1ZgQ
 fHPP3MJ0MURXbljmR7bqvfKyP3b7cWS1SwWrlgZiPsG8FtUe5U4Npfu32SE40fo/KbaD
 QkQHfoxo8SxEQrhhYG2OAJlX/uDdqO4FDEGrE0FEWR99Dj+kgE4kQDIWGgl5Km3C+wCo
 p6Vs40SvL53xAgSLgqWOv6wpGylWIUBkvuaOkrpIvnMdHq2xRz4VGUpuezDBuMjP07+D
 iaChkRhNGpeYfHNqMcyWdU266Ef5ZPrQcs0YV9auG9k5fnNeSOUs+743wfojsA/6xqUx
 8hkg==
X-Gm-Message-State: APjAAAV8m4ZZpmU7jYgCI9cLLcGJBPR/+6Mo7HehLDRTg4IrPpSB5DhG
 /MXEODsJs2XZLjHLjBrEbKoJMA==
X-Google-Smtp-Source: APXvYqzT2ArIpP8D6RtBZGOhssR61AovtYNS1uO4GqSGKFQ/rxm+Gkcop2W5yto+n9Ym5b5oeYEs4Q==
X-Received: by 2002:adf:ed0e:: with SMTP id a14mr75999927wro.259.1563814517069; 
 Mon, 22 Jul 2019 09:55:17 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o26sm76394504wro.53.2019.07.22.09.55.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 09:55:16 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
 <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
 <d4d20337-b504-0610-8aaf-c8b0b13f0953@redhat.com>
 <053eeafe-4e93-aa96-f544-ea0606e244b6@redhat.com>
 <689b75f8-ae47-621f-44a5-f3ad07fe2661@redhat.com>
 <63ff0471-aa50-f60d-417b-c42d315e02e3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fbb34509-7680-63b3-7ee6-baffe05d0f60@redhat.com>
Date: Mon, 22 Jul 2019 18:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <63ff0471-aa50-f60d-417b-c42d315e02e3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v7 1/1] hw/block/pflash_cfi01: Add
 missing DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/19 6:51 PM, Laszlo Ersek wrote:
> On 07/19/19 18:19, Philippe Mathieu-Daudé wrote:
>> Hi Laszlo,
>>
>> On 7/18/19 9:35 PM, Philippe Mathieu-Daudé wrote:
>>> On 7/18/19 8:38 PM, Laszlo Ersek wrote:
>>>> On 07/18/19 17:03, Laszlo Ersek wrote:
>>>>> On 07/18/19 12:48, Philippe Mathieu-Daudé wrote:
>>>>>> To avoid incoherent states when the machine resets (see but report
>> [...]>>> (3) Using OVMF IA32X64 (including the edk2 SMM stack), I've
>>>>> regression-tested this patch, on top of v4.1.0-rc1, with KVM. As follows:
>>>>>
>>>>> (3a) Normal reboot from the UEFI shell ("reset -c" command)
>>>>>
>>>>> (3b) Normal reboot from the Linux guest prompt ("reboot" command)
>>>>>
>>>>> (3c1) Reset as part of ACPI S3 suspend/resume
>>>>> (3c2) then use "efibootmgr -n / -N" to write to pflash (by virtue of
>>>>> setting / deleting the standardized BootNext UEFI variable)
>>>>>
>>>>> (3d1) Boot to setup TUI with SB enabled
>>>>> (3d2) erase Platform Key in setup TUI (disables SB)
>>>>> (3d3) reboot from within setup TUI
>>>>> (3d4) proceed to UEFI shell
>>>>> (3d5) enable SB with EnrollDefaultKeys.efi
>>>>> (3d6) reboot from UEFI shell
>>>>> (3d7) proceeed to Linux guest
>>>>> (3d8) verify SB enablement (dmesg, "mokutil --sb-state")
>>>>>
>>>>> (As an added exercise, step (3d4) triggered an "FTW" (fault tolerant
>>>>> write) "reclaim" (basically a defragmentation of the journaled
>>>>> "filesystem" that the firmware keeps in the flash, as a logical "middle
>>>>> layer"), and that worked fine too.)
>>>>>
>>>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>>>>
>>>>>
>>>>> (4) I plan to provide R-t-b in the evening from aarch64 KVM too, using
>>>>> the edk2 ArmVirtQemu firmware. Only the first two steps from (3) will be
>>>>> covered (no ACPI S3, no SB).
>>>>
>>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>
>> Patchwork doesn't recognize your R-t-b tag:
>>
>> https://patchwork.ozlabs.org/patch/1133671/
>>
>> Should I change it for a Tested-by, or add as it?
> 
> Please pick it up manually, as it is, if that's possible.
> 
> I prefer to dedicate "Tested-by" to cases where my before-after
> comparison highlights a difference (i.e., bug disappears, or feature
> appears). I dedicate "R-t-b" to cases where nothing observable changes
> (in accordance with my expectation).

OK, thanks for your explanation!

> 
> Thanks!
> Laszlo
> 
>>> Thank you a lot again for all your testing, I also noted your steps and
>>> will try to automate them.

