Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38448C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BE020715
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi+1t43r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BE020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js8X3-0000vo-B2
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 13:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js8WO-0000Kz-RK; Sun, 05 Jul 2020 13:33:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js8WN-0003K2-4A; Sun, 05 Jul 2020 13:33:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so36738377wmj.2;
 Sun, 05 Jul 2020 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/77a0ybO+Kw7RMWAdeOvm0+LhAnrrdaO610FUUTjGq8=;
 b=Qi+1t43rikViELY32wR8eWRL5cPRFLOBoL+3jNV/eKCLPqrkXcPzHZIA2FMVFHVxx0
 bTTMWyonFamUylOUQru+fy0BYias7An+xiww5DNO6EHzw93n3aN0S1hADjtteubRhP0K
 PechcqEGWVmqbRaaJy653fJuSwNtiBvi4dRswIeOcMIAJdR7/ektWJYgTgKD5vahpHjg
 sGjOGFeaXiBZQF7sShD7XkUWoBViEz1gSjtksyvybFSfTP2aExvFEWafsWCfcwRaFAKl
 F2jBztgH4B8vbIvWAdAvV1oIl7SkPMIfwgaR8QaxPcH+Jk1kfoB4gZnIJeTfJUO2c19H
 Fvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/77a0ybO+Kw7RMWAdeOvm0+LhAnrrdaO610FUUTjGq8=;
 b=YhU7ZpRrQ5AoaqTlRsonNr7MmqiyMHA2t9eAtbPMife/aoYqzuRl8H2iz+6lOjrU9j
 RAFJs6IAz/FWo/tDmpK7aGWDkQ3Thxf4Go5q12xTezrabXeKh/+UhhzxDNkWsK7N8az6
 unU4Rqktk+ZrBkLwPloLoFcQR7ON7b4pQdR4TawfirNg+QqYVoXTuY7NkvlsYxSTkaWl
 fo4iweQc3r+hrRMQ2Xyi5HlBcF1+ducH5tREjx0fFoHDA7UxFxtlIenP32ETKPUGZCuX
 lWnPeUH4gxzxYCLWsV0Uv9jvNjiVb0djQyF8oWiHUbftNjVQfeHLdlJ9jJvVEanJ02La
 203g==
X-Gm-Message-State: AOAM532Amj0iqwNA1jpbThlS9b3ctkEy4ASASMuXcOcelUt6PNIQUVT/
 U+KUt88Y3n3jXwIM5PqO3rg=
X-Google-Smtp-Source: ABdhPJxPQt9Bdz8VRttbU47P72KDSqlvFNtg+5Pmo67kibc6XOvPNhZftC3ZowiUym1ydxaNB2Lk9A==
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr44981916wme.186.1593970420848; 
 Sun, 05 Jul 2020 10:33:40 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u8sm20107243wrt.28.2020.07.05.10.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2020 10:33:39 -0700 (PDT)
Subject: Re: [PATCH v7 09/17] hw/sd/sdcard: Special case the -ENOMEDIUM error
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-10-f4bug@amsat.org>
 <CAFEAcA_dhbr6cjK40H0=e39sD2r8ERTZYrY5nhJtx81Rk+RmUg@mail.gmail.com>
 <2c77e134-4762-89b2-b60d-aabde740f25f@amsat.org>
 <2a6b8801-038e-d67c-6d96-a3df526c44a0@amsat.org>
 <c016b643-3f5b-9064-3d86-639ec1497e88@amsat.org>
 <7ef59cd7-c137-9d0d-135f-c8a9ae3d8d0a@amsat.org>
 <96e9104a-fdca-332e-1f77-3fc82d93129f@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <d30ddf09-2dee-4364-ec7d-6d3191ba225d@amsat.org>
Date: Sun, 5 Jul 2020 19:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <96e9104a-fdca-332e-1f77-3fc82d93129f@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

On 7/5/20 12:26 AM, Philippe Mathieu-Daudé wrote:
> On 7/5/20 12:18 AM, Philippe Mathieu-Daudé wrote:
>> On 7/5/20 12:10 AM, Philippe Mathieu-Daudé wrote:
>>> On 7/4/20 1:42 AM, Philippe Mathieu-Daudé wrote:
>>>> On 7/3/20 5:16 PM, Philippe Mathieu-Daudé wrote:
>>>>> On 7/3/20 3:23 PM, Peter Maydell wrote:
>>>>>> On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>>>
>>>>>>> As we have no interest in the underlying block geometry,
>>>>>>> directly call blk_getlength(). We have to care about machines
>>>>>>> creating SD card with not drive attached (probably incorrect
>>>>>>> API use). Simply emit a warning when such Frankenstein cards
>>>>>>> of zero size are reset.
>>>>>>
>>>>>> Which machines create SD cards without a backing block device?
>>>>>
>>>>> The Aspeed machines:
>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg718116.html
>>>
>>> Also all boards using:
>>>
>>> hw/sd/milkymist-memcard.c:278:    /* FIXME use a qdev drive property
>>> instead of drive_get_next() */
>>> hw/sd/pl181.c:506:    /* FIXME use a qdev drive property instead of
>>> drive_get_next() */
>>> hw/sd/ssi-sd.c:253:    /* FIXME use a qdev drive property instead of
>>> drive_get_next() */
>>>
>>> I.e.:
>>>
>>> static void pl181_realize(DeviceState *dev, Error **errp)
>>> {
>>>     PL181State *s = PL181(dev);
>>>     DriveInfo *dinfo;
>>>
>>>     /* FIXME use a qdev drive property instead of drive_get_next() */
>>>     dinfo = drive_get_next(IF_SD);
>>>     s->card = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false);
>>>     if (s->card == NULL) {
>>>         error_setg(errp, "sd_init failed");
>>>     }
>>> }
>>
>> Doh I was pretty sure this series was merged:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg514645.html
>>
>> Time to respin I guess, addressing your comment...
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg515866.html
> 
> Not straight forward at first glance, so probably too late for soft
> freeze.

I looked in backups of my previous computer and found the branch with
your comment addressed... Not sure why I never send the series, but
this explains why I was sure it was already fixed.

> 
> Meanwhile patches 1-8 are reviewed and sufficient to fix
> CVE-2020-13253. The problematic patch is #9, your "Check address is
> in range" suggestion. Patches 11-14 are also reviewed and can go in.
> 
> Peter, can you consider taking them via your ARM queue? If you prefer
> I can prepare a pull request.
> 
> I'll keep working on this during the next dev window.
> 
> Thanks,
> 
> Phil.
> 
>>
>>>
>>>>>
>>>>>> I have a feeling that also the monitor "change" and "eject"
>>>>>> commands can remove the backing block device from the SD card
>>>>>> object.
>>>>>
>>>>> This is what I wanted to talk about on IRC. This seems wrong to me,
>>>>> we should eject the card and destroy it, and recreate a new card
>>>>> when plugging in another backing block device.
>>>>>
>>>>> Keep the reparenting on the bus layer, not on the card.
>>>>
>>>> I was wrong, the current code is correct:
>>>>
>>>> void sdbus_reparent_card(SDBus *from, SDBus *to)
>>>> {
>>>>     SDState *card = get_card(from);
>>>>     SDCardClass *sc;
>>>>     bool readonly;
>>>>
>>>>     /* We directly reparent the card object rather than implementing this
>>>>      * as a hotpluggable connection because we don't want to expose SD cards
>>>>      * to users as being hotpluggable, and we can get away with it in this
>>>>      * limited use case. This could perhaps be implemented more cleanly in
>>>>      * future by adding support to the hotplug infrastructure for "device
>>>>      * can be hotplugged only via code, not by user".
>>>>      */
>>>>
>>>>     if (!card) {
>>>>         return;
>>>>     }
>>>>
>>>>     sc = SD_CARD_GET_CLASS(card);
>>>>     readonly = sc->get_readonly(card);
>>>>
>>>>     sdbus_set_inserted(from, false);
>>>>     qdev_set_parent_bus(DEVICE(card), &to->qbus);
>>>>     sdbus_set_inserted(to, true);
>>>>     sdbus_set_readonly(to, readonly);
>>>> }
>>>>
>>>> What I don't understand is why create a sdcard with no block backend.
>>>>
>>>> Maybe this is old code before the null-co block backend existed? I
>>>> haven't checked the git history yet.
>>>>
>>>> I'll try to restrict sdcard with only block backend and see if
>>>> something break (I doubt) at least it simplifies the code.
>>>> But I need to update the Aspeed machines first.
>>>>
>>>> The problem when not using block backend, is the size is 0,
>>>> so the next patch abort in sd_reset() due to:
>>>>
>>>>   static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
>>>>   {
>>>>       assert(addr < sd->size);
>>>>
>>>
>>>
>>
> 

