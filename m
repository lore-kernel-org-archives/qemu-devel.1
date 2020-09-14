Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750DC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B73214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXQr83qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B73214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrPV-0002R9-JN
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHqqa-0001ne-TP; Mon, 14 Sep 2020 11:56:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHqqZ-0008LZ-2L; Mon, 14 Sep 2020 11:56:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id b79so569346wmb.4;
 Mon, 14 Sep 2020 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SjNoij3SVgbb0MXFGjZ8yOODynuVTkl7oY8Ssl1TkDs=;
 b=cXQr83qMMe8IUMfo9gegBeUDcvnZR4PePYuPouDrMzKQdKPZtc9OG7RcMUWTx5UCJc
 eN/pIHJi1I+iCf4/Pd5oKVKIY4bZOWnM+CSzFSPS/z4oJGl5QvZD3otvUtl1aL/vrUpr
 Y1r9ZouS9dqvVPV/On5Ay5Nk7J3Bq0q81BpfjwjNYdxUxckxLR8yaz2iDExueA9D7myU
 CL96L8N1kVNtIIAtqDxtWG7WKQ+zmBKlPYYySaA/bI9NiURhi63nQsW00WC4I8Ueql+b
 q+wZX5Ik69wn6awzcnkYnuBwF5CGsP5LkoYNwXjl7As823OsaGpjX3lMnyivvVyW08AY
 URTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SjNoij3SVgbb0MXFGjZ8yOODynuVTkl7oY8Ssl1TkDs=;
 b=orh3Od7feZXX9h2mtL7cm8/dg5p8CLlbi/+n5ustUxDuVH/Es+fl/BJNbi7zne9WFk
 m4fAQi9pqUWht3nxJ54bQCmH6BpKAu+HvDqYOyLkpMb4NIoI5WKLzg2EO74lYeqEWMoG
 M7Cen+fJBz+CTKXd3PaxNVGrxRyJOMPQfkDTTcaBmUq17SntwS5OCVhjZH+ulXYGXCUB
 Do5sYzxuemNsFnueMhBSty2w1sQB1YZnMGBkHT9r1cJV9Gk2+qPVSg33ZlbkbYCHVNy4
 pyaTISkmFL9JgTfcFGH90dZwvXhMJItz42KjDvCh845WyjGRaZQQ6Poj1jgvrtZrymDM
 2IXQ==
X-Gm-Message-State: AOAM531Usfms+IvjiN5Y3+fvUKvuVFhIs27RmwV89eXy0f5Ql68WmBs8
 Tv6mdJxP8/rCSvoKwCiiuL0=
X-Google-Smtp-Source: ABdhPJy/2cCGOtVgnO4zyfJlkD9w8LqIAiQni3HePpe/zw4CzViwgxBnWpLd+kBRMQRFf6f0bBZTEg==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr61042wmb.13.1600099008557;
 Mon, 14 Sep 2020 08:56:48 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 189sm20519466wmb.3.2020.09.14.08.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 08:56:47 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] hw/misc/led: Allow connecting from GPIO output
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-3-f4bug@amsat.org>
 <071b68a6-58e4-0d68-e056-ee7ae19e2227@linaro.org>
 <db55f80e-ca2d-d432-134b-a05333a7e124@amsat.org>
 <87imcg4y3l.fsf@dusky.pond.sub.org>
 <f451861f-fa21-6465-865e-9d5e42e165b5@amsat.org>
 <20200914140319.GA1618070@habkost.net>
 <5576befe-b616-f061-f384-6c4b1fde3323@amsat.org>
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
Message-ID: <11324359-53b7-4ce4-5ad7-2daaf615a5ba@amsat.org>
Date: Mon, 14 Sep 2020 17:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5576befe-b616-f061-f384-6c4b1fde3323@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 5:05 PM, Philippe Mathieu-Daudé wrote:
> On 9/14/20 4:03 PM, Eduardo Habkost wrote:
>> On Mon, Sep 14, 2020 at 09:48:45AM +0200, Philippe Mathieu-Daudé wrote:
>>> On 9/14/20 9:27 AM, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>>
>>>>> Eduardo is already in Cc, adding Markus.
>>>>>
>>>>> On 9/12/20 12:44 AM, Richard Henderson wrote:
>>>>>> On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
>>>>>>> Some devices expose GPIO lines.
>>>>>>>
>>>>>>> Add a GPIO qdev input to our LED device, so we can
>>>>>>> connect a GPIO output using qdev_connect_gpio_out().
>>>>>>>
>>>>>>> When used with GPIOs, the intensity can only be either
>>>>>>> minium or maximum. This depends of the polarity of the
>>>>>>> GPIO (which can be inverted).
>>>>>>> Declare the GpioPolarity type to model the polarity.
>>>>>>>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>>> ---
>>>>>>>  include/hw/misc/led.h  |  8 ++++++++
>>>>>>>  include/hw/qdev-core.h |  8 ++++++++
>>>>>>>  hw/misc/led.c          | 17 ++++++++++++++++-
>>>>>>>  3 files changed, 32 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>>>>>>> index f5afaa34bfb..71c9b8c59bf 100644
>>>>>>> --- a/include/hw/misc/led.h
>>>>>>> +++ b/include/hw/misc/led.h
>>>>>>> @@ -38,10 +38,16 @@ typedef struct LEDState {
>>>>>>>      /* Public */
>>>>>>>  
>>>>>>>      uint8_t intensity_percent;
>>>>>>> +    qemu_irq irq;
>>>>>>>  
>>>>>>>      /* Properties */
>>>>>>>      char *description;
>>>>>>>      char *color;
>>>>>>> +    /*
>>>>>>> +     * When used with GPIO, the intensity at reset is related
>>>>>>> +     * to the GPIO polarity.
>>>>>>> +     */
>>>>>>> +    bool inverted_polarity;
>>>>>>
>>>>>> Why are you not using the GpioPolarity enum that you added?
>>>>>
>>>>> Because it is migrated...
>>>>>
>>>>> Using DEFINE_PROP_BOOL() is simpler that adding hardware specific
>>>>> enum visitor in hw/core/qdev-properties.c (which is included in
>>>>> user-mode builds because pulled by the CPU type).
>>>>
>>>> Yes.
>>>>
>>>> You could also use DEFINE_PROP_UINT8(), and use it with your enumeration
>>>> constants.
>>>>
>>>> I'd be tempted to ditch the enum entirely.  Matter of taste, no big deal
>>>> either way.
>>>
>>> Done in v6!
>>>
>>>>
>>>>> A sane cleanup would be to make get_enum(), set_enum()
>>>>> and set_default_value_enum() public (prefixed with 'qdev_')
>>>>> in include/hw/qdev-properties.h.
>>>>
>>
>> Where and how exactly do you expect those functions to be used?
>> Having additional PropertyInfo structs defined manually would not
>> be desirable (especially if they are outside qdev*.c).  Having a
>> DEFINE_PROP_ENUM macro that does the enum magic behind the scenes
>> would be nice.
>>
>>>> Purpose?  To be able to define enum properties outside
>>>> qdev-properties.c?
>>>
>>> Yes, to avoid pulling in PCI and MAC address properties
>>> into qemu-storage-daemon and linux-user binaries...
>>
>> I don't understand what enum functions have to do with PCI and
>> MAC address properties.
> 
> My guess is that as get_enum()/set_enum()/set_default_value_enum()
> are static, enum properties using it ended in this core file:
> 
> const PropertyInfo qdev_prop_bios_chs_trans = {
>     .name = "BiosAtaTranslation",
>     .description = "Logical CHS translation algorithm, "
>                    "auto/none/lba/large/rechs",
>     .enum_table = &BiosAtaTranslation_lookup,
>     .get = get_enum,
>     .set = set_enum,
>     .set_default_value = set_default_value_enum,
> };
> 
> const PropertyInfo qdev_prop_fdc_drive_type = {
>     .name = "FdcDriveType",
>     .description = "FDC drive type, "
>                    "144/288/120/none/auto",
>     .enum_table = &FloppyDriveType_lookup,
>     .get = get_enum,
>     .set = set_enum,
>     .set_default_value = set_default_value_enum,
> };
> 
> const PropertyInfo qdev_prop_pcie_link_speed = {
>     .name = "PCIELinkSpeed",
>     .description = "2_5/5/8/16",
>     .enum_table = &PCIELinkSpeed_lookup,
>     .get = get_prop_pcielinkspeed,
>     .set = set_prop_pcielinkspeed,
>     .set_default_value = set_default_value_enum,
> };
> 
> Looking at qdev_prop_macaddr[] and qdev_prop_set_macaddr()
> maybe I was remembering incorrectly, it seems this one can
> be extracted easily.

Already done in "user-mode: Prune build dependencies (part 3)"
actually :)
https://www.mail-archive.com/qemu-devel@nongnu.org/msg688867.html

