Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A68C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 22:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386B020771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 22:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is4JOP8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386B020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrqdL-0006V4-De
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 18:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrqcV-0005ov-5W; Sat, 04 Jul 2020 18:26:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrqcT-0006Ao-Dh; Sat, 04 Jul 2020 18:26:50 -0400
Received: by mail-wr1-x42c.google.com with SMTP id q5so36643570wru.6;
 Sat, 04 Jul 2020 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PB2z5WNGb/w/wljHyEVC0qduwISA1c9tCYUYJS5M6VU=;
 b=Is4JOP8DwIy8ojzgr6L3Q4R7BFDmn7N/RqhWFAx6rS4f5ojUrGgGHOl3EOFw/BF04e
 O5nmMz/p0b9McDW5TD2p2YvAm75vBa6C/eqox1MN2rUfwOmXI0O9EllYyo2Hgqoenn4P
 EmnUMvSNmjXC1SSZihtOkMf2JsscArg3C8shSEsM6WGe82vz+oc23zP+VaSp6eCn9AOb
 Nzp4FdOYj8tnxSdxhM4ZVf73sPpiGrL3yj83ThSxwYMRldBB4QINSeVSIVETyxCIUCF2
 skGj61cBFenlELCkiVtD6DMXAmOLSd+VcO8pM7zU97tyueEd8HYG0sX+2TiTdE802cIY
 41iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PB2z5WNGb/w/wljHyEVC0qduwISA1c9tCYUYJS5M6VU=;
 b=bGCwWILUHlnYfgm0qw67VQQhUjmkWcB9RlcnRPuuC2sheqC16B/xwMx/UCJ6ls4uFw
 3qLaEWQKwamSOAiIxPd3J9GSj/OU2Ij6B+jqQsEl9dir9Oa3fFC2NFUPGrGk10ct+gdy
 Bm7hSXIVtcQp2HQgNC//ZZWIXkyZhKT84jF8trh4t1jtfmkuJPThlkzgk3v+VArpgSHx
 aSrPKx1Pt91XB9JH3JGui7YUzR7Crjkvu88BvegXQlEjV5Tjs9o36Et72eiEw/shiXly
 PEY599TfHedGGEIGuywuxANgpruSHIjyWscJjqlQOnPce7VyxV7q0lsmYi2SUdxIfnkd
 iknQ==
X-Gm-Message-State: AOAM530kjxM9DJZJAoJTke/fAS05XPis59IHwjA8PYytCsTH/5Nj0Pjt
 CE5Mnj/hKTdnjABfWQBe+Cc=
X-Google-Smtp-Source: ABdhPJz0dzOyAisEQ+SYQ+0urrAF3BQbp1YIk+0rwCDOZNbmRgAw1qpW+XGQxuyK3sTRSj+wESc5pg==
X-Received: by 2002:adf:f889:: with SMTP id u9mr46412017wrp.149.1593901607674; 
 Sat, 04 Jul 2020 15:26:47 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id m16sm13641257wro.0.2020.07.04.15.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 15:26:46 -0700 (PDT)
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
Message-ID: <96e9104a-fdca-332e-1f77-3fc82d93129f@amsat.org>
Date: Sun, 5 Jul 2020 00:26:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7ef59cd7-c137-9d0d-135f-c8a9ae3d8d0a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
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

On 7/5/20 12:18 AM, Philippe Mathieu-Daudé wrote:
> On 7/5/20 12:10 AM, Philippe Mathieu-Daudé wrote:
>> On 7/4/20 1:42 AM, Philippe Mathieu-Daudé wrote:
>>> On 7/3/20 5:16 PM, Philippe Mathieu-Daudé wrote:
>>>> On 7/3/20 3:23 PM, Peter Maydell wrote:
>>>>> On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>>
>>>>>> As we have no interest in the underlying block geometry,
>>>>>> directly call blk_getlength(). We have to care about machines
>>>>>> creating SD card with not drive attached (probably incorrect
>>>>>> API use). Simply emit a warning when such Frankenstein cards
>>>>>> of zero size are reset.
>>>>>
>>>>> Which machines create SD cards without a backing block device?
>>>>
>>>> The Aspeed machines:
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg718116.html
>>
>> Also all boards using:
>>
>> hw/sd/milkymist-memcard.c:278:    /* FIXME use a qdev drive property
>> instead of drive_get_next() */
>> hw/sd/pl181.c:506:    /* FIXME use a qdev drive property instead of
>> drive_get_next() */
>> hw/sd/ssi-sd.c:253:    /* FIXME use a qdev drive property instead of
>> drive_get_next() */
>>
>> I.e.:
>>
>> static void pl181_realize(DeviceState *dev, Error **errp)
>> {
>>     PL181State *s = PL181(dev);
>>     DriveInfo *dinfo;
>>
>>     /* FIXME use a qdev drive property instead of drive_get_next() */
>>     dinfo = drive_get_next(IF_SD);
>>     s->card = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false);
>>     if (s->card == NULL) {
>>         error_setg(errp, "sd_init failed");
>>     }
>> }
> 
> Doh I was pretty sure this series was merged:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg514645.html
> 
> Time to respin I guess, addressing your comment...
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg515866.html

Not straight forward at first glance, so probably too late for soft
freeze.

Meanwhile patches 1-8 are reviewed and sufficient to fix
CVE-2020-13253. The problematic patch is #9, your "Check address is
in range" suggestion. Patches 11-14 are also reviewed and can go in.

Peter, can you consider taking them via your ARM queue? If you prefer
I can prepare a pull request.

I'll keep working on this during the next dev window.

Thanks,

Phil.

> 
>>
>>>>
>>>>> I have a feeling that also the monitor "change" and "eject"
>>>>> commands can remove the backing block device from the SD card
>>>>> object.
>>>>
>>>> This is what I wanted to talk about on IRC. This seems wrong to me,
>>>> we should eject the card and destroy it, and recreate a new card
>>>> when plugging in another backing block device.
>>>>
>>>> Keep the reparenting on the bus layer, not on the card.
>>>
>>> I was wrong, the current code is correct:
>>>
>>> void sdbus_reparent_card(SDBus *from, SDBus *to)
>>> {
>>>     SDState *card = get_card(from);
>>>     SDCardClass *sc;
>>>     bool readonly;
>>>
>>>     /* We directly reparent the card object rather than implementing this
>>>      * as a hotpluggable connection because we don't want to expose SD cards
>>>      * to users as being hotpluggable, and we can get away with it in this
>>>      * limited use case. This could perhaps be implemented more cleanly in
>>>      * future by adding support to the hotplug infrastructure for "device
>>>      * can be hotplugged only via code, not by user".
>>>      */
>>>
>>>     if (!card) {
>>>         return;
>>>     }
>>>
>>>     sc = SD_CARD_GET_CLASS(card);
>>>     readonly = sc->get_readonly(card);
>>>
>>>     sdbus_set_inserted(from, false);
>>>     qdev_set_parent_bus(DEVICE(card), &to->qbus);
>>>     sdbus_set_inserted(to, true);
>>>     sdbus_set_readonly(to, readonly);
>>> }
>>>
>>> What I don't understand is why create a sdcard with no block backend.
>>>
>>> Maybe this is old code before the null-co block backend existed? I
>>> haven't checked the git history yet.
>>>
>>> I'll try to restrict sdcard with only block backend and see if
>>> something break (I doubt) at least it simplifies the code.
>>> But I need to update the Aspeed machines first.
>>>
>>> The problem when not using block backend, is the size is 0,
>>> so the next patch abort in sd_reset() due to:
>>>
>>>   static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
>>>   {
>>>       assert(addr < sd->size);
>>>
>>
>>
> 

