Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA762C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92323206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqhjOt1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92323206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvf77-0006cK-TR
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvf6D-00060g-C5; Wed, 15 Jul 2020 06:57:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvf6B-0007yh-9b; Wed, 15 Jul 2020 06:57:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id f18so2180700wrs.0;
 Wed, 15 Jul 2020 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Algzz4GNV7yGriQ5drDv1xVZxf0blKOavMpubZiEnG8=;
 b=OqhjOt1wH2kCXElmEBjkATheJBpGMTLqHfvgbacOqppiEJaY3jrE2y623Y92Li8fNq
 bLwZa01I5zIqk4nnKEqkASAAdrwJ5TMZkeSKETDekeBVEDzATwDTyQZ0+wpSC3iL6M9A
 aK88uWifN0MTq8GcHBJKqbYFzXB7GKFLgTGUm3YYWUTjnDutXOlY434uuPnKorQy4Xv3
 WNZUIXRMDJZ0CsVhMHCL6SK8/Rljt5iC7hzKglXYI+f1NwP7Ultbq9twad+pCD/K1hAh
 uZITc2aqWkbVYnk2jnUDv3YJv5ujdpuDNW5ZTeg3GHLMFsL5KSfXkK7F/zd587ocpM8p
 05CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Algzz4GNV7yGriQ5drDv1xVZxf0blKOavMpubZiEnG8=;
 b=M+ADDMUf4WSgatMdEUki4lq/3LCNG4jAY5f9QrXIN8IvoM6Pioe6xjOLdJoPspiL4T
 NP6TL10nLMkSR9W+U5RXWnNrbifyuBB5jFVA5l+35SigUM7QfttvGKV5wdNZP5i3/K9s
 ENZrim9Ci5I6sRKoEDq5SU+NMnOUppuSXRGjhp3QUZ2XEoN8UqzJju5xR6r8LHaGzZi5
 F7StfLUvxk/srJFHjVXxtLPEKPUBQ6/qz+vHm+GQtv05NV9ZnDAdSTL79/Im6cIY88Lx
 xXo3Oyy5WzpOCkmxD46t8j3E2vyp+JAoAMHUY9axk/Qrwp13KwINOyrSHW1c9ENBAVX8
 yRmA==
X-Gm-Message-State: AOAM533cBf64YO+K25RBjvu5RUerfklC+d1qauGS9dk5+9LwR/aVDdqh
 PUxzfyjOu0AiaVjEPdFyxbw=
X-Google-Smtp-Source: ABdhPJw+ewMUTSiQy1M9lqpulJRGth5fqhcMcdBj3uz90wlsCeA2X0OszZ5keOhN7gU+rUFBSxAAtw==
X-Received: by 2002:adf:f311:: with SMTP id i17mr10992951wro.237.1594810632707; 
 Wed, 15 Jul 2020 03:57:12 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d81sm11716800wmc.0.2020.07.15.03.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 03:57:11 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Markus Armbruster <armbru@redhat.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
 <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
 <87v9iq2hkv.fsf@dusky.pond.sub.org>
 <e87663cf-7cb2-ca6c-a751-e5c1cebc5440@amsat.org>
 <87pn8xywz2.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b3bc658f-a865-8e6b-c904-01c7724e89cc@amsat.org>
Date: Wed, 15 Jul 2020 12:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87pn8xywz2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Havard Skinnemoen <hskinnemoen@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/20 11:00 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 7/14/20 6:21 PM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>
>>>> + qemu-block experts.
>>>>
>>>> On 7/14/20 11:16 AM, Markus Armbruster wrote:
>>>>> Havard Skinnemoen <hskinnemoen@google.com> writes:
>>>>>
>>>>>> On Mon, Jul 13, 2020 at 7:57 AM Cédric Le Goater <clg@kaod.org> wrote:
>>>>>>>
>>>>>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>>>>>>> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
>>>>>>>> one built with OpenBMC. For example like this:
>>>>>>>>
>>>>>>>> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
>>>>>>>> qemu-system-arm -machine quanta-gsj -nographic \
>>>>>>>>       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
>>>>>>>>       -drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
>>>>>>>>
>>>>>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>>>>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>>>>>
>>>>>>> May be we don't need to create the flash object if dinfo is NULL.
>>>>>>
>>>>>> It's soldered on the board, so you can't really boot the board without
>>>>>> it. But if you think it's better to remove it altogether if we don't
>>>>>> have an image to load into it, I can do that.
>>>>>
>>>>> If a device is a fixed part of the physical board, it should be a fixed
>>>>> part of the virtual board, too.
>>>>
>>>> We agree so far but ... how to do it?
>>>>
>>>> I never used this API, does that makes sense?
>>>>
>>>>     if (!dinfo) {
>>>>         QemuOpts *opts;
>>>>
>>>>         opts = qemu_opts_create(NULL, "spi-flash", 1, &error_abort);
>>>>         qdict_put_str(opts, "format", "null-co");
>>>>         qdict_put_int(opts, BLOCK_OPT_SIZE, 64 * MiB);
>>>>         qdict_put_bool(opts, NULL_OPT_ZEROES, false); // XXX
>>>>
>>>>         dinfo = drive_new(opts, IF_MTD, &error_abort);
>>>>         qemu_opts_del(opts);
>>>>     }
>>>
>>> I believe existing code special-cases "no backend" instead of making one
>>> up.
>>>
>>> Example: pflash_cfi0?.c
>>>
>>> If ->blk is non-null, we read its contents into the memory buffer and
>>> write updates back, else we leave it blank and don't write updates back.
>>>
>>> Making one up could be more elegant.  To find out, you have to try.
>>
>> I'd rather avoid ad-hoc code in each device. I2C EEPROM do that too,
>> it is a source of head aches.
>>
>> >From the emulation PoV I'd prefer to always use a block backend,
>> regardless the user provide a drive.
>>
>>>
>>> We make up a few default drives (i.e. drives the user doesn't specify):
>>> floppy, CD-ROM and SD card.  Ancient part of the user interface, uses
>>> DriveInfo.  I doubt we should create more of them.
>>>
>>> I believe block backends we make up for internal use should stay away
>>> from DriveInfo.  Kevin, what do you think?  How would you make up a
>>> null-co block backend for a device's internal use?
>>
>> I read 'DriveInfo' is the legacy interface, but all the code base use it
>> so it is confusing, I don't understand what is the correct interface to
>> use.
> 
> I admit the "legacy" bit is still aspirational.  We still haven't
> managed to replace it for configuring certain onboard devices.
> 
> The thing being configured is a device's BlockBackend.
> 
> To understand the point I'm trying to make, please ignore "legacy", and
> focus on the actual purpose of DriveInfo: it's (one kind of) user
> configuration for a BlockBackend.
> 
> Now let me try to state the problem you're trying to solve.  Instead of
> special-casing "no backend" in device code like pflash_cfi0?.c do, you
> want to make up a "dummy" backend instead.  You need the dummy to read
> some blank value and ignore writes.  One of the null block drivers
> should fit the bill.
> 
> Now my point.  Why first make up user configuration, then use that to
> create a BlockBackend, when you could just go ahead and create the
> BlockBackend?

CLI issue mostly.

We can solve it similarly to the recent "sdcard: Do not allow invalid SD
card sizes" patch:

 if (!dinfo) {
     error_setg(errp, "Missing SPI flash drive");
     error_append_hint(errp, "You can use a dummy drive using:\n");
     error_append_hint(errp, "-drive if=mtd,driver=null-co,"
                             "read-ones=on,size=64M\n);
     return;
 }

having npcm7xx_connect_flash() taking an Error* argument,
and MachineClass::init() call it with &error_fatal.

> 
> Sadly, I'm not sufficiently familiar with the block API anymore to tell
> you exactly how.  blk_new_with_bs() looks promising.  Perhaps Kevin can
> advise.
> 
>>>> We should probably add a public helper for that.
>>>
>>> If we decide we want to make up backends, then yes, we should do that in
>>> a helper, not in each device.
>>>
>>>> 'XXX' because NOR flashes erase content is when hardware bit
>>>> is set, so it would be more useful to return -1/0xff... rather
>>>> than zeroes.

