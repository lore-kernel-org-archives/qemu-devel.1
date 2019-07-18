Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E6CC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34345208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34345208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoDwE-0003Bu-9M
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 17:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoDvv-0002ph-3k
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 17:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoDvj-0007nW-IV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 17:27:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoDvh-0007n3-Sa
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 17:27:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so27026471wme.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 14:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0m3j8nby2BCuV/i2845lU08nvIWXgmSLe5ZumLgIS+c=;
 b=hcCGCVILE65blMHoED9Kja1KDafmi8yl6VtGoE4Nwiv6chKaOWOklEODQs6eaVpSfp
 3SHZgEomI2/LXHZFwvIWlm0+xhqUUihiNNQ1u40/PdKYOktgnGFtVdBMjx3RIZPoQou7
 mlFLplwjiDUaHhgSdPi0AfzeUCPNFPzPa1anwSgEzaNkFnB/HovjiwXn+AlardRgD84o
 kempGvuD736y4cJCytTXUK6yhVTO5z+kLZS5Ea/oA2RXf1IhiAcu2roIVVblCDlkBXz0
 vv88xxLvmostbeTpS24w/LOuz5qzvQROCk3vJncQSyi8k01NNWfFOBSrA8tl1Ar885C5
 29iw==
X-Gm-Message-State: APjAAAVHKmCFkPX+csCa+9QHxAi7FSOimDeJhGLwso5Lh//TskZcF21Q
 ridsIYtJay2Dbikgp5yKLIU7FREouQU=
X-Google-Smtp-Source: APXvYqx0aedLBBEOxbgNFY/ZjQ6QsLfLeNkYuU972Ogi9iyiaSyvKm8u1MZ+Wj54HwX9cCg/VPO8Gw==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr45174236wmk.14.1563478521212; 
 Thu, 18 Jul 2019 12:35:21 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id c1sm54437286wrh.1.2019.07.18.12.35.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 12:35:20 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
 <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
 <d4d20337-b504-0610-8aaf-c8b0b13f0953@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <053eeafe-4e93-aa96-f544-ea0606e244b6@redhat.com>
Date: Thu, 18 Jul 2019 21:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d4d20337-b504-0610-8aaf-c8b0b13f0953@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

On 7/18/19 8:38 PM, Laszlo Ersek wrote:
> On 07/18/19 17:03, Laszlo Ersek wrote:
>> On 07/18/19 12:48, Philippe Mathieu-Daudé wrote:
>>> To avoid incoherent states when the machine resets (see but report
>>
>> (1) For the PULL request, please fix the typo: s/but/bug/
>>
>>> below), add the device reset callback.
>>>
>>> A "system reset" sets the device state machine in READ_ARRAY mode
>>> and, after some delay, set the SR.7 READY bit.
>>>
>>> Since we do not model timings, we set the SR.7 bit directly.
>>>
>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1678713
>>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  hw/block/pflash_cfi01.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>> index 435be1e35c..a1ec1faae5 100644
>>> --- a/hw/block/pflash_cfi01.c
>>> +++ b/hw/block/pflash_cfi01.c
>>> @@ -865,6 +865,24 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>>>      pfl->cfi_table[0x3f] = 0x01; /* Number of protection fields */
>>>  }
>>>  
>>> +static void pflash_cfi01_system_reset(DeviceState *dev)
>>> +{
>>> +    PFlashCFI01 *pfl = PFLASH_CFI01(dev);
>>> +
>>> +    /*
>>> +     * The command 0x00 is not assigned by the CFI open standard,
>>> +     * but QEMU historically uses it for the READ_ARRAY command (0xff).
>>> +     */
>>> +    pfl->cmd = 0x00;
>>> +    pfl->wcycle = 0;
>>> +    memory_region_rom_device_set_romd(&pfl->mem, true);
>>> +    /*
>>> +     * The WSM ready timer occurs at most 150ns after system reset.
>>> +     * This model deliberately ignores this delay.
>>> +     */
>>> +    pfl->status = 0x80;
>>> +}
>>> +
>>>  static Property pflash_cfi01_properties[] = {
>>>      DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
>>>      /* num-blocks is the number of blocks actually visible to the guest,
>>> @@ -909,6 +927,7 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>>>  {
>>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>>  
>>> +    dc->reset = pflash_cfi01_system_reset;
>>>      dc->realize = pflash_cfi01_realize;
>>>      dc->props = pflash_cfi01_properties;
>>>      dc->vmsd = &vmstate_pflash;
>>>
>>

s/but/bug/ typo fixed.

>> (2) Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

>>
>> A *future* improvement (meant just for this surgical reset handler --
>> not meaning any large cfi01 overhaul!) could be the addition of a trace
>> point, at the top of pflash_cfi01_system_reset().
>>
>> But that is strictly "nice to have", and not necessary to include in the
>> present bugfix.
>>
>>
>> (3) Using OVMF IA32X64 (including the edk2 SMM stack), I've
>> regression-tested this patch, on top of v4.1.0-rc1, with KVM. As follows:
>>
>> (3a) Normal reboot from the UEFI shell ("reset -c" command)
>>
>> (3b) Normal reboot from the Linux guest prompt ("reboot" command)
>>
>> (3c1) Reset as part of ACPI S3 suspend/resume
>> (3c2) then use "efibootmgr -n / -N" to write to pflash (by virtue of
>> setting / deleting the standardized BootNext UEFI variable)
>>
>> (3d1) Boot to setup TUI with SB enabled
>> (3d2) erase Platform Key in setup TUI (disables SB)
>> (3d3) reboot from within setup TUI
>> (3d4) proceed to UEFI shell
>> (3d5) enable SB with EnrollDefaultKeys.efi
>> (3d6) reboot from UEFI shell
>> (3d7) proceeed to Linux guest
>> (3d8) verify SB enablement (dmesg, "mokutil --sb-state")
>>
>> (As an added exercise, step (3d4) triggered an "FTW" (fault tolerant
>> write) "reclaim" (basically a defragmentation of the journaled
>> "filesystem" that the firmware keeps in the flash, as a logical "middle
>> layer"), and that worked fine too.)
>>
>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>
>>
>> (4) I plan to provide R-t-b in the evening from aarch64 KVM too, using
>> the edk2 ArmVirtQemu firmware. Only the first two steps from (3) will be
>> covered (no ACPI S3, no SB).
> 
> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>

Thank you a lot again for all your testing, I also noted your steps and
will try to automate them.

Best regards,

Phil.

