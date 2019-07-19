Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63D6C76196
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2972187F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2972187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVdY-0001o5-OD
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41708)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoVdO-0001Om-06
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoVdK-0006aO-Ms
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:21:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoVdH-0005os-Hc
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:21:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so29559515wmg.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 09:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lMLEHYq1lF3SL7S4vH9R5InFtmF70xVFRidgXaJJYis=;
 b=b7/yQYM5xfHkuTVlac88bMao0KhUHt9OnMOeheCyMqjX/3jx2zIUkPkwBk4PKBLdd9
 X+Un15vdudb/t42VhJrtAQftLKdQnDQ8+d6RaIu2VzprRYw8X95q0g6LOBq4h5NDvh7N
 VShHMe8BkAfP4FABKDGDNgNVUV0hp2Jw7zk4VFNCN+ueuizFqJeHOr4WLbAdsZhowQ02
 O9NEZzDsHlnsrSWzM8bPSngfuBpY186a4u2Sc1BdInJ1+YEpoICSl+eE35vpTkzdc9ig
 TVAiCE30Grtzow9jXM+Mlnx+Q9dIGGGMPrduhF8WsDFv0rVR+KICLnM+uAJlLb3kx/DU
 iGMQ==
X-Gm-Message-State: APjAAAU3raAJdNbQakmqlbnnLD7vqS+HM+8+NSS7lgxF3jKYdEvpxG8B
 vVSm/pRwhGYqGh/XQCy3LCwCVA==
X-Google-Smtp-Source: APXvYqyjowYxnKUSoqjt3PS/TZrbJhh78u6ts/QUE3yriokFBKORoq30vlOJ5t7R6RdkJMYnb2VK6Q==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr47911107wmf.162.1563553184044; 
 Fri, 19 Jul 2019 09:19:44 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id v16sm10141824wrn.28.2019.07.19.09.19.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 09:19:43 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
 <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
 <d4d20337-b504-0610-8aaf-c8b0b13f0953@redhat.com>
 <053eeafe-4e93-aa96-f544-ea0606e244b6@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <689b75f8-ae47-621f-44a5-f3ad07fe2661@redhat.com>
Date: Fri, 19 Jul 2019 18:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <053eeafe-4e93-aa96-f544-ea0606e244b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
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

Hi Laszlo,

On 7/18/19 9:35 PM, Philippe Mathieu-Daudé wrote:
> On 7/18/19 8:38 PM, Laszlo Ersek wrote:
>> On 07/18/19 17:03, Laszlo Ersek wrote:
>>> On 07/18/19 12:48, Philippe Mathieu-Daudé wrote:
>>>> To avoid incoherent states when the machine resets (see but report
[...]>>> (3) Using OVMF IA32X64 (including the edk2 SMM stack), I've
>>> regression-tested this patch, on top of v4.1.0-rc1, with KVM. As follows:
>>>
>>> (3a) Normal reboot from the UEFI shell ("reset -c" command)
>>>
>>> (3b) Normal reboot from the Linux guest prompt ("reboot" command)
>>>
>>> (3c1) Reset as part of ACPI S3 suspend/resume
>>> (3c2) then use "efibootmgr -n / -N" to write to pflash (by virtue of
>>> setting / deleting the standardized BootNext UEFI variable)
>>>
>>> (3d1) Boot to setup TUI with SB enabled
>>> (3d2) erase Platform Key in setup TUI (disables SB)
>>> (3d3) reboot from within setup TUI
>>> (3d4) proceed to UEFI shell
>>> (3d5) enable SB with EnrollDefaultKeys.efi
>>> (3d6) reboot from UEFI shell
>>> (3d7) proceeed to Linux guest
>>> (3d8) verify SB enablement (dmesg, "mokutil --sb-state")
>>>
>>> (As an added exercise, step (3d4) triggered an "FTW" (fault tolerant
>>> write) "reclaim" (basically a defragmentation of the journaled
>>> "filesystem" that the firmware keeps in the flash, as a logical "middle
>>> layer"), and that worked fine too.)
>>>
>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>>
>>>
>>> (4) I plan to provide R-t-b in the evening from aarch64 KVM too, using
>>> the edk2 ArmVirtQemu firmware. Only the first two steps from (3) will be
>>> covered (no ACPI S3, no SB).
>>
>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>

Patchwork doesn't recognize your R-t-b tag:

https://patchwork.ozlabs.org/patch/1133671/

Should I change it for a Tested-by, or add as it?

Thanks,

Phil.

> Thank you a lot again for all your testing, I also noted your steps and
> will try to automate them.
> 
> Best regards,
> 
> Phil.
> 

