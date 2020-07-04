Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436FDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 22:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB9820826
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 22:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDx5g/XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB9820826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrqN6-000856-5z
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 18:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrqMU-0007Zl-BG; Sat, 04 Jul 2020 18:10:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrqMS-0003PP-J6; Sat, 04 Jul 2020 18:10:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id q5so36605344wru.6;
 Sat, 04 Jul 2020 15:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9PXFaPaCJ2MY2an9cSEo6pK4pX92E0R6Nj0L97JlzyI=;
 b=PDx5g/XO4Mrj2atGTo+4mdvueTKpJpJUsWkAsmd998qgoHeETZaHxNK4iOaStDNrml
 vWYrSTLvcC7XKkSZfdWGT/uQ6bK65CyD4qR7clAA3yUb5Rhrreev+kN3Bl+bGelMnHD/
 FCkBxL10bxP0qChkvKqVV/Ho8GXvdf+Mv5EPMEd3GOq0h89v8OoUBgEW5ffOZyoRx6/D
 H0g1Cpc0R4jGku0qz1PfPUOPI10KCUJH5gmsK+4rx/AbvyFxqyJadAL5wBjshOu/3OTI
 Ml6B55lzzxJvg0Bnf6TTQ0P/d7qjPHGyU99rqiFJqRNziAYV83V0PIJUvFD3P6VGUpGY
 LKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9PXFaPaCJ2MY2an9cSEo6pK4pX92E0R6Nj0L97JlzyI=;
 b=XUNnF3IerUXsjG1OeXf/6jksnWw8vO+78JLV4UWOj+UPQRpnMckRxd2ra92yimeioM
 gF4RZGVvboB4ahNURdgn9Pwz5bYgK4Yn+KAEmKrHtM4G3lTU6z4PiofkiG9qD/JG5nMU
 giA1cjlEt/SFw1fPJNLedHaXTI6Y6LTnJ+CUWF0IxNk0ImOPXV+bRhYQk6f/i7gdbWEp
 SyhhPurNYuyrMzE6cfl8x+r1m7yWd+0VGd0Jc/J/4mLT0BP9A9EGpPOaLZ8H8GgAoJEf
 lNv7lnqdz4hojCyb8E1cQXe0o7yI4L/jxKeo698kcUU94MeXyHHBwV7nfNrIy8c5f9Ma
 7Etw==
X-Gm-Message-State: AOAM531KI643BiGFu+DQ7BW3o1ioWI/GQr7MWbxbvVl7kw4n87Zhxcgv
 3KQj8QGtuCGoK3lSnhfoonY=
X-Google-Smtp-Source: ABdhPJyXC0rNAm65lz10KqBdXwjMrLYeW7r+nNJiG0o+tIscAPVQDMGsEfSK2RgAUhEk/U7qQNDdig==
X-Received: by 2002:adf:dd81:: with SMTP id x1mr41918834wrl.7.1593900614513;
 Sat, 04 Jul 2020 15:10:14 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm18592779wrw.53.2020.07.04.15.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 15:10:13 -0700 (PDT)
Subject: Re: [PATCH v7 09/17] hw/sd/sdcard: Special case the -ENOMEDIUM error
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-10-f4bug@amsat.org>
 <CAFEAcA_dhbr6cjK40H0=e39sD2r8ERTZYrY5nhJtx81Rk+RmUg@mail.gmail.com>
 <2c77e134-4762-89b2-b60d-aabde740f25f@amsat.org>
 <2a6b8801-038e-d67c-6d96-a3df526c44a0@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c016b643-3f5b-9064-3d86-639ec1497e88@amsat.org>
Date: Sun, 5 Jul 2020 00:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2a6b8801-038e-d67c-6d96-a3df526c44a0@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eddie James <eajames@linux.vnet.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 1:42 AM, Philippe Mathieu-Daudé wrote:
> On 7/3/20 5:16 PM, Philippe Mathieu-Daudé wrote:
>> On 7/3/20 3:23 PM, Peter Maydell wrote:
>>> On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> As we have no interest in the underlying block geometry,
>>>> directly call blk_getlength(). We have to care about machines
>>>> creating SD card with not drive attached (probably incorrect
>>>> API use). Simply emit a warning when such Frankenstein cards
>>>> of zero size are reset.
>>>
>>> Which machines create SD cards without a backing block device?
>>
>> The Aspeed machines:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg718116.html

Also all boards using:

hw/sd/milkymist-memcard.c:278:    /* FIXME use a qdev drive property
instead of drive_get_next() */
hw/sd/pl181.c:506:    /* FIXME use a qdev drive property instead of
drive_get_next() */
hw/sd/ssi-sd.c:253:    /* FIXME use a qdev drive property instead of
drive_get_next() */

I.e.:

static void pl181_realize(DeviceState *dev, Error **errp)
{
    PL181State *s = PL181(dev);
    DriveInfo *dinfo;

    /* FIXME use a qdev drive property instead of drive_get_next() */
    dinfo = drive_get_next(IF_SD);
    s->card = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false);
    if (s->card == NULL) {
        error_setg(errp, "sd_init failed");
    }
}



>>
>>> I have a feeling that also the monitor "change" and "eject"
>>> commands can remove the backing block device from the SD card
>>> object.
>>
>> This is what I wanted to talk about on IRC. This seems wrong to me,
>> we should eject the card and destroy it, and recreate a new card
>> when plugging in another backing block device.
>>
>> Keep the reparenting on the bus layer, not on the card.
> 
> I was wrong, the current code is correct:
> 
> void sdbus_reparent_card(SDBus *from, SDBus *to)
> {
>     SDState *card = get_card(from);
>     SDCardClass *sc;
>     bool readonly;
> 
>     /* We directly reparent the card object rather than implementing this
>      * as a hotpluggable connection because we don't want to expose SD cards
>      * to users as being hotpluggable, and we can get away with it in this
>      * limited use case. This could perhaps be implemented more cleanly in
>      * future by adding support to the hotplug infrastructure for "device
>      * can be hotplugged only via code, not by user".
>      */
> 
>     if (!card) {
>         return;
>     }
> 
>     sc = SD_CARD_GET_CLASS(card);
>     readonly = sc->get_readonly(card);
> 
>     sdbus_set_inserted(from, false);
>     qdev_set_parent_bus(DEVICE(card), &to->qbus);
>     sdbus_set_inserted(to, true);
>     sdbus_set_readonly(to, readonly);
> }
> 
> What I don't understand is why create a sdcard with no block backend.
> 
> Maybe this is old code before the null-co block backend existed? I
> haven't checked the git history yet.
> 
> I'll try to restrict sdcard with only block backend and see if
> something break (I doubt) at least it simplifies the code.
> But I need to update the Aspeed machines first.
> 
> The problem when not using block backend, is the size is 0,
> so the next patch abort in sd_reset() due to:
> 
>   static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
>   {
>       assert(addr < sd->size);
> 


